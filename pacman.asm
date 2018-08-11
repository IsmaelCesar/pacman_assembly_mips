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
.include "mapa.asm"
.include "numeros.asm"
.include "lado.asm"	
.include "personagens.asm"
.data
cor:            .word 0x00000fff
corPac:		.word 0x00f4f442
corVernelha:    .word 0x00ff0000
corPreta:       .word 0x00000000
corComida:      .word 0x00ffffff	
cor_mapa:       .word 0x000000e6
vidas:          .word 3  	#Quantidade de vidas
bitmap_address: .word 0x10010000
key_board_addr: .word 0x00007f04
bitmap_size:    .word 16384 #  512 x 256 = 131072 / 8 Tamano de Pixel = 16284 pixls
.text	
#Procedimento utilizado para efetuar a movimenta��o de um personagem gen�rico
#$a0 -> Argumento com o endere�o da posicao do personagem
#$a1 -> Argumento com o endere�o da pr�xima casa em que o personagem vai
#$a2 -> Argumento com a cor do personagem a ser pintada no mapa
pintar_movimento:
	#Salvando argumentos em temopr�rios
	addi $t0, $a0, 0
	addi $t1, $a1, 0
	addi $t2, $a2, 0
	addi $v0, $zero, 0 #zerando retorno
	lw   $t3, 0($t1) #Guardando em $t3 a cor contida na pr�xima casa que o personagem vai
	beq  $t3, 0x000000e6, exit_cmp_1 #Verificando se � a cor do mapa
			sw $zero, 0($t0) 			
			addi $v0, $zero,31
			addi $a0, $zero,500
			syscall		   #espera meio segundo	
			sw   $t2,0($t1)    #pinta o personagem na pr�xima casa
			addi $v0, $zero, 1 #Retorno indicando que personagem se mouveu
	exit_cmp_1:
jr $ra


.globl main
main:

jal desenhar_mapa_1
addi $s0, $zero,0
calcular_desenhar($s0) 
desenhar_lado(1)


lw $s3, corPac
lw $s2,bitmap_address
addi $s2,$s2,5688
sw $s3,0($s2)

##Dando um tempo de 0,5 segundos
	li $v0,32
	addi $a0,$zero,500 
	syscall
mover_para_esquerda(5688,corPac)
addi $s2,$v0,0 #Salvando retorno
addi $t0,$zero,0 #inicializando contador
addi $sp,$sp,-4
loop_repertir_movimento:
	
	beq  $t0,9,exit_loop_repetir_movimento
		addi $t0,$t0,1
		sw   $t0,0($sp)
		mover_para_esquerda($s2,corPac)	
		lw   $t0,0($sp)
		addi $s2,$v0,0#Salvando retorno
		##Dando um tempo de 0,5 segundos
		li $v0,32
		addi $a0,$zero,1000 
		syscall
		j loop_repertir_movimento	

exit_loop_repetir_movimento:

				
addi $v0, $zero,10
syscall
