

.macro mover_pacman
 	lw $a0,corPac
 	lw $a1,key_board_addr
 	lw $a2,bitmap_address
 	jal mover_pacman_function
 .end_macro
 ##### Macros auxiliares para salvar registros utilizados pelo pacman
 .macro salvar_registros_mover_pacman
	addi  $sp,$sp,-16
	sw     $t0,0($sp)
	sw     $t1,4($sp)
	sw     $t2,8($sp)
	sw     $t3,12($sp)
.end_macro
# Macro auxiliar para pegar os regsitrso de ativação
.macro get_registros_mover_pacman
	lw     $t0,0($sp)
	lw     $t1,4($sp)
	lw     $t2,8($sp)
	lw     $t3,12($sp)
	addi  $sp,$sp,16
.end_macro
 #Macro auxiliar para definir a necessidade de incremento de pontos
 # É passado como argumento a cor da célula antes do pacman se deslocar para
 #ela
 .macro verificar_incremento_de_pontos(%corCelula)
			#Se o proximo movimetno for cor de comida
			add $t4,$zero,%corCelula
 			bne  $t4,0x00ffffff,exit_if_cor_comida
 				jal incrementar_pontos
 			exit_if_cor_comida: 			
 .end_macro 
 mover_pacman_function:	
 	save_return_address
 	addi $t0,$a0,0
 	addi $t1,$a1,0
 	addi $t2,$a2,0
 	
 	add  $t2,$t2,$s6
	#carregando valor do endereço do teclado
 	lw   $t3,0($t1)
 	
 	#w
 	bne $t3,119,mover_pac_direita
 	
 		salvar_registros_mover_pacman
 		verificar_movimento_valido($s6,-256)
 		get_registros_mover_pacman
 		
 		bne $v0,1,exit_sw_case_movimento_pac
 			#Carrega a cor da próxima célula a qual o pacman vai se mover
 			addi $t2,$t2,-256
 			lw   $t3,0($t2)
 			salvar_registros_mover_pacman
 			
 			mover_para_cima($s6,corPac)
 			addi $s6,$v0,0
 			
 			get_registros_mover_pacman 			
 			verificar_incremento_de_pontos($t3)
				
		j exit_sw_case_movimento_pac
	#d
 	mover_pac_direita:
 	bne $t3,100,mover_pac_baixo
	 	
	 	salvar_registros_mover_pacman
	 	verificar_movimento_valido($s6,4)
	 	get_registros_mover_pacman
	 	
 		bne $v0,1,exit_sw_case_movimento_pac
 			#Carrega a cor da próxima célula a qual o pacman vai se mover
 			addi $t2,$t2,4
 			lw   $t3,0($t2)
	 		
	 		salvar_registros_mover_pacman
	 		mover_para_direita($s6,corPac)
	 		addi $s6,$v0,0
	 		
	 		get_registros_mover_pacman
	 		verificar_incremento_de_pontos($t3)
				
		j exit_sw_case_movimento_pac
 	#s
 	mover_pac_baixo:
 	bne $t3,115,mover_pac_esquerda
 	
 		salvar_registros_mover_pacman
	 	verificar_movimento_valido($s6,256)
	 	get_registros_mover_pacman
	 	
 		bne $v0,1,exit_sw_case_movimento_pac
 			#Carrega a cor da próxima célula a qual o pacman vai se mover
 			addi $t3,$zero,0 #zerando $t3
 			addi $t2,$t2,256
 			lw   $t3,0($t2)
 			
			#verificar_incremento_de_pontos(256)
			salvar_registros_mover_pacman
	 		
	 		mover_para_baixo($s6,corPac)
	 		addi $s6,$v0,0 	
	 		
	 		get_registros_mover_pacman
	 		verificar_incremento_de_pontos($t3)
			
		j exit_sw_case_movimento_pac
 	#a
 	mover_pac_esquerda:
 	bne $t3,97,exit_sw_case_movimento_pac
 	
 		salvar_registros_mover_pacman
 		verificar_movimento_valido($s6,-4)
 		get_registros_mover_pacman
 		
 		bne $v0,1,exit_sw_case_movimento_pac	
 			#Carrega a cor da próxima célula a qual o pacman vai se mover
 			addi $t3,$zero,0 #zerando $t3
 			addi $t2,$t2,-4
 			lw   $t3,0($t2)
 			#verificar_incremento_de_pontos(-4)
 			salvar_registros_mover_pacman
 			
 			mover_para_esquerda($s6,corPac)
 			addi $s6,$v0,0 	
 			
 			get_registros_mover_pacman
 			verificar_incremento_de_pontos($t3)
			
 	exit_sw_case_movimento_pac:
 	
 	get_return_address
 	jr $ra