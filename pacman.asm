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
#             Outras configura��es	teste           #
#########################################################
# $s7 -> Armazenar� acor da comida, pro caso de um      #
#        fantasma se mover sobre ela			#
# $s6 -> Armazenar� a posi��o do pacman			#
# $s0 -> Guardar� os pontons                            #
# $s1,$s2,$s3,$s4 -> Guardar� a posi��o da c�lula dos   #
# 		     dos fantasmas no seu respectivo    #
#		     est�gio(Vermelho,Azul,Laranja,Rosa)#
#########################################################		
.include "mapa.asm"
.include "numeros.asm"
.include "lado.asm"	
.include "personagens.asm"
.include "movimentos_pacman.asm"
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
movimentos:     .space 16 #0 -> Vermelho, 4 -> Azul, 8 -> Laranja, 12 -> Rosa
vidas:          .word 3  	#Quantidade de vidas
bitmap_address: .word 0x10010000
key_board_addr: .word 0xffff0004
bitmap_size:    .word 16384 #  512 x 256 = 131072 / 8 Tamano de Pixel = 16284 pixls
.text	

inicializar_primeiro_estagio:
	addi $sp,$sp,-4
	sw   $ra, 0($sp)
	
	jal desenhar_mapa_1
	addi $s0, $zero,0
	calcular_desenhar($s0) 
	desenhar_lado(1)
	#Desenhando pacman (Para testes)
	lw $t0,corPac
	lw $t1,bitmap_address
	addi $t1,$t1,5184
	sw $t0,0($t1)
	addi $s6,$zero,5184
	#################
	desenhar_obstaculo(4664,1,1,corVernelha,bitmap_address)
	desenhar_obstaculo(4668,1,1,corAzul,bitmap_address)
	desenhar_obstaculo(4672,1,1,corLaranja,bitmap_address)
	desenhar_obstaculo(4676,1,1,corRosa,bitmap_address)
	
	#######################################
	#Inicializando a posi��o dos fantasmas#
	#######################################
	addi $s1,$zero,4664
	addi $s2,$zero,4668
	addi $s3,$zero,4672
	addi $s4,$zero,4676

	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

inicializar_segundo_estagio:
	addi $sp,$sp,-4
	sw   $ra, 0($sp)
	
	jal desenhar_mapa_2
	addi $s0, $zero,0
	calcular_desenhar($s0) 
	desenhar_lado(2)
	
	
	#Desenhando pacman (Para testes)
	lw $t0,corPac
	lw $t1,bitmap_address
	addi $t1,$t1,4416
	sw $t0,0($t1)
	addi $s6,$zero,4416
	#################

	desenhar_obstaculo(3896,1,1,corVernelha,bitmap_address)
	desenhar_obstaculo(3900,1,1,corAzul,bitmap_address)
	desenhar_obstaculo(3904,1,1,corLaranja,bitmap_address)
	desenhar_obstaculo(3908,1,1,corRosa,bitmap_address)
	
	#######################################
	#Inicializando a posi��o dos fantasmas#
	#######################################
	addi $s1,$zero,3896
	addi $s2,$zero,3900
	addi $s3,$zero,3904
	addi $s4,$zero,3908
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
	

flush_estagio:
	save_return_address	
	
	jal flush_mapa
	#Apaga_os numeros
	apagar_numero(4056)
	apagar_numero(4028)
	apagar_numero(4000)
	apagar_numero(732)
	
	get_return_address
	jr $ra
	
.globl main
main:
#Salvando movimentos iniciais
la $t1,movimentos
addi $t2,$zero,-256
sw  $t2,0($t1)
sw  $t2,4($t1)
sw  $t2,8($t1)
sw  $t2,12($t1)

loop_jogo:
	jal inicializar_primeiro_estagio

	loop_estagio_1:
		beq $s0,20,exit_loop_estagio_1
		#mover_fantasmas($s0,5)
			mover_pacman(1)
		#addi $s0,$s0,1
		j loop_estagio_1
	exit_loop_estagio_1:

	jal flush_mapa
	#Apaga_os numeros
	apagar_numero(4056)
	apagar_numero(4028)
	apagar_numero(4000)
	apagar_numero(732)
	move $s0, $zero #zerando pontuacao para passar para o proximo estagio
	
	jal flush_estagio
	
	jal inicializar_segundo_estagio
	
	
	loop_estagio_2:
		beq $s0,20,exit_loop_estagio_2
		#mover_fantasmas($s0,5)
			mover_pacman(2)
		#addi $s0,$s0,1
		j loop_estagio_2
	exit_loop_estagio_2:
	
	jal flush_estagio
		
 j loop_jogo
 		
addi $v0, $zero,10
syscall
