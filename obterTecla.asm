
.text


.macro verificaTecla(%tecla)
	beq %tecla, 0x00000061, praEsquerda #pra esquerda a
	#beq %tecla, 0x00000064, praDireita #direita d
	#beq %tecla, 0x00000073, praBaixo #para baixo s
	#beq %tecla, 0x00000077, praCima #pra cima w
.end_macro

obter_tecla:
	sw $v0, 0xFFFF0004
	lw $t0 0xFFFF0004		
obter_tecla_direita:
	move $s5, $t0
	li $v0 0x01000000
	jal obter_tecla_voltar
obter_tecla_voltar:
	li $t0, 0xFFFF0004
	sw $zero, ($t0)
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

praEsquerda: 
	mover_para_esquerda($s6,corPac)
	addi $s6,$v0,0   #Salvando posi��o atualizada do pacman		
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
