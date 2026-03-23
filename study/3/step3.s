.section .rodata.str,"aMS",@progbits,1
.align 1
.align 1
.LrQI_bytes:
	.string "Main"
.section .rodata.str,"aMS",@progbits,1
.align 1
.align 1
.LrQG_bytes:
	.string "main"
.section .data
.align 8
.align 1
.LrQH_closure:
	.quad	ghczmprim_GHCziTypes_TrNameS_con_info
	.quad	.LrQG_bytes
.section .data
.align 8
.align 1
.LrQJ_closure:
	.quad	ghczmprim_GHCziTypes_TrNameS_con_info
	.quad	.LrQI_bytes
.section .data
.align 8
.align 1
.globl Main_zdtrModule_closure
.type Main_zdtrModule_closure, @object
Main_zdtrModule_closure:
	.quad	ghczmprim_GHCziTypes_Module_con_info
	.quad	.LrQH_closure+1
	.quad	.LrQJ_closure+1
	.quad	3
.section .text
.align 8
.align 8
	.quad	0
	.long	21
	.long	base_GHCziNum_zdfNumInt_closure-(.LsTp_info)+0
.LsTp_info:
.LcTC:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb .LcTD
.LcTE:
	subq $8,%rsp
	movq %r13,%rax
	movq %rbx,%rsi
	movq %rax,%rdi
	xorl %eax,%eax
	call newCAF
	addq $8,%rsp
	testq %rax,%rax
	je .LcTB
.LcTA:
	movq $stg_bh_upd_frame_info,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq base_GHCziNum_zdfNumInt_closure(%rip),%r14
	movq $stg_ap_pp_info,-40(%rbp)
	movq $stg_INTLIKE_closure+593,-32(%rbp)
	movq $stg_INTLIKE_closure+593,-24(%rbp)
	addq $-40,%rbp
	jmp base_GHCziNum_zp_info
.LcTB:
	jmp *(%rbx)
.LcTD:
	jmp *-16(%r13)
	.size .LsTp_info, .-.LsTp_info
.section .data
.align 8
.align 1
.LsTp_closure:
	.quad	.LsTp_info
	.quad	0
	.quad	0
	.quad	0
.section .data
.align 8
.align 1
.LsTq_closure:
	.quad	base_GHCziIOziException_ExitFailure_con_info
	.quad	.LsTp_closure
	.quad	0
.section .data
.align 8
.align 1
.LuTU_srt:
	.quad	stg_SRT_2_info
	.quad	base_SystemziExit_exitWith_closure
	.quad	.LsTq_closure
	.quad	0
.section .text
.align 8
.align 8
	.quad	0
	.long	21
	.long	.LuTU_srt-(Main_main_info)+0
.globl Main_main_info
.type Main_main_info, @function
Main_main_info:
.LcTR:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb .LcTS
.LcTT:
	subq $8,%rsp
	movq %r13,%rax
	movq %rbx,%rsi
	movq %rax,%rdi
	xorl %eax,%eax
	call newCAF
	addq $8,%rsp
	testq %rax,%rax
	je .LcTQ
.LcTP:
	movq $stg_bh_upd_frame_info,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq .LsTq_closure+2(%rip),%r14
	leaq base_SystemziExit_exitWith_closure(%rip),%rbx
	addq $-16,%rbp
	jmp stg_ap_p_fast
.LcTQ:
	jmp *(%rbx)
.LcTS:
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
.LuUa_srt:
	.quad	stg_SRT_2_info
	.quad	base_GHCziTopHandler_runMainIO_closure
	.quad	Main_main_closure
	.quad	0
.section .text
.align 8
.align 8
	.quad	0
	.long	21
	.long	.LuUa_srt-(ZCMain_main_info)+0
.globl ZCMain_main_info
.type ZCMain_main_info, @function
ZCMain_main_info:
.LcU7:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb .LcU8
.LcU9:
	subq $8,%rsp
	movq %r13,%rax
	movq %rbx,%rsi
	movq %rax,%rdi
	xorl %eax,%eax
	call newCAF
	addq $8,%rsp
	testq %rax,%rax
	je .LcU6
.LcU5:
	movq $stg_bh_upd_frame_info,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq Main_main_closure(%rip),%r14
	leaq base_GHCziTopHandler_runMainIO_closure(%rip),%rbx
	addq $-16,%rbp
	jmp stg_ap_p_fast
.LcU6:
	jmp *(%rbx)
.LcU8:
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
