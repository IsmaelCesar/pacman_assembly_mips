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
#             Outras configurações			#
#########################################################
# $s7 -> Armazenará acor da comida, pro caso de um      #
#        fantasma se mover sobre ela			#
# $s6 -> Armazenará a posição do pacman			#
# $s0 -> Guardará os pontons                            #
# $s1,$s2,$s3,$s4 -> Guardará a posição da célula dos   #
# 		     dos fantasmas no seu respectivo    #
#		     estágio(Vermelho,Azul,Laranja,Rosa)#
#########################################################

################Paralizando tempo ######################
#Procedimento para pausar o tempo simulando um movimento
#$a0 -> Tempo em milisegundos o qual se deseja pausar
.macro sleep(%tempo)
	add $a0,$zero,%tempo
	jal sleep_function
.end_macro
sleep_function:
	li $v0,32
	syscall	
	jr $ra

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
	addi $sp,$sp,-4
	sw   $ra,0($sp)
	###############

	addi $t0,$a0,0     #Salvando endereço da célula em temporário
	addi $t1,$a1,0     #Salvando cor do personagem em temporário
	add $t2,$a2,$zero   #Somando o valor a o endereço base
	lw   $t3, corPreta #Carregando cor preta no registrador	

	##Dando um tempo de 0,5 segundos
	sleep(500)
	
	add $t4,$a2,$t0    #Carregando endereço da célula junto com o base em $t4
	sw $t3,0($t4)      #Salvando a cor preta no endereço antigo
		
	addi $t0,$t0,-256 #Movendo pra cima
	add $t2,$t2,$t0 
	sw   $t1,0($t2)
	
	###############
	lw   $ra,0($sp)
	addi $sp,$sp,4	
	addi $v0,$t0,0    #retornando o endereço da célula	
	jr $ra
	
########################################################
#### Procedimento para mover um peronagem para cima
# $a0 -> endereço da célula contendo a posição do personagem anderior
# $a1 -> Cor do personagem
# $a2 -> Bitmap address
############# Retorna a posição atualizada#############
# $v0 -> Posição da célula atualizada
.macro mover_para_baixo(%posIni,%corPers)
	add $a0,$zero,%posIni
	lw  $a1,%corPers
	lw  $a2,bitmap_address
	jal mover_para_baixo_function
.end_macro
mover_para_baixo_function:
	addi $sp,$sp,-4
	sw   $ra,0($sp)
	###############

	addi $t0,$a0,0     #Salvando endereço da célula em temporário
	addi $t1,$a1,0     #Salvando cor do personagem em temporário
	add $t2,$a2,$zero   #Somando o valor a o endereço base
	lw   $t3, corPreta #Carregando cor preta no registrador	

	##Dando um tempo de 0,5 segundos
	sleep(500)
	
	add $t4,$a2,$t0    #Carregando endereço da célula junto com o base em $t4
	sw $t3,0($t4)      #Salvando a cor preta no endereço antigo
		
	addi $t0,$t0,256 #Movendo pra baixo
	add $t2,$t2,$t0 
	sw   $t1,0($t2)
	
	###############
	lw   $ra,0($sp)
	addi $sp,$sp,4	
	addi $v0,$t0,0    #retornando o endereço da célula	
	jr $ra

########################################################
#### Procedimento para mover um peronagem para cima
# $a0 -> endereço da célula contendo a posição do personagem anderior
# $a1 -> Cor do personagem
# $a2 -> Bitmap address
############# Retorna a posição atualizada#############
# $v0 -> Posição da célula atualizada
.macro mover_para_direita(%posIni,%corPers)
	add $a0,$zero,%posIni
	lw  $a1,%corPers
	lw  $a2,bitmap_address
	jal mover_para_direita_function
.end_macro
mover_para_direita_function:
	addi $sp,$sp,-4
	sw   $ra,0($sp)
	###############

	addi $t0,$a0,0     #Salvando endereço da célula em temporário
	addi $t1,$a1,0     #Salvando cor do personagem em temporário
	add $t2,$a2,$zero   #Somando o valor a o endereço base
	lw   $t3, corPreta #Carregando cor preta no registrador	

	##Dando um tempo de 0,5 segundos
	sleep(500)

	add $t4,$a2,$t0    #Carregando endereço da célula junto com o base em $t4
	sw $t3,0($t4)      #Salvando a cor preta no endereço antigo
	
	addi $t0,$t0,4    #Movendo pra direita
	add  $t2,$t2,$t0 
	sw   $t1,0($t2)
	
	###############
	lw   $ra,0($sp)
	addi $sp,$sp,4	
	addi $v0,$t0,0    #retornando o endereço da célula	
	jr $ra
	
