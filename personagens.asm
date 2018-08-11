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
# $a0 -> endereço da célula contendo a posição do personagem anderior
# $a1 -> Cor do personagem
# $a2 -> Bitmap address
############# Retorna a posição atualizada#############
# $v0 -> Posição da célula atualizada
.macro mover_para_cima(%posIni,%corPers)
	add $a0,$zero,%posIni
	lw  $a1,%corPers
	lw  $a2,bitmap_address
	jal mover_para_cima_function
.end_macro
mover_para_cima_function:

	addi $t0,$a0,0     #Salvando endereço da célula em temporário
	addi $t1,$a1,0     #Salvando cor do personagem em temporário
	add $t2,$a2,$zero   #Somando o valor a o endereço base
	lw   $t3, corPreta #Carregando cor preta no registrador	

	add $t4,$a2,$t0    #Carregando endereço da célula junto com o base em $t4
	sw $t3,0($t4)      #Salvando a cor preta no endereço antigo
	
	##Dando um tempo de 0,5 segundos
	li $v0,32
	addi $a0,$zero,500 
	syscall
	
	addi $t0,$t0,-256 #Movendo pra sima
	add $t2,$t2,$t0 
	sw   $t1,0($t2)
	
	addi $v0,$t0,0    #retornando o endereço da célula	
	jr $ra
	
#### Procedimento para mover um peronagem para cima
# $a0 -> endereço contendo a posição do personagem anderior
# $a1 -> Cor do personagem
# $a2 -> Bitmap address
.macro mover_para_baixo(%posIni,%corPers)
	add $a0,$zero,%posIni
	lw  $a1,$zero,%corPers
	lw  $a2,$zero,bitmap_address
	jal mover_para_baixo_function
.end_macro
mover_para_baixo_function:

	addi $t0,$a0,0     #Salvando endereço em temporário
	addi $t1,$a1,0     #Salvando cor do personagem em temporário
	add $t0,$a2,$t0   #Somando o valor a o endereço base
	lw   $t3, corPreta #Carregando cor preta no registrador
	
	
	sw $t3,0($t0)      #Salvando a cor preta no endereço antigo
	
	##Dando um tempo de 0,5 segundos
	li $v0,32
	add $a0,$zero,500 
	syscall
	
	addi $t0,$t0,256 #Movendo pra sima
	sw $t1,0($t0)
	
	jr $ra	
	

