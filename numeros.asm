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
	##Retornando a o endereço anterior
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
	##Retornando a o endereço anterior
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
	##Retornando a o endereço anterior
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
	##Retornando a o endereço anterior
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
	##Retornando a o endereço anterior
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
	##Retornando a o endereço anterior
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
	##Retornando a o endereço anterior
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
	##Retornando a o endereço anterior
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
	##Retornando a o endereço anterior
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
	##Retornando a o endereço anterior
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
	
	
#Procedimento para retornar o idice mógulo 10
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
	mfhi $a0        #valor/exp módulo 10
	addi $v0,$a0,0  #adicionando valor de retorno a o registrador
	jr $ra

#Macro para o procedimendo calcular desenhar
.macro calcular_desenhar(%numero)
	add $a0, $zero,%numero
	jal calcular_desenhar_function
.end_macro
#Procedimento para extrair os dígitos de um número e desenha-los no bitmap display
#$a0 -> Número a ser pintado
calcular_desenhar_function:
	addi $sp, $sp, -8
	sw   $ra, 0($sp)
	sw   $a0,4($sp)  #Salva o número na pilha
	addi $a1,$zero,1
	#Primero dígito desenhar_numero(%num, %endInicial, %corMapa, %endBase)
	funcao_modulo_expoente($a0,$a1)
	desenhar_numero($v0,4056,corPac,bitmap_address)

	#Segundo dígito
	lw   $a0,4($sp)
	addi $a1,$zero,10
	funcao_modulo_expoente($a0,$a1)
	desenhar_numero($v0,4028,corPac,bitmap_address)

	
	#Terceiro dígito
	lw   $a0,4($sp)
	addi $a1,$zero,100
	funcao_modulo_expoente($a0,$a1)	
	desenhar_numero($v0,3996,corPac,bitmap_address)
	
	lw $ra,0($sp)
	addi $sp, $sp,8
	jr $ra