########################################################
#### Procedimento para mover um peronagem para cima
# $a0 -> endereço da célula contendo a posição do personagem anderior
# $a1 -> Cor do personagem
# $a2 -> Bitmap address
############# Retorna a posição atualizada#############
# $v0 -> Posição da célula atualizada
.macro mover_para_esquerda(%posIni,%corPers)
	add $a0,$zero,%posIni
	lw  $a1,%corPers
	lw  $a2,bitmap_address
	jal mover_para_esquerda_function
.end_macro
mover_para_esquerda_function:
	addi $sp,$sp,-4
	sw   $ra,0($sp)
	###############

	addi $t0,$a0,0     #Salvando endereço da célula em temporário
	addi $t1,$a1,0     #Salvando cor do personagem em temporário
	add $t2,$a2,$zero   #Somando o valor a o endereço base
	lw   $t3, corPreta #Carregando cor preta no registrador	

	##Dando um tempo de 0,5 segundos
	sleep(500)
		
	add $t4,$a2,$t0    #Carregando endereço da célula junto com o base em $t4
	sw $t3,0($t4)      #Salvando a cor preta no endereço antigo
	
	addi $t0,$t0,-4 #Movendo pra esquerda
	add $t2,$t2,$t0 
	sw   $t1,0($t2)
	
	###############
	lw   $ra,0($sp)
	addi $sp,$sp,4	
	addi $v0,$t0,0    #retornando o endereço da célula	
	jr $ra

###############Verificar movimento válido
#Procedimento para fazer a verificação de movimento válido de um personagem
# $a0 -> Argumento com movimento 1
# $a1 -> Argumento com movimento 2
# $a2 -> Argumento com a cor do personagem
###########Retorna 1 se o personagem estiver num corredor
# $v0 -> Retorno indicando se o personagem está num corredor
.macro verificar_corredor(%primeiroMov,%segundoMov)
	add $a0,$zero,%primeiroMov
	add $a1,$zero,%segundoMov
	jal verificar_corredor_function
.end_macro
verificar_corredor_function:
	#Salvando em temporarios
	addi $t0,$a0,0
	addi $t1,$a1,0
	addi $t2,$a2,0
	
	#carregando cores armazenadas nas células
	lw  $t3,0($t0)
	lw  $t4,0($t1)
	lw  $t5,cor_mapa
	addi $v0,$zero,0 #zerando retorno
	
	# Se os lados do personagem forem da cor do mapa então trata-se de um corredor
	seq $t6,$t3,$t5
	seq $t6,$t4,$t5
	beq $t6,0,exit_is_corredor
		addi $v0,$zero,1
	exit_is_corredor:
	
	jr $ra

#######################Efetuando movimento dos fantasmaas #############
#Se o próximo movimento não for um movimento válido, o fantasma continua
#com o movimento anterior
# $a0 -> Arqugmento com o endereço da célula em que o fantasminha está
# $a1 -> Argumento com a cor do fantasma
# $a2 -> argumento com o movimento anterior do fantasma
# $a3 -> argumento com o bitmap_address
#########Retorna a nova posicao do fantasma##########
# $v0 -> Retorno
.macro mover_fantasma_corredor(%endIni,%corFant,%movAnt)
	add $a0,$zero,%endIni
	lw  $a1, %corFant
	add $a2,$zero,%movAnt
	lw  $a3,bitmap_address
	jal mover_fantasma_corredor_function
