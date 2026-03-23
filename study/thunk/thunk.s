.section .rodata.str,"aMS",@progbits,1
.align 1
.align 1
.LrHW_bytes:
	.string "Main"
.section .rodata.str,"aMS",@progbits,1
.align 1
.align 1
.LrHU_bytes:
	.string "main"
.section .data
.align 8
.align 1
.LrHV_closure:
	.quad	ghczmprim_GHCziTypes_TrNameS_con_info
	.quad	.LrHU_bytes
.section .data
.align 8
.align 1
.LrHX_closure:
	.quad	ghczmprim_GHCziTypes_TrNameS_con_info
	.quad	.LrHW_bytes
.section .data
.align 8
.align 1
.globl Main_zdtrModule_closure
.type Main_zdtrModule_closure, @object
Main_zdtrModule_closure:
	.quad	ghczmprim_GHCziTypes_Module_con_info
	.quad	.LrHV_closure+1
	.quad	.LrHX_closure+1
	.quad	3
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
	movq %rax,-8(%rbp)
	leaq base_GHCziNum_zdfNumInt_closure(%rip),%r14
	movq $stg_ap_pp_info,-40(%rbp)
	movq $stg_INTLIKE_closure+593,-32(%rbp)
	movq $stg_INTLIKE_closure+593,-24(%rbp)
	addq $-40,%rbp
	jmp base_GHCziNum_zp_info
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
.section .data
.align 8
.align 1
.LuLd_srt:
	.quad	stg_SRT_2_info
	.quad	Main_x_closure
	.quad	base_GHCziBase_zdfMonadIO_closure
	.quad	0
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
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb .LcL8
.LcL9:
	subq $8,%rsp
	movq %r13,%rax
	movq %rbx,%rsi
	movq %rax,%rdi
	xorl %eax,%eax
	call newCAF
	addq $8,%rsp
	testq %rax,%rax
	je .LcL3
.LcL2:
	movq $stg_bh_upd_frame_info,-16(%rbp)
	movq %rax,-8(%rbp)
	movq $.LcL4_info,-24(%rbp)
	leaq Main_x_closure(%rip),%rbx
	addq $-24,%rbp
	testb $7,%bl
	jne .LcL4
.LcL5:
	jmp *(%rbx)
.LcL3:
	jmp *(%rbx)
.align 8
	.quad	0
	.long	30
	.long	base_GHCziBase_zdfMonadIO_closure-(.LcL4_info)+0
.LcL4_info:
.LcL4:
	leaq base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq $stg_ap_p_info,-8(%rbp)
	movq $ghczmprim_GHCziTupleziPrim_Z0T_closure+1,(%rbp)
	addq $-8,%rbp
	jmp base_GHCziBase_return_info
.LcL8:
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
.LuLt_srt:
	.quad	stg_SRT_2_info
	.quad	base_GHCziTopHandler_runMainIO_closure
	.quad	Main_main_closure
	.quad	0
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
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb .LcLr
.LcLs:
	subq $8,%rsp
	movq %r13,%rax
	movq %rbx,%rsi
	movq %rax,%rdi
	xorl %eax,%eax
	call newCAF
	addq $8,%rsp
	testq %rax,%rax
	je .LcLp
.LcLo:
	movq $stg_bh_upd_frame_info,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq Main_main_closure(%rip),%r14
	leaq base_GHCziTopHandler_runMainIO_closure(%rip),%rbx
	addq $-16,%rbp
	jmp stg_ap_p_fast
.LcLp:
	jmp *(%rbx)
.LcLr:
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
.section .note.GNU-stack,"",@progbits
.ident "GHC 9.6.7"
