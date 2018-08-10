.data
#Escolher tamanho de pixel 8x8 configuracao tamanho de display 512x256
# valor ask cacacteres A = 41, S = 53, D = 44, F = 46
cor:            .word 0x00000fff
corPac:		.word 0x00f4f442
corComida:      .word 0x00ffffff	
cor_mapa:       .word 0x000000e6
bitmap_address: .word 0x10010000
key_board_addr: .word 0x00007f04
bitmap_size:    .word 16384 #  512 x 256 = 131072 / 8 Tamano de Pixel = 16284 pixls
.text	

#Procedimento utilizado para efetuar a movimentação de um personagem genérico
#$a0 -> Argumento com o endereço da posicao do personagem
#$a1 -> Argumento com o endereço da próxima casa em que o personagem vai
#$a2 -> Argumento com a cor do personagem a ser pintada no mapa
pintar_movimento:
	#Salvando argumentos em temoprários
	addi $t0, $a0, 0
	addi $t1, $a1, 0
	addi $t2, $a2, 0
	addi $v0, $zero, 0 #zerando retorno
	lw   $t3, 0($t1) #Guardando em $t3 a cor contida na próxima casa que o personagem vai
	beq  $t3, 0x000000e6, exit_cmp_1 #Verificando se é a cor do mapa
			sw $zero, 0($t0) 			
			addi $v0, $zero,31
			addi $a0, $zero,500
			syscall		   #espera meio segundo	
			sw   $t2,0($t1)    #pinta o personagem na próxima casa
			addi $v0, $zero, 1 #Retorno indicando que personagem se mouveu
	exit_cmp_1:
jr $ra
	

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
	
#Procedimento para desenhar sequencias de alimentos para o pacman na linha(Da direita para esquerda)
#Com o endereço inicial e final inclusos 
#$a0 -> Argumento com o endereço inicial
#$a1 -> Argumento com o endereço final
#$a2 -> Valor indicando se deseja desenhar linha ou coluna $a2 = 1 então desenha linha
#	$a2 = 0 então desenha coluna
.macro desenhar_comida(%endIni, %endFin,%opc)
	add $a0,$zero,%endIni
	add $a1,$zero,%endFin
	add $a2,$zero,%opc
	jal desenhar_comida_function
.end_macro
desenhar_comida_function:
	lw $t0, bitmap_address
	lw $t1, bitmap_address
	
	bne $a2,1,else 
		addi $t5,$zero,8
		j end_if_opc_linha_coluna
	else:
		addi $t5,$zero,512
	end_if_opc_linha_coluna:
	add $t0,$t0,$a0   #Salvando o endereço inicial em $t0
	add $t1,$t1,$a1   #Salvando o endereço inicial em $t1
	addi $t2,$t0,0    #inicializando $t2 para ser utilizado como incremento
	lw $t3, corComida #Carregando cor comida
	#sw $t3,0($t1)		
	loop_desenhar_comida:
		slt $t4,$t2,$t1 
		beq $t4,0,exit_loop_desenhar_comida #Dá o branch
			sw $t3,0($t2)	
			add $t2,$t2,$t5
			j loop_desenhar_comida
	exit_loop_desenhar_comida:
	jr $ra 	
	
#Procedimeto é utilizado para desenhar o mapa do estágio 1 linha por linha e coluna por coluna
desenhar_mapa_1:
addi $sp,$sp,-4
sw   $ra,0($sp)
#A orem seguida será da esquerda para direita
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
	###########################
	#      Desenhado comida   #
	###########################
	desenhar_comida(7432,7540,1)
	#Sequencia de comandos para desenhar acomida
	#Parte inferior do mapa
	desenhar_comida(6920,7176,0)
	desenhar_comida(6668,6672,1)
	desenhar_comida(6928,6940,1)
	desenhar_comida(6944,6972,1)
	desenhar_comida(6980,7008,1)
	desenhar_comida(6980,7008,1)
	desenhar_comida(7012,7024,1)
	desenhar_comida(7028,7032,1)
	desenhar_comida(6768,6772,1)
	desenhar_comida(5384,6152,0)
	desenhar_comida(6156,6160,1)
	desenhar_comida(5392,5396,1)
	desenhar_comida(2840,6936,0)
	desenhar_comida(5660,5688,1)
	desenhar_comida(6432,6504,1)
	desenhar_comida(2916,7268,0)
	desenhar_comida(3872,5664,0)
	desenhar_comida(5156,5208,1)
	desenhar_comida(3676,5980,0)
	desenhar_comida(6212,6468,0)
	desenhar_comida(5700,5728,1)
	desenhar_comida(5944,5948,1)
	desenhar_comida(6416,6420,1)
	desenhar_comida(6508,6512,1)
	desenhar_comida(6256,6260,1)
	desenhar_comida(5484,5496,1)
	desenhar_comida(6004,6008,1)

	#parte superior do mapa
	desenhar_comida(520,568,1)
	desenhar_comida(580,632,1)
	desenhar_comida(1032,2312,0)
	desenhar_comida(1140,2420,0)
	desenhar_comida(1052,1820,0)
	desenhar_comida(824,1592,0)
	desenhar_comida(1092,1860,0)
	desenhar_comida(864,1632,0)
	desenhar_comida(1808,1908,1)
	desenhar_comida(2572,2592,1)
	desenhar_comida(2656,2676,1)
	desenhar_comida(2848,2876,1)
	desenhar_comida(2884,2912,1)
	
	#Desenhando pontas
	desenhar_comida(3852,3856,1)
	desenhar_comida(3952,3956,1)
	
	
