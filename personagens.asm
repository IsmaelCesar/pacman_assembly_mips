#########################################################
#                  Como rodar? 				#
#########################################################
# Tamanho de pixel : 8x8				#
# Dimens�o do display: 512 x 256			#
# valor ask cacacteres A = 41, S = 53, D = 44, F = 46   #
#########################################################
#   O m�dulo principal � o pacman, rodar ele primeiro   #
#########################################################
#   em "settings -> memory configuration" setar valor   #
#   default.						#
#########################################################		

################Paralizando tempo ######################
#Procedimento para pausar o tempo simulando um movimento
#$a0 -> Tempo em milisegundos o qual se deseja pausar
.macro sleep(%tempo)
	add $a0,$zero,%tempo
	jal sleep_function
.end_macro
sleep_function:
	lw $v0,32
	syscall
	
	jr $ra

################ Movimentos B�sicos #####################
#### Procedimento para mover um peronagem para cima
# $a0 -> endere�o da c�lula contendo a posi��o do personagem anderior
# $a1 -> Cor do personagem
# $a2 -> Bitmap address
############# Retorna a posi��o atualizada#############
# $v0 -> Posi��o da c�lula atualizada
.macro mover_para_cima(%posIni,%corPers)
	add $a0,$zero,%posIni
	lw  $a1,%corPers
	lw  $a2,bitmap_address
	jal mover_para_cima_function
.end_macro
mover_para_cima_function:

	addi $t0,$a0,0     #Salvando endere�o da c�lula em tempor�rio
	addi $t1,$a1,0     #Salvando cor do personagem em tempor�rio
	add $t2,$a2,$zero   #Somando o valor a o endere�o base
	lw   $t3, corPreta #Carregando cor preta no registrador	

	add $t4,$a2,$t0    #Carregando endere�o da c�lula junto com o base em $t4
	sw $t3,0($t4)      #Salvando a cor preta no endere�o antigo
	
	##Dando um tempo de 0,5 segundos
	sleep(500)
	
	addi $t0,$t0,-256 #Movendo pra cima
	add $t2,$t2,$t0 
	sw   $t1,0($t2)
	
	addi $v0,$t0,0    #retornando o endere�o da c�lula	
	jr $ra
	
########################################################
#### Procedimento para mover um peronagem para cima
# $a0 -> endere�o da c�lula contendo a posi��o do personagem anderior
# $a1 -> Cor do personagem
# $a2 -> Bitmap address
############# Retorna a posi��o atualizada#############
# $v0 -> Posi��o da c�lula atualizada
.macro mover_para_baixo(%posIni,%corPers)
	add $a0,$zero,%posIni
	lw  $a1,%corPers
	lw  $a2,bitmap_address
	jal mover_para_baixo_function
.end_macro
mover_para_baixo_function:

	addi $t0,$a0,0     #Salvando endere�o da c�lula em tempor�rio
	addi $t1,$a1,0     #Salvando cor do personagem em tempor�rio
	add $t2,$a2,$zero   #Somando o valor a o endere�o base
	lw   $t3, corPreta #Carregando cor preta no registrador	

	add $t4,$a2,$t0    #Carregando endere�o da c�lula junto com o base em $t4
	sw $t3,0($t4)      #Salvando a cor preta no endere�o antigo
	
	##Dando um tempo de 0,5 segundos
	sleep(500)
	
	addi $t0,$t0,256 #Movendo pra baixo
	add $t2,$t2,$t0 
	sw   $t1,0($t2)
	
	addi $v0,$t0,0    #retornando o endere�o da c�lula	
	jr $ra

########################################################
#### Procedimento para mover um peronagem para cima
# $a0 -> endere�o da c�lula contendo a posi��o do personagem anderior
# $a1 -> Cor do personagem
# $a2 -> Bitmap address
############# Retorna a posi��o atualizada#############
# $v0 -> Posi��o da c�lula atualizada
.macro mover_para_direita(%posIni,%corPers)
	add $a0,$zero,%posIni
	lw  $a1,%corPers
	lw  $a2,bitmap_address
	jal mover_para_direita_function
.end_macro
mover_para_direita_function:

	addi $t0,$a0,0     #Salvando endere�o da c�lula em tempor�rio
	addi $t1,$a1,0     #Salvando cor do personagem em tempor�rio
	add $t2,$a2,$zero   #Somando o valor a o endere�o base
	lw   $t3, corPreta #Carregando cor preta no registrador	

	add $t4,$a2,$t0    #Carregando endere�o da c�lula junto com o base em $t4
	sw $t3,0($t4)      #Salvando a cor preta no endere�o antigo
	
	##Dando um tempo de 0,5 segundos
	sleep(500)
	
	addi $t0,$t0,4    #Movendo pra direita
	add  $t2,$t2,$t0 
	sw   $t1,0($t2)
	
	addi $v0,$t0,0    #retornando o endere�o da c�lula	
	jr $ra
	
