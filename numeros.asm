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
#             Outras configura��es			#
#########################################################
# $s7 -> Armazenar� acor da comida, pro caso de um      #
#        fantasma se mover sobre ela			#
# $s6 -> Armazenar� a posi��o do pacman			#
# $s0 -> Guardar� os pontons                            #
# $s1,$s2,$s3,$s4 -> Guardar� a posi��o da c�lula dos   #
# 		     dos fantasmas no seu respectivo    #
#		     est�gio(Vermelho,Azul,Laranja,Rosa)#
#########################################################		
.macro desenhar_numero(%num, %endInicial, %corMapa, %endBase)
	add $a0,$zero, %num
	add $a1,$zero, %endInicial
	lw $a2, %corMapa
	lw $a3, %endBase
	jal desenhar_numero_function
.end_macro
#SWCase
desenhar_numero_function:
	addi $sp,$sp,-4
	sw   $ra,0($sp)
	###############
	beq $a0, 0, desenhaZero
	beq $a0, 1, desenhaUm
	beq $a0, 2, desenhaDois
	beq $a0, 3, desenhaTres
	beq $a0, 4, desenhaQuatro
	beq $a0, 5, desenhaCinco
	beq $a0, 6, desenhaSeis
	beq $a0, 7, desenhaSete
	beq $a0, 8, desenhaOito
	beq $a0, 9, desenhaNove
