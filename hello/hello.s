.section .rodata.str,"aMS",@progbits,1
.align 1
.align 1
.LrHS_bytes:
	.string "Main"
.section .rodata.str,"aMS",@progbits,1
.align 1
.align 1
.LrHQ_bytes:
	.string "main"
.section .rodata.str,"aMS",@progbits,1
.align 1
.align 1
cKU_str:
	.string "Hello, Haskell!"
.section .data
.align 8
.align 1
.LsKQ_closure:
	.quad	stg_unpack_cstring_info
	.quad	0
	.quad	0
	.quad	0
	.quad	cKU_str
.section .data
.align 8
.align 1
.LuL5_srt:
	.quad	stg_SRT_2_info
	.quad	base_SystemziIO_putStrLn_closure
	.quad	.LsKQ_closure
	.quad	0
.section .text
.align 8
.align 8
	.quad	0
	.long	21
	.long	.LuL5_srt-(Main_main_info)+0
.globl Main_main_info
.type Main_main_info, @function
Main_main_info:
.LcL2:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb .LcL3
.LcL4:
	subq $8,%rsp
	movq %r13,%rax
	movq %rbx,%rsi
	movq %rax,%rdi
	xorl %eax,%eax
	call newCAF
	addq $8,%rsp
	testq %rax,%rax
	je .LcL1
.LcL0:
	movq $stg_bh_upd_frame_info,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq .LsKQ_closure(%rip),%r14
	leaq base_SystemziIO_putStrLn_closure(%rip),%rbx
	addq $-16,%rbp
	jmp stg_ap_p_fast
.LcL1:
	jmp *(%rbx)
.LcL3:
	jmp *-16(%r13)
	.size Main_main_info, .-Main_main_info
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
.section .data
.align 8
.align 1
.LuLl_srt:
	.quad	stg_SRT_2_info
	.quad	base_GHCziTopHandler_runMainIO_closure
	.quad	Main_main_closure
	.quad	0
.section .text
.align 8
.align 8
	.quad	0
	.long	21
	.long	.LuLl_srt-(ZCMain_main_info)+0
.globl ZCMain_main_info
.type ZCMain_main_info, @function
ZCMain_main_info:
.LcLi:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb .LcLj
.LcLk:
	subq $8,%rsp
	movq %r13,%rax
	movq %rbx,%rsi
	movq %rax,%rdi
	xorl %eax,%eax
	call newCAF
	addq $8,%rsp
	testq %rax,%rax
	je .LcLh
.LcLg:
	movq $stg_bh_upd_frame_info,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq Main_main_closure(%rip),%r14
	leaq base_GHCziTopHandler_runMainIO_closure(%rip),%rbx
	addq $-16,%rbp
	jmp stg_ap_p_fast
.LcLh:
	jmp *(%rbx)
.LcLj:
	jmp *-16(%r13)
	.size ZCMain_main_info, .-ZCMain_main_info
.section .data
.align 8
.align 1
.globl ZCMain_main_closure
.type ZCMain_main_closure, @object
ZCMain_main_closure:
	.quad	ZCMain_main_info
	.quad	0
	.quad	0
	.quad	0
.section .data
.align 8
.align 1
.LrHR_closure:
	.quad	ghczmprim_GHCziTypes_TrNameS_con_info
	.quad	.LrHQ_bytes
.section .data
.align 8
.align 1
.LrHT_closure:
	.quad	ghczmprim_GHCziTypes_TrNameS_con_info
	.quad	.LrHS_bytes
.section .data
.align 8
.align 1
.globl Main_zdtrModule_closure
.type Main_zdtrModule_closure, @object
Main_zdtrModule_closure:
	.quad	ghczmprim_GHCziTypes_Module_con_info
	.quad	.LrHR_closure+1
	.quad	.LrHT_closure+1
	.quad	3
.section .note.GNU-stack,"",@progbits
.ident "GHC 9.6.7"
