#########################################################
#                  Como rodar? 				#
#########################################################
# Tamanho de pixel : 8x8				#
# Dimensão do display: 512 x 256			#
# valor ask cacacteres A = 41, S = 53, D = 44, F = 46   #
#########################################################
#   O módulo principal é o pacman, rodar ele primeiro   #
#########################################################
#   em "settings -> memory configuration" setar valor   #
#   default.						#
#########################################################		

################ Movimentos Básicos #####################
#### Procedimento para mover um peronagem para cima
# $a0 -> endereço contendo a posição do personagem anderior
# $a1 -> Cor do personagem
# $a2 -> Bitmap address
.macro mover_para_cima(%posIni,%corPers)
	add $a0,$zero,%posIni
	add $a1,$zero,%corPers
	lw  $a2,$zero,bitmap_address
	jal mover_para_cima_function
.end_macro
mover_para_cima_function:

	addi $t0,$a0,0     #Salvando endereço em temporário
	addi $t1,$a1,0     #Salvando cor do personagem em temporário
	addi $t0,$a2,$t0   #Somando o valor a o endereço base
	lw   $t3, corPreta #Carregando cor preta no registrador
	
	
	sw $t3,0($t0)      #Salvando a cor preta no endereço antigo
	
	##Dando um tempo de 0,5 segundos
	li $v0,32
	addi $a0,500 
	syscall
	
	addi $t0,$t0,-256 #Movendo pra sima
	sw $t1,0($t0)
	
	jr $ra
	

