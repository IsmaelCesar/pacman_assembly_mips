.data
#Escolher tamanho de pixel 8x8
cor:            .word 0x00000fff
cor_mapa:       .word 0x000000e6
bitmap_address: .word 0x00002000
bitmap_size:    .word 16384 #  512 x 256 = 131072 pixls
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

#Procedimeto é utilizado para desenhar o mapa do estágio 1 linha por linha e coluna por coluna
desenhar_mapa_1:

addi $a0,$zero,260
addi $a1,$zero,336
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,6916
addi $a1,$zero,6996
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,260
addi $a1,$zero,2820
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,336
addi $a1,$zero,2896
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna


addi $a0,$zero,4612
addi $a1,$zero,7172
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,4688
addi $a1,$zero,7248
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,2564
addi $a1,$zero,2584
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,3332
addi $a1,$zero,3352
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,3388
addi $a1,$zero,3408
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,3900
addi $a1,$zero,3920
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha
##PArte superior do mapa
addi $a0,$zero,780
addi $a1,$zero,2060
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,784
addi $a1,$zero,2064
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,792
addi $a1,$zero,2072
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,552
addi $a1,$zero,1576
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,556
addi $a1,$zero,1580
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,3388
addi $a1,$zero,3412
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,3844
addi $a1,$zero,3868
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,820
addi $a1,$zero,1588
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,824
addi $a1,$zero,1592
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,828
addi $a1,$zero,2108
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,836
addi $a1,$zero,2116
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,840
addi $a1,$zero,2120
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

#PArte central do mapa
addi $a0,$zero,2080
addi $a1,$zero,3360
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,2100
addi $a1,$zero,3380
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,3364
addi $a1,$zero,3376
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,2584
addi $a1,$zero,3352
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,2620
addi $a1,$zero,3388
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,3864
addi $a1,$zero,4632
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,3900
addi $a1,$zero,4668
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,3872
addi $a1,$zero,4640
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,3880
addi $a1,$zero,4648
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,3884
addi $a1,$zero,4652
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,3892
addi $a1,$zero,4660
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna
##PARte inferior do mapa

addi $a0,$zero,5148
addi $a1,$zero,6172
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,5140
addi $a1,$zero,6164
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,5412
addi $a1,$zero,5668
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,5416
addi $a1,$zero,6440
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,5420
addi $a1,$zero,6444
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,5424
addi $a1,$zero,5680
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,5176
addi $a1,$zero,6200
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,5184
addi $a1,$zero,5952
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,5188
addi $a1,$zero,5444
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,5192
addi $a1,$zero,5448
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_coluna

addi $a0,$zero,6452
addi $a1,$zero,6472
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,6412
addi $a1,$zero,6432
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,5896
addi $a1,$zero,5904
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

addi $a0,$zero,5960
addi $a1,$zero,5968
lw   $a2, cor_mapa	
lw   $a3, bitmap_address
jal desenhar_linha

jr $ra