.end_macro
mover_fantasma_corredor_function:
	addi $sp,$sp,-4
	sw   $ra,0($sp)
	#Salvando valores em temporários
	addi $t0,$a0,0
	addi $t1,$a1,0
	addi $t2,$a2,0
	addi $t3,$a3,0
	######################
	add $t0,$t3,$t0 #Somando endereço base a o valor da célula
	############## SW_CASE para verificar corredor
	seq  $t4,$t2,4
	seq  $t5,$t2,-4
	or   $t6,$t4,$t4 #se o personagem estiver indo pra esquerda ou para direita
		#Zerando registradores para reuso
		add $t4,$zero,0				
		add $t5,$zero,0	
	#################################
	beq  $t6,1,case_ir_cima_baixo
				
		add $t4,$t0,4
		add $t5,$t0,-4
		addi $sp,$sp,-20
		sw   $t0,0($sp)
		sw   $t1,4($sp)
		sw   $t2,8($sp)
		sw   $t4,12($sp)
		sw   $t5,16($sp)
		verificar_corredor($t4,$t5)
		lw   $t0,0($sp)
		lw   $t1,4($sp)
		lw   $t2,8($sp)
		lw   $t4,12($sp)
		lw   $t5,16($sp)
		addi $sp,$sp,20
		addi $t3,$v0,0 #salvando retorno em $t3		
		j end_switch
	case_ir_cima_baixo:	
		add $t4,$t0,256
		add $t5,$t0,-256
		addi $sp,$sp,-12
		sw   $t0,0($sp)
		sw   $t1,4($sp)
		sw   $t2,8($sp)
		#sw   $t4,12($sp)
		#sw   $t5,16($sp)
		verificar_corredor($t4,$t5)
		lw   $t0,0($sp)
		lw   $t1,4($sp)
		lw   $t2,8($sp)
		#lw   $t4,12($sp)
		#lw   $t5,16($sp)
		addi $sp,$sp,12
		addi $t3,$v0,0 #salvando retorno em $t3
	end_switch:
	
	#### SW_Case caso o personagem esteja ou não em um corredor
	beq $t3,0,exit_case_encrusilhada
		lw $t4,corPreta #carregando cor preta em temporário
		sw $t4,0($t0)	
		sleep(500)
		addi $v0,$zero,0 #zerando retorno
		add $t0,$t0,$t2 #Continuando moviento anterior
		lw   $t5,0($t0)  #carregando valor da próxima célula em $t5
		sw   $t1,0($t0)  
		add $s7,$zero,$t5
		addi $v0,$zero,1  #retorno inicando que personagem se moveu por um corredor
	exit_case_encrusilhada:
	

	#############
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

#Procedimento para mover o fantasma vermelho
# $a0 -> Argumento com o endereço inicial da célula do fantasma vermelho
# $a1 -> Argumento com a célula com o pacman posicionado
# $a2 -> Argumento com o movimento anterior
.macro mover_vermelho(%endIni,%endPac,%movimentoAnt) 
	add  $a0,$zero,%endIni
	add  $a1,$zero,%endPac
	add  $a2,$zero,%movimentoAnt
	jal  mover_vermelho_function
.end_macro
mover_vermelho_function:
	save_return_address
	##############
	
	
	##############
	get_return_address
	jr $ra

#######O primeiro movimento dos fantasmas sempre será sair da caixinha
#Será um procedimento para cada mapa.
# $a0 -> argumento contendo a iteração atual. Caso seja a primeira iteração
#        Os fantasmas farão um movimento específico
# $a1 -> Argumento contendo a quantidade de movimentos iniciais que os fantasmas tem que fazer
.macro tirar_fantasmas_caixa(%iteracao,%qtdMovIni)
	add $a0,$zero,%iteracao
	add $a1,$zero,%qtdMovIni
	jal tirar_fantasmas_caixa_function
.end_macro
tirar_fantasmas_caixa_function:	
	save_return_address
	############## Se $a0 for igual a 0, então está na primeira iteração
	bne  $a0,0,exit_is_primeira_iteracao
		mover_para_cima($s2,corAzul)
		addi $s2,$v0,0   #Salvando posição atual do fantasma
		mover_para_cima($s3,corLaranja)
		addi $s3,$v0,0   #Salvando posicao atualizada
		mover_para_direita($s1,corVernelha)
		addi $s1,$v0,0   #Salvando posicao atualizada
		mover_para_esquerda($s4,corRosa)
		addi $s4,$v0,0   #Salvando posição atualizada do pacman
		j exit_primeiros_movimento
	exit_is_primeira_iteracao:
	slt $t0,$a0,$a1
	beq  $t0,0,exit_primeiros_movimento
		mover_para_cima($s2,corAzul)
		addi $s2,$v0,0   #Salvando posição atual do fantasma
		mover_para_cima($s3,corLaranja)
		addi $s3,$v0,0   #Salvando posicao atualizada
		mover_para_cima($s1,corVernelha)
		addi $s1,$v0,0   #Salvando posicao atualizada
		mover_para_cima($s4,corRosa)
		addi $s4,$v0,0   #Salvando posição atualizada do pacman
	exit_primeiros_movimento:
	#############
	get_return_address
	jr $ra
