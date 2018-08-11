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


#Macros auxiliares para pegar os movimentos dos fantasmas vermelho, azul, laranja e rosa
# respectivamente
.macro salvar_movimento_vermelho(%movFantasma)
	la $t0, movimentos
	sw %movFantasma,0($t0)
.end_macro

.macro salvar_movimento_azul(%movFantasma)
	la $t0, movimentos
	sw %movFantasma,4($t0)
.end_macro

.macro  salvar_movimento_laranja(%movFantasma)
	la $t0, movimentos
	sw %movFantasma,8($t0)
.end_macro

.macro salvar_movimento_rosa(%movFantasma)
	la $t0, movimentos
	sw %movFantasma,12($t0)
.end_macro

.macro carregar_movimento_vermelho(%movFantasma)
	la $t0, movimentos
	lw %movFantasma,0($t0)
.end_macro

.macro carregar_movimento_azul(%movFantasma)
	la $t0, movimentos
	lw %movFantasma,4($t0)
.end_macro

.macro  carregar_movimento_laranja(%movFantasma)
	la $t0, movimentos
	lw %movFantasma,8($t0)
.end_macro

.macro carregar_movimento_rosa(%movFantasma)
	la $t0, movimentos
	sw %movFantasma,12($t0)
.end_macro


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
##################################### Movimentação Fantasmas ##############################

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

#Procedimento para verificar se o movimento atual do fantasma é um movimento válido
# $a0 -> Endereço da célula do fantasma
# $a1 -> Moviento que o fantasma pretende fazer
# $a2 -> Bitmap address
#############Retorna #############################
# $v0 -> Valor indicando se o movimento é válido ou não
# $v1 -> Cor da próxima célula em que o movimento será efetuado
.macro verificar_movimento_valido(%endFantasma,%movimentoFantasma)
	add $a0,$zero,%endFantasma
	add $a1,$zero,%movimentoFantasma
	lw  $a3,bitmap_address
	jal verificar_movimento_valido_function		
.end_macro
verificar_movimento_valido_function:
	#Salvando argumentos em temporários
	addi $t0,$a0,0
	addi $t1,$a1,0
		
	add $t0,$a3,$t0 #Somando endereço da célula ao endereço base
	add  $t2,$t0,$t1 #aplicando movimento que o fantasma pretende fazer 
	lw   $t3,0($t2)  #carregando a cor na próxima célula
	
	addi $t4,$zero,0x00000000 #cor preta
	addi $t5,$zero,0x00ffffff #cor comida
	##### Se a cor da próxima célula for preta ou vermelha
	seq  $t6,$t4,$t3 
	seq  $t7,$t5,$t3
	or   $t9,$t6,$t7
	beq  $t9,0,else_movimento_valido
		addi $v0,$zero,1 #Se for cor preta ou cor comida é um movimento válido
		
		#Salvando a cor do que é que estiver na próxima célula, caso o movimento seja válido
		beq  $t7,0,else_is_cor_comida1
			add $v1,$zero,$t5
			j exit_is_cor_comida1
		else_is_cor_comida1:
			add $v1,$zero,$t4
		exit_is_cor_comida1:
		
		j exit_if_movimento_válido
	else_movimento_valido:
		addi $v0,$zero,0 #Caso contrario, não	
		#Salvando a cor do que é que estiver na próxima célula, caso o movimento seja válido
		beq  $t7,0,else_is_cor_comida2
			add $v1,$zero,$t5
			j exit_is_cor_comida2
		else_is_cor_comida2:
			add $v1,$zero,$t4
		exit_is_cor_comida2:
	exit_if_movimento_válido:
	
	jr $ra
	
#Procedimento para eftuar a busca de um movimento válido
# $a0 -> Argumento com o endereço da célula atual do fantasma
# $a1 -> Argumento com o bitmap address
############ Retorna ########################################3
# $v0 -> valor de incremento com o movimento válido a ser efetuado
#        pelo personagem
.macro buscar_movimento_valido(%endMov)
	add $a0,$zero,%endMov
	lw  $a1,bitmap_address
	jal buscar_movimento_valido_function
