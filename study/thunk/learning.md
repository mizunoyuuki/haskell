Cコンパイラを書いていた。

https://github.com/mizunoyuuki/mcc 

掘れば掘るほどC言語の基本仕様はシンプルで簡単(libcを読みに行ったり、GCC拡張とかは別の話)



rubyのクロージャとか遅延評価とかの元になっている関数型言語のそれら仕組みが気になった。

アセンブリに慣れたので、クロージャ、遅延評価がどういう構造、仕組みで動いているのか覗いてみる。

最初の理解

クロージャ
- その場の簡易クラスインスタンス、データとメソッドを一括りにした構造体的なもの。

遅延評価
- 関数を書いても、実際にデータが必要とされる瞬間まで実行しない





そもそもHaskellとは、

純粋関数型プログラミング言語 ??

=> これが指す意味はよくわからない。

=> 副作用を許さない仕様,  強い型システム



トップレベルの定義はすべてクロージャ



Cと違って面白いアセンブリを吐く。

STGマシンと呼ばれる仕組みにのっとったバイナリ。独自ランタイムで事前確保したヒープ領域を使う。

今のヒープのベースポインタがどこか、といった状態を以下レジスタを使って管理する。

  r12          Hp  = ヒープポインタ（次の空き位置)

  r13          ベースレジスタ (RTSの内部状態の構造体へのポインタ)

  r14.         STGマシンのレベルでの第一引数レジスタ


  r15          HpLim = ヒープ上限（ここを超えたらGC発動）
  rbp          Sp  = STGスタックポインタ
  rbx          Node = 現在のクロージャ

＝＞この辺の処理はランタイムが設定してくれる。

仕組み。

クロージャは

データが核にあって、それに紐づくコード(.text)がある。



Cの場合は、バイナリにこれといった仕様がなく、マシンの動きに合わせてバイナリ作りました。みたいなバイナリ。

あるとすれば、rbpとかをスタックマシンの仕組みでpush, popしてフレームスタックを管理したりする仕組み。



Haskellの世界では、call命令を使わず、すべてjmp命令を使う。

ランタイムの中では、Cのソースが使われており、call命令が使われていた。



