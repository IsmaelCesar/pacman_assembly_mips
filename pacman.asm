.data
#Escolher tamanho de pixel 8x8 configuracao tamanho de display 512x256
cor:            .word 0x00000fff
cor_mapa:       .word 0x000000e6
bitmap_address: .word 0x00002000
bitmap_size:    .word 16384 #  512 x 256 = 131072 / 8 Tamano de Pixel = 16284 pixls
.text
.globl main
main:

jal desenhar_mapa_1

	
addi $v0, $zero,10
syscall		

#Procedimento para escrever linha por linha
# $a0 -> Argumento com o endereço inicial
# $a1 -> Argumento contendo endereço final
# $a2 -> Argumento contendo a cor do mapa a ser desenhado
# $a3 -> Argumento contendo o endereço base a ser utilizado
desenhar_linha:
	
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
desenhar_coluna:
	
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
desenhar_obstaculo:
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
#Desenhando linhas mais externas
addi $a0,$zero,260
addi $a1,$zero,380
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha


addi $a0,$zero,376
addi $a1,$zero,3192
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,2920
addi $a1,$zero,2936
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,2920
addi $a1,$zero,3944
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,3688
addi $a1,$zero,3708
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,4200
addi $a1,$zero,4220
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,4200
addi $a1,$zero,5480
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,5224
addi $a1,$zero,5244
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha


addi $a0,$zero,5240
addi $a1,$zero,8056
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

##Linha mais inferior do mapa
addi $a0,$zero,7684
addi $a1,$zero,7804
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

##Subindo
addi $a0,$zero,5124
addi $a1,$zero,7940
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,5124
addi $a1,$zero,5144
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,4116
addi $a1,$zero,5396
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,4100
addi $a1,$zero,4120
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,3588
addi $a1,$zero,3608
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,2836
addi $a1,$zero,3860
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,2820
addi $a1,$zero,2840
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,260
addi $a1,$zero,3076
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

#Desenhando obstáculos 
## A ordem também será da esquerda para direita
## Parte superior
#Obstaculo 1
addi $a0,$zero,780
addi $a1,$zero,4
addi $a2,$zero,4
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

#Obstáculo 2
addi $a0,$zero,800
addi $a1,$zero,6
addi $a2,$zero,4
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

#Obstáculo 3
addi $a0,$zero,572
addi $a1,$zero,2
addi $a2,$zero,5
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

#Obstáculo 4
addi $a0,$zero,840
addi $a1,$zero,6
addi $a2,$zero,4
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

#Obstáculo 5
addi $a0,$zero,868
addi $a1,$zero,4
addi $a2,$zero,4
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

#Obstáculo 6
addi $a0,$zero,2060
addi $a1,$zero,5
addi $a2,$zero,2
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

#Obstáculo 7
addi $a0,$zero,2084
addi $a1,$zero,14
addi $a2,$zero,3
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

#Obstáculo 8
addi $a0,$zero,2144
addi $a1,$zero,5
addi $a2,$zero,2
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

#Obstáculo 9
addi $a0,$zero,2876
addi $a1,$zero,2
addi $a2,$zero,2
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,2844
addi $a1,$zero,3868
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna
addi $a0,$zero,3104
addi $a1,$zero,6
addi $a2,$zero,2
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,3144
addi $a1,$zero,6
addi $a2,$zero,2
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,2912
addi $a1,$zero,3936
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

#################
addi $a0,$zero,4124
addi $a1,$zero,5660
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,3876
addi $a1,$zero,5156
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,4900
addi $a1,$zero,4956
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,3928
addi $a1,$zero,5208
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,3912
addi $a1,$zero,3932
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,3876
addi $a1,$zero,3896
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha
########################

addi $a0,$zero,5412
addi $a1,$zero,5468
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha
addi $a0,$zero,5692
addi $a1,$zero,2
addi $a2,$zero,3
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,5916
addi $a1,$zero,7
addi $a2,$zero,2
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,5960
addi $a1,$zero,7
addi $a2,$zero,2
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,6692
addi $a1,$zero,6748
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha
addi $a0,$zero,6972
addi $a1,$zero,2
addi $a2,$zero,2
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo

addi $a0,$zero,5644
addi $a1,$zero,3
addi $a2,$zero,2
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,5652
addi $a1,$zero,6932
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,5736
addi $a1,$zero,3
addi $a2,$zero,2
lw   $a3,cor_mapa
lw   $v0,bitmap_address
jal desenhar_obstaculo
addi $a0,$zero,5736
addi $a1,$zero,7016
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,6512
addi $a1,$zero,6520
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,6408
addi $a1,$zero,6416
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,6924
addi $a1,$zero,6928
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha
addi $a0,$zero,7180
addi $a1,$zero,7224
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha
addi $a0,$zero,6684
addi $a1,$zero,7196
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,7024
addi $a1,$zero,7028
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha
addi $a0,$zero,7240
addi $a1,$zero,7284
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha
addi $a0,$zero,6752
addi $a1,$zero,7264
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,4192
addi $a1,$zero,5728
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

lw $ra, 0($sp)
addi $sp,$sp,4
jr $ra
