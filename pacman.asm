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
.include "mapa.asm"
.include "numeros.asm"
.include "lado.asm"	
.include "personagens.asm"
.data
#Cores
cor:            .word 0x00000fff
corPac:		.word 0x00f4f442
corVernelha:    .word 0x00ff0000
corRosa:        .word 0x00ff99cc
corAzul:        .word 0x0099ccff
corLaranja:     .word 0x00ff9966
corPreta:       .word 0x00000000
corComida:      .word 0x00ffffff	
cor_mapa:       .word 0x000000e6
#################################
vidas:          .word 3  	#Quantidade de vidas
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

inicializar_primeiro_estagio:
	addi $sp,$sp,-4
	sw   $ra, 0($sp)
	
	jal desenhar_mapa_1
	addi $s0, $zero,0
	calcular_desenhar($s0) 
	desenhar_lado(1)

	desenhar_obstaculo(4664,1,1,corVernelha,bitmap_address)
	desenhar_obstaculo(4668,1,1,corAzul,bitmap_address)
	desenhar_obstaculo(4672,1,1,corLaranja,bitmap_address)
	desenhar_obstaculo(4676,1,1,corRosa,bitmap_address)

	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

inicializar_segundo_estagio:
	addi $sp,$sp,-4
	sw   $ra, 0($sp)
	
	jal desenhar_mapa_2
	addi $s0, $zero,0
	calcular_desenhar($s0) 
	desenhar_lado(1)

	desenhar_obstaculo(3896,1,1,corVernelha,bitmap_address)
	desenhar_obstaculo(3900,1,1,corAzul,bitmap_address)
	desenhar_obstaculo(3904,1,1,corLaranja,bitmap_address)
	desenhar_obstaculo(3908,1,1,corRosa,bitmap_address)

	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

.globl main
main:

jal inicializar_primeiro_estagio


				
addi $v0, $zero,10
syscall
