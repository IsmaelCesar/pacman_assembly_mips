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
# $a2 -. Argumento com a altura desejada
desenhar_obstaculo:

	add $t0, $a1, $a0 #Salvando largura máxima
	#Salvando altura maxima
	addi $t1 , $zero, 256 #Salvando deslocamento	 
	mul  $t1 , $t1 ,  $a2
	
	
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
###Obstaculo 1
addi $a0,$zero,780
addi $a1,$zero,796
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,1036
addi $a1,$zero,1052
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,1292
addi $a1,$zero,1308
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,1548
addi $a1,$zero,1564
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

###
### Obstaculo 2
addi $a0,$zero,800
addi $a1,$zero,824
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,1056
addi $a1,$zero,1080
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,1312
addi $a1,$zero,1336
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,1568
addi $a1,$zero,1592
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha
#####

### Obstaculo 3

addi $a0,$zero,572
addi $a1,$zero,1852
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,576
addi $a1,$zero,1856
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

### Obstaculo 5 
addi $a0,$zero,840
addi $a1,$zero,864
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,1096
addi $a1,$zero,1120
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,1352
addi $a1,$zero,1376
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,1608
addi $a1,$zero,1632
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha
###Obstáculo 6

addi $a0,$zero,868
addi $a1,$zero,884
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,1124
addi $a1,$zero,1140
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,1380
addi $a1,$zero,1396
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,1636
addi $a1,$zero,1652
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha
#####
### OBstaculo 7
addi $a0,$zero,2060
addi $a1,$zero,2080
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,2316
addi $a1,$zero,2336
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha
#####
###Obstáculo 8
addi $a0,$zero,2084
addi $a1,$zero,2140
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,2340
addi $a1,$zero,2396
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,2596
addi $a1,$zero,2652
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,2876
addi $a1,$zero,2884
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,3132
addi $a1,$zero,3140
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha
#######
###Obstáculo 9 
addi $a0,$zero,2144
addi $a1,$zero,2164
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,2400
addi $a1,$zero,2420
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

lw $ra, 0($sp)
addi $sp,$sp,4
jr $ra
