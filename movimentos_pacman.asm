

.macro mover_pacman
 	lw $a0,corPac
 	lw $a1,key_board_addr
 	lw $a2,bitmap_address
 	jal mover_pacman_function
 .end_macro
 mover_pacman_function:	
 	save_return_address
 	addi $t0,$a0,0
 	addi $t1,$a1,0
 	addi $t2,$a2,0
 	
 	add  $t2,$t2,$s2
	#carregando valor do endereço do teclado
 	lw   $t2,0($t1)
 	
 	#w
 	bne $t2,119,mover_pac_direita
 		
 		verificar_movimento_valido($s6,-256)
 		bne $v0,1,exit_sw_case_movimento_pac				
			mover_para_cima($s6,corPac)
			addi $s6,$v0,0	
		j exit_sw_case_movimento_pac
	#d
 	mover_pac_direita:
 	bne $t2,100,mover_pac_baixo
	 	
	 	verificar_movimento_valido($s6,4)
 		bne $v0,1,exit_sw_case_movimento_pac
	 		mover_para_direita($s6,corPac)
			addi $s6,$v0,0	
		j exit_sw_case_movimento_pac
 	#s
 	mover_pac_baixo:
 	bne $t2,115,mover_pac_esquerda
	 	verificar_movimento_valido($s6,256)
 		bne $v0,1,exit_sw_case_movimento_pac
	 		mover_para_baixo($s6,corPac)
			addi $s6,$v0,0 	
		j exit_sw_case_movimento_pac
 	#a
 	mover_pac_esquerda:
 	bne $t2,97,exit_sw_case_movimento_pac
 		verificar_movimento_valido($s6,-4)
 		bne $v0,1,exit_sw_case_movimento_pac	
 			mover_para_esquerda($s6,corPac)
			addi $s6,$v0,0 	
 	exit_sw_case_movimento_pac:
 	
 	get_return_address
 	jr $ra
 	
#.globl main
#main:
#addi $s6,$zero,4416

#lw $t0, bitmap_address
#lw $t2, corPac
#addi $t1,$zero,4416
#add $t1,$t0,$t1
#sw $t2,0($t1)#

#desenhar_obstaculo(2084,14,4,cor_mapa,bitmap_address)

#loop_infinito:
	#mover_pacman
#j loop_infinito


