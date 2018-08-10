.data
#Escolher tamanho de pixel 8x8 configuracao tamanho de display 512x256
# valor ask cacacteres A = 41, S = 53, D = 44, F = 46
cor:            .word 0x00000fff
corPac:		.word 0x00f4f442	
cor_mapa:       .word 0x000000e6
bitmap_address: .word 0x10010000
key_board_addr: .word 0x00007f04
bitmap_size:    .word 16384 #  512 x 256 = 131072 / 8 Tamano de Pixel = 16284 pixls
.text

#Procedimento para escrever linha por linha
# $a0 -> Argumento com o endereço inicial
# $a1 -> Argumento contendo endereço final
# $a2 -> Argumento contendo a cor do mapa a ser desenhado
# $a3 -> Argumento contendo o endereço base a ser utilizado
.macro desenhar_linha(%endIni, %endFin, %corMapa, %endBase)
	add $a0, $zero, %endIni
	add $a1, $zero, %endFin
	lw $a2, %corMapa
	lw $a3, %endBase
	jal desenhar_linha_function
.end_macro

desenhar_linha_function:
	add $a0, $a3, $a0 #Inclui o valor no endereço base
	add $a1, $a3, $a1 #Inclui o valor no endereço base
	loop_desenhar_linha:	
	sw  $a2,0($a0)
	addi $a0,$a0,4
	bne $a0, $a1, loop_desenhar_linha
	jr $ra

#Procedimento para escrever coluna por coluna
# $a0 -> Argumento com o endereço inicial
# $a1 -> Argumento contendo endereço final
# $a2 -> Argumento contendo a cor do mapa a ser desenhado
# $a3 -> Argumento contendo o endereço base a ser utilizado
.macro desenhar_coluna(%endIni, %endFin, %corMapa, %endBase)
	add $a0,$zero, %endIni
	add $a1,$zero, %endFin
	lw $a2, %corMapa
	lw $a3, %endBase
	jal desenhar_coluna_fuction
.end_macro
desenhar_coluna_fuction:
	
	add $a0, $a3, $a0 #Inclui o valor no endereço base
	add $a1, $a3, $a1 #Inclui o valor no endereço base
	loop_desenhar_coluna:	
	sw  $a2,0($a0)
	addi $a0,$a0,256
	bne $a0, $a1, loop_desenhar_coluna
	jr $ra

.macro desenhar_numero(%num, %endInicial, %corMapa, %endBase)
	add $a0,$zero, %num
	add $a1,$zero, %endInicial
	lw $a2, %corMapa
	lw $a3, %endBase
	jal desenhar_numero_function
.end_macro
#SWCase
desenhar_numero_function:
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
desenhaUm:
	add $t0, $0,$a1 #inicio
	jal acha_inicio
	addi $t0, $t3, 768
	desenhar_coluna($t3,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t5, 768
	desenhar_coluna($t5,$t0,corPac, bitmap_address) #linha 3
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
desenhaSete:
	add $t0, $0,$a1 #inicio
	jal acha_inicio
	addi $t0, $t1, 12 
	desenhar_linha($t1,$t0, corPac,bitmap_address) #linha 1
	addi $t0, $t3, 768
	desenhar_coluna($t3,$t0,corPac, bitmap_address) #linha 3
	addi $t0, $t5, 768
	desenhar_coluna($t5,$t0,corPac, bitmap_address) #linha 3
	
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

acha_inicio:
	addi $t1, $t0, 4
	addi $t2, $t0, 256
	addi $t3, $t0, 272
	addi $t4, $t0, 1280
	addi $t5, $t0, 1296
	addi $t6, $t0, 2052
	addi $t7, $t0, 1028
	jr $ra
	
.globl main
main:
		addi $s0, $zero, 9
		desenhar_numero($s0, 4004, corPac, bitmap_address)
		 
		
		
		 