desenhaZero:
	add $t0, $0,$a1 #inicio
	jal acha_inicio
	addi $t0, $t1, 12 
	desenhar_linha($t1,$t0, corPac,bitmap_address) #linha 1
	addi $t0, $t2, 768
	desenhar_coluna($t2, $t0, corPac, bitmap_address) #linha 2
	addi $t0, $t3, 768
	desenhar_coluna($t3,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t4, 768
	desenhar_coluna($t4,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t5, 768
	desenhar_coluna($t5,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t6, 12 
	desenhar_linha($t6,$t0, corPac,bitmap_address) #linha 1	
	##Retornando a o endere�o anterior
	lw   $ra,0($sp)
	addi $sp,$sp,4
	jr  $ra
	##############
desenhaUm:
	add $t0, $0,$a1 #inicio
	jal acha_inicio
	addi $t0, $t3, 768
	desenhar_coluna($t3,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t5, 768
	desenhar_coluna($t5,$t0,corPac, bitmap_address) #linha 3
	##Retornando a o endere�o anterior
	lw   $ra,0($sp)
	addi $sp,$sp,4
	jr  $ra
	##############
desenhaDois:
	add $t0, $0,$a1 #inicio
	jal acha_inicio
	addi $t0, $t1, 12 
	desenhar_linha($t1,$t0, corPac,bitmap_address) #linha 1
	addi $t0, $t3, 768
	desenhar_coluna($t3,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t4, 768
	desenhar_coluna($t4,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t6, 12 
	desenhar_linha($t6,$t0, corPac,bitmap_address) #linha 1
	addi $t0, $t7, 12 
	desenhar_linha($t7,$t0, corPac,bitmap_address) #linha 1	
	##Retornando a o endere�o anterior
	lw   $ra,0($sp)
	addi $sp,$sp,4
	jr  $ra
	##############
desenhaTres:
	add $t0, $0,$a1 #inicio
	jal acha_inicio
	addi $t0, $t1, 12 
	desenhar_linha($t1,$t0, corPac,bitmap_address) #linha 1
	addi $t0, $t3, 768
	desenhar_coluna($t3,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t5, 768
	desenhar_coluna($t5,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t6, 12 
	desenhar_linha($t6,$t0, corPac,bitmap_address) #linha 1	
	addi $t0, $t7, 12 
	desenhar_linha($t7,$t0, corPac,bitmap_address) #linha 1	
	##Retornando a o endere�o anterior
	lw   $ra,0($sp)
	addi $sp,$sp,4
	jr  $ra
	##############
desenhaQuatro:
	add $t0, $0,$a1 #inicio
	jal acha_inicio
	addi $t0, $t2, 768
	desenhar_coluna($t2, $t0, corPac, bitmap_address) #linha 2
	addi $t0, $t3, 768
	desenhar_coluna($t3,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t5, 768
	desenhar_coluna($t5,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t7, 12 
	desenhar_linha($t7,$t0, corPac,bitmap_address) #linha 1	
	##Retornando a o endere�o anterior
	lw   $ra,0($sp)
	addi $sp,$sp,4
	jr  $ra
	##############
desenhaCinco:
	add $t0, $0,$a1 #inicio
	jal acha_inicio
	addi $t0, $t1, 12 
	desenhar_linha($t1,$t0, corPac,bitmap_address) #linha 1
	addi $t0, $t2, 768
	desenhar_coluna($t2, $t0, corPac, bitmap_address) #linha 2
	addi $t0, $t5, 768
	desenhar_coluna($t5,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t6, 12 
	desenhar_linha($t6,$t0, corPac,bitmap_address) #linha 1	
	addi $t0, $t7, 12 
	desenhar_linha($t7,$t0, corPac,bitmap_address) #linha 1	
	##Retornando a o endere�o anterior
	lw   $ra,0($sp)
	addi $sp,$sp,4
	jr  $ra
	##############
desenhaSeis:
	add $t0, $0,$a1 #inicio
	jal acha_inicio
	addi $t0, $t1, 12 
	desenhar_linha($t1,$t0, corPac,bitmap_address) #linha 1
	addi $t0, $t2, 768
	desenhar_coluna($t2, $t0, corPac, bitmap_address) #linha 2
	addi $t0, $t4, 768
	desenhar_coluna($t4,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t5, 768
	desenhar_coluna($t5,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t6, 12 
	desenhar_linha($t6,$t0, corPac,bitmap_address) #linha 1	
	addi $t0, $t7, 12 
	desenhar_linha($t7,$t0, corPac,bitmap_address) #linha 1	
	##Retornando a o endere�o anterior
	lw   $ra,0($sp)
	addi $sp,$sp,4
	jr  $ra
	##############
desenhaSete:
	add $t0, $0,$a1 #inicio
	jal acha_inicio
	addi $t0, $t1, 12 
	desenhar_linha($t1,$t0, corPac,bitmap_address) #linha 1
	addi $t0, $t3, 768
	desenhar_coluna($t3,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t5, 768
	desenhar_coluna($t5,$t0,corPac, bitmap_address) #linha 3
	##Retornando a o endere�o anterior
	lw   $ra,0($sp)
	addi $sp,$sp,4
	jr  $ra
	##############
desenhaOito:
	add $t0, $0,$a1 #inicio
	jal acha_inicio
	addi $t0, $t1, 12 
	desenhar_linha($t1,$t0, corPac,bitmap_address) #linha 1
	addi $t0, $t2, 768
	desenhar_coluna($t2, $t0, corPac, bitmap_address) #linha 2
	addi $t0, $t3, 768
	desenhar_coluna($t3,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t4, 768
	desenhar_coluna($t4,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t5, 768
	desenhar_coluna($t5,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t6, 12 
	desenhar_linha($t6,$t0, corPac,bitmap_address) #linha 1	
	addi $t0, $t7, 12 
	desenhar_linha($t7,$t0, corPac,bitmap_address) #linha 1	
	##Retornando a o endere�o anterior
	lw   $ra,0($sp)
	addi $sp,$sp,4
	jr  $ra
	##############
desenhaNove:
	add $t0, $0,$a1 #inicio
	jal acha_inicio
	addi $t0, $t1, 12 
	desenhar_linha($t1,$t0, corPac,bitmap_address) #linha 1
	addi $t0, $t2, 768
	desenhar_coluna($t2, $t0, corPac, bitmap_address) #linha 2
	addi $t0, $t3, 768
	desenhar_coluna($t3,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t5, 768
	desenhar_coluna($t5,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t6, 12 
	desenhar_linha($t6,$t0, corPac,bitmap_address) #linha 1	
	addi $t0, $t7, 12 
	desenhar_linha($t7,$t0, corPac,bitmap_address) #linha 1	
	##Retornando a o endere�o anterior
	lw   $ra,0($sp)
	addi $sp,$sp,4
	jr  $ra
	##############
acha_inicio:
	addi $t1, $t0, 4
	addi $t2, $t0, 256
	addi $t3, $t0, 272
	addi $t4, $t0, 1280
	addi $t5, $t0, 1296
	addi $t6, $t0, 2052
	addi $t7, $t0, 1028
	jr $ra
	
	
#Procedimento para retornar o idice m�gulo 10
# $a0 -> Argumento com o valor 
# $a1 -> Argumento com o valor exp
.macro funcao_modulo_expoente(%valor,%expoente)
	addi $a0,%valor,0
	addi $a1,%expoente,0
	jal  pegar_indice_modulo
.end_macro
pegar_indice_modulo:
	#addi $t0,$zero,789
	#addi $t1,$zero,10
	div  $a0,$a1    #valor/exp
	mflo $a0
	addi $a1,$zero,10
	div  $a0,$a1
	mfhi $a0        #valor/exp m�dulo 10
	addi $v0,$a0,0  #adicionando valor de retorno a o registrador
	jr $ra

#Macro para o procedimendo calcular desenhar
.macro calcular_desenhar(%numero)
	add $a0, $zero,%numero
	jal calcular_desenhar_function
.end_macro
#Procedimento para extrair os d�gitos de um n�mero e desenha-los no bitmap display
#$a0 -> N�mero a ser pintado
calcular_desenhar_function:
	addi $sp, $sp, -8
	sw   $ra, 0($sp)
	sw   $a0,4($sp)  #Salva o n�mero na pilha
	addi $a1,$zero,1
	#Primero d�gito desenhar_numero(%num, %endInicial, %corMapa, %endBase)
	funcao_modulo_expoente($a0,$a1)
	desenhar_numero($v0,4056,corPac,bitmap_address)

	#Segundo d�gito
	lw   $a0,4($sp)
	addi $a1,$zero,10
	funcao_modulo_expoente($a0,$a1)
	desenhar_numero($v0,4028,corPac,bitmap_address)

	
	#Terceiro d�gito
	lw   $a0,4($sp)
	addi $a1,$zero,100
	funcao_modulo_expoente($a0,$a1)	
	desenhar_numero($v0,4000,corPac,bitmap_address)
	
	lw $ra,0($sp)
	addi $sp, $sp,8
	jr $ra

##PRocedimento para apagar o n�mero
# $a0 -> Endere�o do n�mero que se deseja apagar
.macro apagar_numero(%endIni)	
	add $a0,$zero,%endIni
	jal apagar_numero_function
.end_macro
apagar_numero_function:
	save_return_address
	add $t0,$0,$a0
	########Acha_inicio############
	addi $t1, $t0, 4
	addi $t2, $t0, 256
	addi $t3, $t0, 272
	addi $t4, $t0, 1280
	addi $t5, $t0, 1296
	addi $t6, $t0, 2052
	addi $t7, $t0, 1028
	###############################
	addi $t0, $t1, 12 
	desenhar_linha($t1,$t0, corPreta,bitmap_address) #linha 1
	addi $t0, $t2, 768
	desenhar_coluna($t2, $t0, corPreta, bitmap_address) #linha 2
	addi $t0, $t3, 768
	desenhar_coluna($t3,$t0,corPreta, bitmap_address) #linha 3
	addi $t0, $t4, 768
	desenhar_coluna($t4,$t0,corPreta, bitmap_address) #linha 3
	addi $t0, $t5, 768
	desenhar_coluna($t5,$t0,corPreta, bitmap_address) #linha 3
	addi $t0, $t6, 12 
	desenhar_linha($t6,$t0, corPreta,bitmap_address) #linha 1	
	addi $t0, $t7, 12 
	desenhar_linha($t7,$t0, corPreta,bitmap_address) #linha 1	
		
	get_return_address
	jr $ra
#Procedimento feito para incrementar pontos
# Os endere�os dos d�gitos variam de 28 em 28, sendo o endere�os 
#dos mesmos, subtraidos no mesmo intervalo
# $a0 -> Pontos atuais
# Macro auxiliar para salvar os regsitrso de ativa��o
.macro salvar_registros_incrementar_pontos
	addi  $sp,$sp,-20
	sw     $t0,0($sp)
	sw     $t1,4($sp)
	sw     $t2,8($sp)
	sw     $t4,12($sp)
	sw     $t6,16($sp)
.end_macro
# Macro auxiliar para pegar os regsitrso de ativa��o
.macro get_registros_incrementar_pontos
	lw     $t0,0($sp)
	lw     $t1,4($sp)
	lw     $t2,8($sp)
	lw     $t4,12($sp)
	lw     $t6,16($sp)
	addi  $sp,$sp,20
.end_macro
incrementar_pontos:
	save_return_address
	
	addi $t0,$zero,1   #Salvando expoente
	add  $t1,$zero,$s0 #Salvando valores dos pontos em tempor�rio
	addi $t2,$zero,0   #contador do loop
	addi $s0,$s0,1     #incrementando pontos
	#funcao_modulo_expoente(,)
	addi $t6,$zero,4056	
	loop_incrementar_pontos:
	slti $t3,$t2,3
	beq $t3,0,exit_loop_incrementar_pontos
		
		funcao_modulo_expoente($s0,$t0)
		addi $t4,$v0,0
		
		funcao_modulo_expoente($t1,$t0)
		#Se o digito do numero antigo for igual ao novo
		seq $t5,$t4,$v0
		beq $t5,1,exit_is_digito_igual
			salvar_registros_incrementar_pontos
			apagar_numero($t6)
			
			get_registros_incrementar_pontos
			salvar_registros_incrementar_pontos
			
			desenhar_numero($t4,$t6,corPac,bitmap_address)
			
			get_registros_incrementar_pontos
		exit_is_digito_igual:
		
		addi $t6,$t6,-28
		mul  $t0,$t0,10
		addi $t2,$t2,1
		j loop_incrementar_pontos
	exit_loop_incrementar_pontos:
	
	
	get_return_address
	jr $ra