アセンブリにするとちょっと長い(言語仕様的にクロージャをデータ構造として持っている、言語語レベルで並列処理をサポートしている。RTSが自前のスケジューラを持っている。



mizuno@my-cheap-pc:~/haskell/study/thunk (feature/introduction)$ cat thunk.hs
module Main where

x :: Int
x = 21 + 21

main :: IO()
main = x `seq` return()

=> 意味的には

xはInt型であると定義
x は 21 + 21であるという定義 => これを定義したとしても、まだ実行されない( = 遅延評価 )
mainは、IO() 型であると定義
mainとは、xを実行し,returnして処理が終わるものである。という定義。

=> ソースコードはすべて定義でしかない。実行する。という意味は書かれていない。



rubyのBoxで例えると

x = -> { 21 + 21 }

pp x.call



これがどんなアセンブリになるのか

ghc -S thunk.hs



エントリポイントのクロージャ

#### エントリポイントのクロージャーのテキストセグメント(実行できる場所)
.section .text
.align 8
.align 8
	.quad	0
	.long	21
	.long	.LuLt_srt-(ZCMain_main_info)+0
.globl ZCMain_main_info
.type ZCMain_main_info, @function
ZCMain_main_info:
.LcLq:
	leaq -16(%rbp),%rax   =>%rbpにはSTGマシン仕様では、haskellで使うスタックポインタが入ってる。
	cmpq %r15,%rax 　　　　=> %r15は、ヒープ上限（ここを超えたらGC発動）が入ってる。
	jb .LcLr
.LcLs:
	subq $8,%rsp          => スタックポインタを8バイト下げて16バイトアライメントに合わせる
	movq %r13,%rax        => raxに退避（C関数に飛んでいくのでHaskell）
	movq %rbx,%rsi　　     => 現在のクロージャのアドレスを引数で渡す
	movq %rax,%rdi　　　　　=> RTSの管理構造体のアドレスを引数で渡す
	xorl %eax,%eax
	call newCAF           => トップレベル定義のサンクを管理するRTS関数。
    => 他スレッドでrsiで受け取ったクロージャが評価中かどうか、フラグ管理してる。 
	addq $8,%rsp          => スタックポインタを8バイトあげて元に戻す
	testq %rax,%rax       => %raxが0以外なら1, 0なら0. newCAFがスレッド並行で実行している時に効く
	je .LcLp              => %raxが0の時(他のスレッドがこのサンクを評価中).LcLpへジャンプ
.LcLo:
	movq $stg_bh_upd_frame_info,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq Main_main_closure(%rip),%r14      => STGマシンレベルでの、第1引数レジスタ
	leaq base_GHCziTopHandler_runMainIO_closure(%rip),%rbx => 次に実行するクロージャ
	addq $-16,%rbp                                         => スタックポインタを下げる
	jmp stg_ap_p_fast                      
    => どこか飛んでいく。jmp命令なのでどこに戻ってくるかこのままではわからないが
    => Main_main_closureのtextが実行される。
.LcLp:
	jmp *(%rbx) => 評価中の場合は、この先が書き換わっているため、ランタイムのどこかのコードに飛ばされる。
.LcLr:
	jmp *-16(%r13) => %r13にはRTSにアクセスするためのアドレスが入ってる。
                   => スタック領域を拡張するGC関数へのアドレスだと思う。
	.size ZCMain_main_info, .-ZCMain_main_info


#### エントリポイントのクロージャのデータセグメント
.section .data
.align 8
.align 1
.globl ZCMain_main_closure
.type ZCMain_main_closure, @object
ZCMain_main_closure:
	.quad	ZCMain_main_info => テキストセグメントのアドレスを保持, マルチスレッド実行でこのアドレスを書き換える。
	.quad	0
	.quad	0
	.quad	0
.section .note.GNU-stack,"",@progbits
.ident "GHC 9.6.7"

=> ZC、ネームマングリングといって同じ関数名にならないように上手いことコンパイラが管理、設定してくれる接頭辞. C++とかでもある

       =>言語仕様としてマルチスレッド実行がサポートされているため、アセンブリでもそれを前提とした命令が吐かれる。

 　　=>  サンクは一度評価したら結果を保存して、二度目以降は再計算しないような実装。



ソースで書いたmainモジュールのクロージャ

#### Main_mainクロージャのテキストセクション

.section .text
.align 8
.align 8
	.quad	0
	.long	21
	.long	.LuLd_srt-(Main_main_info)+0
.globl Main_main_info
.type Main_main_info, @function
Main_main_info:
.LcL7:
	leaq -32(%rbp),%rax   => 32バイトスタックポインタをズラす。
	cmpq %r15,%rax        => 上限と比較。
	jb .LcL8              => 足りない場合は、LcL8に飛んでRTSのスタック拡張関数を実行する。
.LcL9:
	subq $8,%rsp          => 8バイトスタックを下げる
	movq %r13,%rax        => raxにr13の値を入れておく
	movq %rbx,%rsi        => rsiに現在のクロージャのアドレス
	movq %rax,%rdi        => rdiに
	xorl %eax,%eax
	call newCAF           => 現在のクロージャが評価されているかどうかチェック
	addq $8,%rsp
	testq %rax,%rax
	je .LcL3              => 評価されている途中の場合は、LcL3へジャンプ
.LcL2:
	movq $stg_bh_upd_frame_info,-16(%rbp)
	movq %rax,-8(%rbp)
	movq $.LcL4_info,-24(%rbp)
	leaq Main_x_closure(%rip),%rbx   =>  Main_x_clousureを現在のクロージャに変更
	addq $-24,%rbp
	testb $7,%bl       
    =>  %blレジスタは,%rbxの下位8ビット、ここが評価済みの場合は001、未評価の場合は000となってる。
    =>  7は、00...111のため、andとって1なら評価ずみ、０なら未評価
	jne .LcL4　=> not equal => 直前の結果が1の場合は、LcL4へ飛ぶ
.LcL5:
	jmp *(%rbx) => Main_x_clousureのアドレスへジャンプ
.LcL3:
	jmp *(%rbx)
.align 8
	.quad	0
	.long	30
	.long	base_GHCziBase_zdfMonadIO_closure-(.LcL4_info)+0
.LcL4_info:
.LcL4:
    => Main_x_clousureが評価済みだった場合。
	leaq base_GHCziBase_zdfMonadIO_closure(%rip),%r14 => 第一引数はモナドIOの処理をするものであることを渡す
	movq $stg_ap_p_info,-8(%rbp)
	movq $ghczmprim_GHCziTupleziPrim_Z0T_closure+1,(%rbp)
	addq $-8,%rbp
	jmp base_GHCziBase_return_info                     => baseライブラリのreturn関数へジャンプ
.LcL8:
	jmp *-16(%r13)
	.size Main_main_info, .-Main_main_info

#### Main_main_クロージャのデータセクション
.section .data
.align 8
.align 1
.globl Main_main_closure
.type Main_main_closure, @object
Main_main_closure:
	.quad	Main_main_info
	.quad	0
	.quad	0
	.quad	0


=>モナドIOって何？

モナド、副作用をモナド型の処理としてくるっとまとめている。

return は Monad 型クラス（インターフェース）の関数



Main_x_clousure

.section .text
.align 8
.align 8
	.quad	0
	.long	21
	.long	base_GHCziNum_zdfNumInt_closure-(Main_x_info)+0
.globl Main_x_info
.type Main_x_info, @function
Main_x_info:
.LcKQ:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb .LcKR
.LcKS:
	subq $8,%rsp
	movq %r13,%rax
	movq %rbx,%rsi
	movq %rax,%rdi
	xorl %eax,%eax
	call newCAF
	addq $8,%rsp
	testq %rax,%rax
	je .LcKP
.LcKO:
	movq $stg_bh_upd_frame_info,-16(%rbp)
	movq %rax,-8(%rbp)                              => newCAFの返り値
	leaq base_GHCziNum_zdfNumInt_closure(%rip),%r14 => 第一引数にはInt型を示す引数。
	movq $stg_ap_pp_info,-40(%rbp)
	movq $stg_INTLIKE_closure+593,-32(%rbp)         => 整数のキャッシュ配列......21を指している
	movq $stg_INTLIKE_closure+593,-24(%rbp)         => 21をスタックポインタの-24, -32のオフセットにおく。
	addq $-40,%rbp                                  => スタックポインタを下げる
	jmp base_GHCziNum_zp_info =>  +  を処理するアドレスにjmp(RTSがNumのインターフェースとして＋を定義している)
.LcKP:
	jmp *(%rbx)
.LcKR:
	jmp *-16(%r13)
	.size Main_x_info, .-Main_x_info

    
.section .data
.align 8
.align 1
.globl Main_x_closure
.type Main_x_closure, @object
Main_x_closure:
	.quad	Main_x_info
	.quad	0
	.quad	0
	.quad	0



なんとなくアセンブリと合わせて読んでみる。

module Main where  => これは省略してもいいらしい Main_main_clousureになる。

x :: Int    => Main_x_clousureのテキストセグメントに配置される。RTS関数の引数になる
x = 21 + 21  =>  Main_x_clousureのテキストセグメント。RTS関数の引数. + はRTSの+関数を呼ぶ。

main :: IO()   => Main_main_clousure定義。IO()ってなんだっけ。
main = x seq return() => Main_main_clousureのテキストセグメントないのMain_x_clousureを実行するアセンブリに変換されて得そう。



クロージャは以下のような流れを辿る

  評価前（サンク）:
  Main_x_closure:
      .quad   Main_x_info       ← 「計算せよ」
      .quad   0

+ 関数が呼ばれる。

  評価後（コンストラクタ）:
  Main_x_closure:
      .quad   I#_con_info        ← 「値がある」
      .quad   42




