obter_tecla:
	lw $t0 0xFFFF0004		
obter_tecla_direita:
	move $s0, $t0
	li $v0 0x01000000
	jal obter_tecla_voltar
obter_tecla_voltar:
	li $t0, 0xFFFF0004
	sw $zero, ($t0)
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