.end_macro
#Macro auxiliar para salvar_registros de ativação e efetuar busca
.macro macro_salva_carrega_registros_verifica_movimento
	sw   $t0,0($sp)
	sw   $t1,4($sp)
	sw   $t2,8($sp)
	verificar_movimento_valido($t0,$t2)
	lw   $t0,0($sp)
	lw   $t1,4($sp)
	lw   $t2,8($sp)
.end_macro
buscar_movimento_valido_function:
	save_return_address
	
	addi $t0,$a0,0  #salvando argumento em temporário
	add  $t1,$a1,0
	
	#verificando movimento para cima
	addi $t2,$zero,-256 #movimento para cima
	addi $sp,$sp,-12
	
	#cima
	macro_salva_carrega_registros_verifica_movimento			
	beq $v0,0,buscar_movimento_para_baixo
		addi $t2,$zero,-256
		j exit_buscar_movimento
	#baixo
	buscar_movimento_para_baixo:
	addi $t2,$zero,256
	macro_salva_carrega_registros_verifica_movimento		
	beq $v0,0,buscar_movimento_para_direita
		addi $t2,$zero,256
		j exit_buscar_movimento
	#direita	
	buscar_movimento_para_direita:
	addi $t2,$zero,4
	macro_salva_carrega_registros_verifica_movimento
	beq $v0,0,buscar_movimento_para_esquerda
		addi $t2,$zero,4
		j exit_buscar_movimento
	#esquerda
	buscar_movimento_para_esquerda:
	addi $t2,$zero,-4
	macro_salva_carrega_registros_verifica_movimento
		addi $t2,$zero,-4
	exit_buscar_movimento:
	addi $sp,$sp,12
	addi $v0,$t2,0 #Salvando o tipo de incremento no retorno
	get_return_address
	jr $ra
	
#Procedimento para mover o fantasma vermelho Cujo endereço atual está em $s1
# $a0 -> Argumento com o endereço inicial da célula do fantasma vermelho
# $a2 -> Argumento com o movimento anterior
.macro mover_laranja(%movimentoAnt) 
	#add  $a0,$zero,%endPac
	add  $a1,$zero,%movimentoAnt
	jal  mover_laranja_function
.end_macro
mover_laranja_function:
	save_return_address
	#addi $t0,$a0,0 #Salvando movimento em temporário
	addi $t1,$a1,0 #Salvando movimento em temporário
	##############
	addi $sp,$sp,-4
	#sw   $t0,0($sp)
	sw   $t1,4($sp)
	verificar_movimento_valido($s3,$t1)
	#lw   $t0,0($sp)
	lw   $t1,4($sp)
	addi $sp,$sp,4
	
	bne $v0,1,else_movimento
		#caso seja um movimento válido
		#verifica se está num corredor
		j exit_if_movimento
	else_movimento:
		addi $sp,$sp,-4
		#sw   $t0,0($sp)
		sw   $t1,4($sp)
		buscar_movimento_valido($s3)
		#lw   $t0,0($sp)
		lw   $t1,4($sp)
		addi $sp,$sp,4
		#Direita
		bne $v0,4,if_movimento_is_esquerda
			mover_para_direita($s3,corLaranja)
			j exit_if_movimento
		#Esquerda
		if_movimento_is_esquerda:
		bne $v0,-4,if_movimento_is_cima
			mover_para_esquerda($s3,corLaranja)
			j exit_if_movimento
		#Cima
		if_movimento_is_cima:							
		bne $v0,-256,if_movimento_is_baixo
			mover_para_cima($s3,corLaranja)
			j exit_if_movimento
		#Baixo
		if_movimento_is_baixo:
			mover_para_baixo($s3,corLaranja)
		
	exit_if_movimento:
	##############
	get_return_address
	jr $ra

#######O primeiro movimento dos fantasmas sempre será sair da caixinha
#Será um procedimento para cada mapa.
# $a0 -> argumento contendo a iteração atual. Caso seja a primeira iteração
#        Os fantasmas farão um movimento específico
.macro tirar_fantasmas_caixa(%iteracao)
	add $a0,$zero,%iteracao
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