########################################################
#### Procedimento para mover um peronagem para cima
# $a0 -> endere�o da c�lula contendo a posi��o do personagem anderior
# $a1 -> Cor do personagem
# $a2 -> Bitmap address
############# Retorna a posi��o atualizada#############
# $v0 -> Posi��o da c�lula atualizada
.macro mover_para_esquerda(%posIni,%corPers)
	add $a0,$zero,%posIni
	lw  $a1,%corPers
	lw  $a2,bitmap_address
	jal mover_para_esquerda_function
.end_macro
mover_para_esquerda_function:

	addi $t0,$a0,0     #Salvando endere�o da c�lula em tempor�rio
	addi $t1,$a1,0     #Salvando cor do personagem em tempor�rio
	add $t2,$a2,$zero   #Somando o valor a o endere�o base
	lw   $t3, corPreta #Carregando cor preta no registrador	

	add $t4,$a2,$t0    #Carregando endere�o da c�lula junto com o base em $t4
	sw $t3,0($t4)      #Salvando a cor preta no endere�o antigo
	
	##Dando um tempo de 0,5 segundos
	sleep(500)
	
	addi $t0,$t0,-4 #Movendo pra esquerda
	add $t2,$t2,$t0 
	sw   $t1,0($t2)
	
	addi $v0,$t0,0    #retornando o endere�o da c�lula	
	jr $ra

###############Verificar movimento v�lido
#Procedimento para fazer a verifica��o de movimento v�lido de um personagem
# $a0 -> Argumento com movimento 1
# $a1 -> Argumento com movimento 2
# $a2 -> Argumento com a cor do personagem
###########Retorna 1 se o personagem estiver num corredor
# $v0 -> Retorno indicando se o personagem est� num corredor
.macro verificar_corredor(%primeiroMov,%segundoMov,%cor)
	add $a0,$zero,%primeiroMov
	add $a1,$zero,%segundoMov
	add $a2,$zero,%cor
	jal verificar_corredor_function
.end_macro
verificar_corredor_function:
	#Salvando em temporarios
	addi $t0,$a0,0
	addi $t1,$a1,0
	addi $t2,$a2,0
	
	#carregando cores armazenadas nas c�lulas
	lw  $t3,0($t0)
	lw  $t4,0($t1)
	lw  $t5,cor_mapa
	addi $v0,$zero,0 #zerando retorno
	
	# Se os lados do personagem forem da cor do mapa ent�o trata-se de um corredor
	seq $t6,$t3,$t5
	seq $t6,$t4,$t5
	beq $t6,0,exit_is_corredor
		addi $v0,$zero,1
	exit_is_corredor:
	
	jr $ra

#######################Efetuando movimento dos fantasmaas #############
#Se o pr�ximo movimento n�o for um movimento v�lido, o fantasma continua
#com o movimento anterior
# $a0 -> Arqugmento com o endere�o da c�lula em que o fantasminha est�
# $a1 -> Argumento com a cor do fantasma
# $a2 -> argumento com o movimento anterior do fantasma
# $a3 -> argumento com o bitmap_address
#########Retorna a nova posicao do fantasma##########
# $v0 -> Retorno
.macro mover_fantasma(%endIni,%corFant,%movAnt)
	add $a0,$zero,%endIni
	lw  $a1, %corFant
	add $a2,$zero,%movAnt
	lw  $a3,bitmap_address
	jal mover_fantasma_function
.end_macro
mover_fantasma_function:
	addi $sp,$sp,-4
	sw   $ra,0($sp)
	#Salvando valores em tempor�rios
	addi $t0,$a0,0
	addi $t1,$a1,0
	addi $t2,$a2,0
	addi $t3,$a3,0
	############## SW_CASE para verificar corredor
	seq  $t4,$t3,4
	seq  $t5,$t3,-4
	or   $t6,$t4,$t4 #se o personagem estiver indo pra esquerda ou para direita
	beq  $t2,4,case_ir_cima_baixo
						

	case_ir_cima_baixo:	
	beq  $t2,-256,case_ir_baixo
		
		j end_switch
	case_ir_baixo:
	
	end_switch:
	
	#############
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
	
	
	