lw $ra, 0($sp)
addi $sp,$sp,4
jr $ra

desenhar_mapa_2:
addi $sp,$sp,-4
sw   $ra,0($sp)

	## Desenhando limhas mais exteranas
	desenhar_linha(260,380,cor_mapa,bitmap_address)
	desenhar_coluna(376,1656,cor_mapa,bitmap_address)
	desenhar_linha(1388,1404,cor_mapa,bitmap_address)
	desenhar_coluna(1388,2156,cor_mapa,bitmap_address)
	desenhar_linha(1900,1916,cor_mapa,bitmap_address)
	desenhar_linha(2412,2428,cor_mapa,bitmap_address)
	desenhar_coluna(2412,3948,cor_mapa,bitmap_address)
	desenhar_linha(3692,3708,cor_mapa,bitmap_address)
	desenhar_linha(4204,4220,cor_mapa,bitmap_address)
	desenhar_coluna(4204,5996,cor_mapa,bitmap_address)
	desenhar_linha(5740,5756,cor_mapa,bitmap_address)
	desenhar_coluna(5752,8056,cor_mapa,bitmap_address)
	desenhar_linha(7684,7804,cor_mapa,bitmap_address)
	desenhar_coluna(5636,7940,cor_mapa,bitmap_address)
	desenhar_linha(5636,5652,cor_mapa,bitmap_address)
	desenhar_coluna(4112,5904,cor_mapa,bitmap_address)
	desenhar_linha(4100,4116,cor_mapa,bitmap_address)
	desenhar_linha(3588,3604,cor_mapa,bitmap_address)
	desenhar_coluna(2320,3856,cor_mapa,bitmap_address)
	desenhar_linha(2308,2324,cor_mapa,bitmap_address)
	desenhar_linha(1796,1812,cor_mapa,bitmap_address)
	desenhar_coluna(1296,2064,cor_mapa,bitmap_address)
	desenhar_linha(1284,1300,cor_mapa,bitmap_address)
	desenhar_coluna(260,1540,cor_mapa,bitmap_address)

	##### Desenhando obstáculos

	desenhar_obstaculo(780,5,1,cor_mapa,bitmap_address)
	desenhar_obstaculo(548,2,3,cor_mapa,bitmap_address)
	desenhar_obstaculo(816,8,1,cor_mapa,bitmap_address)
	desenhar_obstaculo(596,2,3,cor_mapa,bitmap_address)
	desenhar_obstaculo(596,2,3,cor_mapa,bitmap_address)
	desenhar_obstaculo(864,5,1,cor_mapa,bitmap_address)
	######################
	desenhar_obstaculo(1304,2,5,cor_mapa,bitmap_address)
	desenhar_obstaculo(2336,3,1,cor_mapa,bitmap_address)
	
	desenhar_obstaculo(1572,5,2,cor_mapa,bitmap_address)
	desenhar_obstaculo(1328,2,1,cor_mapa,bitmap_address)

	desenhar_obstaculo(1340,2,4,cor_mapa,bitmap_address)
	desenhar_obstaculo(2352,8,1,cor_mapa,bitmap_address)

	desenhar_obstaculo(1352,2,3,cor_mapa,bitmap_address)
	desenhar_obstaculo(1616,3,2,cor_mapa,bitmap_address)

	desenhar_obstaculo(2388,5,1,cor_mapa,bitmap_address)
	desenhar_obstaculo(1376,2,4,cor_mapa,bitmap_address)
	######################

	desenhar_obstaculo(2840,2,8,cor_mapa,bitmap_address)
	desenhar_obstaculo(2848,3,1,cor_mapa,bitmap_address)

	desenhar_obstaculo(3364,2,7,cor_mapa,bitmap_address)
	desenhar_obstaculo(5144,8,1,cor_mapa,bitmap_address)
	desenhar_obstaculo(4652,3,2,cor_mapa,bitmap_address)

	desenhar_obstaculo(2868,2,1,cor_mapa,bitmap_address)
	desenhar_obstaculo(2864,1,6,cor_mapa,bitmap_address)
	desenhar_obstaculo(2884,3,1,cor_mapa,bitmap_address)
	desenhar_obstaculo(3148,1,5,cor_mapa,bitmap_address)
	desenhar_obstaculo(4144,7,1,cor_mapa,bitmap_address)

	desenhar_obstaculo(4680,3,3,cor_mapa,bitmap_address)
	desenhar_obstaculo(5200,6,1,cor_mapa,bitmap_address)
	desenhar_obstaculo(3412,2,7,cor_mapa,bitmap_address)
	
	desenhar_obstaculo(2900,5,1,cor_mapa,bitmap_address)
	desenhar_obstaculo(3168,2,7,cor_mapa,bitmap_address)
	desenhar_obstaculo(4668,2,4,cor_mapa,bitmap_address)
	desenhar_obstaculo(5676,10,1,cor_mapa,bitmap_address)

	desenhar_obstaculo(5656,4,1,cor_mapa,bitmap_address)

	desenhar_obstaculo(5720,4,1,cor_mapa,bitmap_address)

	desenhar_obstaculo(6156,5,5,cor_mapa,bitmap_address)

	desenhar_obstaculo(6180,1,5,cor_mapa,bitmap_address)
	desenhar_obstaculo(6184,4,3,cor_mapa,bitmap_address)

	desenhar_obstaculo(7212,10,1,cor_mapa,bitmap_address)
	desenhar_obstaculo(6204,2,4,cor_mapa,bitmap_address)

	desenhar_obstaculo(6216,5,3,cor_mapa,bitmap_address)
	desenhar_obstaculo(6232,1,5,cor_mapa,bitmap_address)
	desenhar_obstaculo(6240,5,5,cor_mapa,bitmap_address)
	
	###########################
	#      Desenhado comida   #
	###########################
	desenhar_comida(7432,7540,1)
	desenhar_comida(5896,7176,0)
	desenhar_comida(5904,5948,1)
	desenhar_comida(6432,7200,0)
	desenhar_comida(6952,6972,1)
	desenhar_comida(6456,6460,1)
	
	desenhar_comida(5956,6000,1)
	desenhar_comida(6468,6472,1)
	desenhar_comida(6236,7516,0)
	desenhar_comida(6980,7000,1)
	desenhar_comida(6260,7540,0)

	desenhar_comida(5400,5436,1)
	desenhar_comida(5444,5480,1)
	desenhar_comida(4920,4924,1)
	desenhar_comida(4932,4936,1)
	#Parte do meio
	desenhar_comida(1044,5908,0)
	desenhar_comida(3360,5152,0)
	desenhar_comida(4888,4892,1)
	desenhar_comida(2348,4652,0)
	desenhar_comida(2384,4688,0)
	desenhar_comida(3156,3412,0)
	desenhar_comida(3164,4956,0)
	desenhar_comida(4960,5216,0)
	desenhar_comida(1128,5992,0)
	desenhar_comida(2648,2904,0)
	desenhar_comida(2596,2852,0)
	
	#Parte superior
	desenhar_comida(2080,2108,1)
	desenhar_comida(2116,2144,1)
	desenhar_comida(544,1824,0)
	desenhar_comida(812,1580,0)
	desenhar_comida(848,1616,0)
	desenhar_comida(1072,1100,1)
	desenhar_comida(560,588,1)
	desenhar_comida(604,2396,0)
	desenhar_comida(1136,1140,0)
	desenhar_comida(884,1140,0)
	#desenhando pontas
	desenhar_comida(612,624,1)
	desenhar_comida(528,540,1)
	desenhar_comida(776,1032,0)
	
	desenhar_comida(1036,1040,1)
	desenhar_comida(1592,1848,0)
	desenhar_comida(1604,1860,0)
		

	lw $ra, 0($sp)
	addi $sp,$sp,4
	jr $ra

