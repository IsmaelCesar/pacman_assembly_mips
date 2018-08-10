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
	addi $a0,$zero, %endIni
	addi $a1,$zero, %endFin
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

#Procidimento para desenhar um obstáculo a partir de um endereço referencial
# $a0 -> Argumento com o endereço da célula escolhida
# $a1 -> Argumento com a largura desejada
# $a2 -> Argumento com a altura desejada
# $a3 -> Argumento com a cor
# $v0 -> Argumento extra com o bit map address
.macro desenhar_obstaculo(%endCel, %larg, %alt, %cor, %endBase)
	addi $a0,$zero,%endCel
	addi $a1,$zero,%larg
	addi $a2,$zero,%alt
	lw   $a3,%cor
	lw   $v0,%endBase
	jal desenhar_obstaculo_function
.end_macro
desenhar_obstaculo_function:
	add $a0, $v0,   $a0
	add $t0, $zero, $a0 #Endereco
	add $t1, $zero, $a1 #largura desejada
	add $t2, $zero, $a2 #altira desejada
		
	addi $t3,$zero,0    #indice altura
	addi $t4,$zero,0    #indice largura
	add $t5, $zero,$a3  #cor
	add $t6, $zero,$a0   #salvando endereço da célula inicial escolhida
	#Salvando altura maxima
	loop1_desenhar_obst:
		beq $t3,$t2,exit_loop1_desenhar_obst
		loop2_desenhar_obst:
			beq $t4,$t1,exit_loop2_desenhar_obst
			sw  $t5,0($t0)
			addi $t0,$t0,4
			addi $t4,$t4,1
			j loop2_desenhar_obst		
		exit_loop2_desenhar_obst:
		addi $t4, $zero,0 #zerando indice largura
		addi $t6, $t6,256
		addi $t0,$t6,0   #Passando o endereço atualizado
		addi $t3,$t3,1
		j loop1_desenhar_obst
	exit_loop1_desenhar_obst:
	addi $v0,$zero,0
	jr $ra	
.globl main


	
 	
desenhar_mapa1:
	addi $sp,$sp,-4
	sw   $ra,0($sp)
	#desenhar linhas externas do Mapa
	desenhar_linha(260,380,cor_mapa, bitmap_address)
	desenhar_linha(2920,2936,cor_mapa, bitmap_address)
	desenhar_linha(3688,3708,cor_mapa, bitmap_address)
	desenhar_linha(4200,4220,cor_mapa, bitmap_address)
	desenhar_linha(5224,5244,cor_mapa, bitmap_address)	
	desenhar_linha(7684,7804,cor_mapa, bitmap_address)
	
	desenhar_coluna(376,3192,cor_mapa, bitmap_address)
	desenhar_coluna(2920,3944,cor_mapa, bitmap_address)
	desenhar_coluna(4200,5480,cor_mapa, bitmap_address)
	desenhar_coluna(5240,8056,cor_mapa, bitmap_address)
	#subindo
	desenhar_coluna(5124,7940,cor_mapa, bitmap_address)	
	desenhar_coluna(4116,5396,cor_mapa, bitmap_address)
	desenhar_coluna(2836,3860,cor_mapa, bitmap_address)
	desenhar_coluna(260,3076,cor_mapa, bitmap_address)
	
	desenhar_linha(5124,5144,cor_mapa, bitmap_address)
	desenhar_linha(4100,4120,cor_mapa, bitmap_address)
	desenhar_linha(3588,3608,cor_mapa, bitmap_address)
	desenhar_linha(2820,2840,cor_mapa, bitmap_address)
	
	#desenhar Obstaculos - Parte  de Cima
	desenhar_obstaculo(780,4,4,cor_mapa, bitmap_address)
	desenhar_obstaculo(800,6,4,cor_mapa, bitmap_address)
	desenhar_obstaculo(572,2,5,cor_mapa, bitmap_address)	
	desenhar_obstaculo(840,6,4,cor_mapa, bitmap_address)
	desenhar_obstaculo(868,4,4,cor_mapa, bitmap_address)
	desenhar_obstaculo(2060,5,2,cor_mapa, bitmap_address)
	desenhar_obstaculo(2084,14,3,cor_mapa, bitmap_address)
	desenhar_obstaculo(2144,5,2,cor_mapa, bitmap_address)
	desenhar_obstaculo(2876,2,2,cor_mapa, bitmap_address)
	desenhar_obstaculo(2084,14,3,cor_mapa, bitmap_address)
	desenhar_obstaculo(2144,5,2,cor_mapa, bitmap_address)
	desenhar_obstaculo(2876,2,2,cor_mapa, bitmap_address)
	desenhar_coluna(2844,3868,cor_mapa, bitmap_address)
	desenhar_obstaculo(3104,6,2,cor_mapa, bitmap_address)
	desenhar_obstaculo(3144,6,2,cor_mapa, bitmap_address)
	desenhar_coluna(2912,3936,cor_mapa, bitmap_address)
	
	#desenhar obstáculo - meio
	#################
	desenhar_coluna(4124,5660,cor_mapa, bitmap_address)
	desenhar_coluna(3876,5156,cor_mapa, bitmap_address)
	desenhar_linha(4900,4956,cor_mapa, bitmap_address)
	desenhar_coluna(3928,5208,cor_mapa, bitmap_address)
	desenhar_linha(3912,3932,cor_mapa, bitmap_address)
	desenhar_linha(3876,3896,cor_mapa, bitmap_address)	
	########################
	
	#desenhar obstáculo - fim
	desenhar_linha(5412,5468,cor_mapa, bitmap_address)	
	desenhar_obstaculo(5692,2,3,cor_mapa, bitmap_address)
	desenhar_obstaculo(5916,7,2,cor_mapa, bitmap_address)
	desenhar_obstaculo(5960,7,2,cor_mapa, bitmap_address)
	desenhar_linha(6692,6748,cor_mapa, bitmap_address)	
	desenhar_obstaculo(6972,2,2,cor_mapa, bitmap_address)
	desenhar_obstaculo(5644,3,2,cor_mapa, bitmap_address)
	desenhar_coluna(5652,6932,cor_mapa, bitmap_address)	
	desenhar_obstaculo(5736,3,2,cor_mapa, bitmap_address)
	desenhar_coluna(5736,7016,cor_mapa, bitmap_address)	
	desenhar_linha(6512,6520,cor_mapa, bitmap_address)	
	desenhar_linha(6408,6416,cor_mapa, bitmap_address)	
	desenhar_linha(6924,6928,cor_mapa, bitmap_address)	
	desenhar_linha(7180,7224,cor_mapa, bitmap_address)	
	desenhar_coluna(6684,7196,cor_mapa, bitmap_address)	
	desenhar_linha(7024,7028,cor_mapa, bitmap_address)	
	desenhar_linha(7240,7284,cor_mapa, bitmap_address)	
	desenhar_coluna(6752,7264,cor_mapa, bitmap_address)
	desenhar_coluna(4192,5728,cor_mapa, bitmap_address)
	lw $ra, 0($sp)
	addi $sp,$sp,4
	jr $ra
main:
	jal desenhar_mapa1
	