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

#Procedimento para mover o personagem
#$a0 -> Argumento com o endereço do caractere a ser lido
#$a1 -> Endereço de memória da posição do personagem
#$a2 -> Cor do personagem
mover_pacman:
	#passando o endereço
	addi $t0, $a0,0
	addi $t1, $a1,0
	addi $t2, $a2,0
	##################
	lw   $t3, 0($t0) #carregando caractere
	addi $t4, $t1,0  #Variavel auxiliar
	
	bne  $t3, 41, exit_a
		addi $t4, $t4, -256
		lw   $t5,0($t4)    #Carregando cor
		beq  $t5, 0x000000e6, exir_cmp_1 #Verificando se é a cor do mapa
			sw $zero, 0($t1) 			
			addi $v0, $zero,31
			addi $a0, $zero,500
			syscall			
			addi $t1,$t1,-256
			sw   $t2,0($t1)
		exir_cmp_1:
		
	exit_a:
	
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

lw $ra, 0($sp)
addi $sp,$sp,4
jr $ra

desenhar_mapa_2:
addi $sp,$sp,-4
sw   $ra,0($sp)

## Desenhando limhas mais exteranas
addi $a0,$zero,260
addi $a1,$zero,380
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,376
addi $a1,$zero,1656
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,1388
addi $a1,$zero,1404
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,1388
addi $a1,$zero,2156
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,1900
addi $a1,$zero,1916
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,2412
addi $a1,$zero,2428
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha


addi $a0,$zero,2412
addi $a1,$zero,3948
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna


addi $a0,$zero,3692
addi $a1,$zero,3708
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha


addi $a0,$zero,4204
addi $a1,$zero,4220
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,4204
addi $a1,$zero,5996
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna


addi $a0,$zero,5740
addi $a1,$zero,5756
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha


addi $a0,$zero,5752
addi $a1,$zero,8056
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,7684
addi $a1,$zero,7804
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,5636
addi $a1,$zero,7940
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,5636
addi $a1,$zero,5652
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,4112
addi $a1,$zero,5904
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,4100
addi $a1,$zero,4116
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,3588
addi $a1,$zero,3604
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,2320
addi $a1,$zero,3856
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,2308
addi $a1,$zero,2324
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,1796
addi $a1,$zero,1812
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,1296
addi $a1,$zero,2064
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,1284
addi $a1,$zero,1300
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,260
addi $a1,$zero,1540
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

##### Desenhando obstáculos
addi $a0,$zero,780
addi $a1,$zero,5
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,548
addi $a1,$zero,2
addi $a2,$zero,3
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,816
addi $a1,$zero,8
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,596
addi $a1,$zero,2
addi $a2,$zero,3
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,596
addi $a1,$zero,2
addi $a2,$zero,3
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,864
addi $a1,$zero,5
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

######################
addi $a0,$zero,1304
addi $a1,$zero,2
addi $a2,$zero,5
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,2336
addi $a1,$zero,3
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,1572
addi $a1,$zero,5
addi $a2,$zero,2
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,1328
addi $a1,$zero,2
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,1340
addi $a1,$zero,2
addi $a2,$zero,4
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,2352
addi $a1,$zero,8
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,1352
addi $a1,$zero,2
addi $a2,$zero,3
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,1616
addi $a1,$zero,3
addi $a2,$zero,2
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,2388
addi $a1,$zero,5
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,1376
addi $a1,$zero,2
addi $a2,$zero,4
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
######################

addi $a0,$zero,2840
addi $a1,$zero,2
addi $a2,$zero,8
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,2848
addi $a1,$zero,3
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,3364
addi $a1,$zero,2
addi $a2,$zero,7
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,5144
addi $a1,$zero,8
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,4652
addi $a1,$zero,3
addi $a2,$zero,2
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo


addi $a0,$zero,2868
addi $a1,$zero,2
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,2864
addi $a1,$zero,1
addi $a2,$zero,6
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,2884
addi $a1,$zero,3
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,3148
addi $a1,$zero,1
addi $a2,$zero,5
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,4144
addi $a1,$zero,7
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,4680
addi $a1,$zero,3
addi $a2,$zero,3
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,5200
addi $a1,$zero,6
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,3412
addi $a1,$zero,2
addi $a2,$zero,7
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,2900
addi $a1,$zero,5
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,3168
addi $a1,$zero,2
addi $a2,$zero,7
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,4668
addi $a1,$zero,2
addi $a2,$zero,4
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,5676
addi $a1,$zero,10
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,5656
addi $a1,$zero,4
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,5720
addi $a1,$zero,4
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,6156
addi $a1,$zero,5
addi $a2,$zero,5
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo


addi $a0,$zero,6180
addi $a1,$zero,1
addi $a2,$zero,5
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,6184
addi $a1,$zero,4
addi $a2,$zero,3
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,7212
addi $a1,$zero,10
addi $a2,$zero,1
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,6204
addi $a1,$zero,2
addi $a2,$zero,4
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,6216
addi $a1,$zero,5
addi $a2,$zero,3
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,6232
addi $a1,$zero,1
addi $a2,$zero,5
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,6240
addi $a1,$zero,5
addi $a2,$zero,5
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

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
	jal desenhar_coluna
	lw $a0, 4($sp) #passa o valor do fim da coluna
	addi $a1, $zero, 4
	addi $a2, $zero, 2
	lw $a3, 8($sp)
	lw   $v0,bitmap_address	
	jal desenhar_obstaculo
	lw $ra,16($sp)
	addi $sp,$sp,20
	jr $ra

.globl main
main:

jal desenhar_mapa_1
jal desenhar_lado

	
addi $v0, $zero,10
syscall			
		
			