desenhar_lado:

	addi $a0,$zero,396
	addi $a1,$zero,2956
	lw   $a2, corPac	
	lw   $a3, bitmap_address
        jal desenharL
        lw   $v0,bitmap_address
        lw   $a3,cor_mapa
        #jal desenharV
        
	
#	addi $a0,$zero,2412
#	addi $a1,$zero,3948
#	lw   $a2, corPac	
#	lw   $a3, bitmap_address
 #       jal desenharV

# $a0 é endereço inicial da coluna
# $a1 é o endereço final da coluna
# $a3 é endereço base
# $a2 cor
desenharL:
	addi $sp,$sp,-20
	sw   $a0,0($sp)
	sw   $a1,4($sp)
	sw   $a2,8($sp)
	sw   $a3,12($sp)
	sw   $ra,16($sp)
	#jal 	desenhar_coluna($a0,$a1,$a2,$a3)
	lw $a0, 4($sp) #passa o valor do fim da coluna
	addi $a1, $zero, 4
	addi $a2, $zero, 2
	lw $a3, 8($sp)
	lw   $v0,bitmap_address	
	#jal 	desenhar_obstaculo($a0,$a1,$a2,corPac,$v0)
	lw $ra,16($sp)
	addi $sp,$sp,20
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

.globl main
main:

jal desenhar_mapa_1
addi $s0, $zero,0
calcular_desenhar($s0) 
	
	
	#Sequencia de comandos para desenhar acomida
	#Parte inferior do mapa
				
addi $v0, $zero,10
syscall