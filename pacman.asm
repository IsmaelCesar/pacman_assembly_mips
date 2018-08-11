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
#             Outras configurações			#
#########################################################
# $s7 -> Armazenará acor da comida, pro caso de um      #
#        fantasma se mover sobre ela			#
# $s6 -> Armazenará a posição do pacman			#
# $s0 -> Guardará os pontons                            #
# $s1,$s2,$s3,$s4 -> Guardará a posição da célula dos   #
# 		     dos fantasmas no seu respectivo    #
#		     estágio(Vermelho,Azul,Laranja,Rosa)#
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
	#Desenhando pacman (Para testes)
	lw $t0,corPac
	lw $t1,bitmap_address
	addi $t1,$t1,5184
	sw $t0,0($t1)
	add $s6,$zero,$t1
	#################
	desenhar_obstaculo(4664,1,1,corVernelha,bitmap_address)
	desenhar_obstaculo(4668,1,1,corAzul,bitmap_address)
	desenhar_obstaculo(4672,1,1,corLaranja,bitmap_address)
	desenhar_obstaculo(4676,1,1,corRosa,bitmap_address)
	
	#######################################
	#Inicializando a posição dos fantasmas#
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
	add $s6,$zero,$t1
	#################

	desenhar_obstaculo(3896,1,1,corVernelha,bitmap_address)
	desenhar_obstaculo(3900,1,1,corAzul,bitmap_address)
	desenhar_obstaculo(3904,1,1,corLaranja,bitmap_address)
	desenhar_obstaculo(3908,1,1,corRosa,bitmap_address)
	
	#######################################
	#Inicializando a posição dos fantasmas#
	#######################################
	addi $s1,$zero,3896
	addi $s2,$zero,3900
	addi $s3,$zero,3904
	addi $s4,$zero,3908
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
#Prcedimento para efetuar o movimento dos fantasmas
# $a0 -> iteração atual
# $a1 -> Total de interações para que os fantasmas saiam da caixinha
.macro mover_fantasmas(%iteracao,%itercaoFinal)
	add $a0,$zero,%iteracao
	add $a1,$zero,%itercaoFinal
	jal mover_fantasmas_function
.end_macro
mover_fantasmas_function:
	save_return_address
	slt $t0,$a0,$a1
	beq  $t0,0,movimentos_normais
		tirar_fantasmas_caixa($a0)
		j exit_verificar_movimentacao
	movimentos_normais:	
		mover_vermelho($s6,256)
	exit_verificar_movimentacao:
	
	get_return_address
	jr $ra
	
.globl main
main:

jal inicializar_primeiro_estagio

loop_estagio_1:
	beq $s0,10,exit_loop_estagio_1
		mover_fantasmas($s0,5)
		addi $s0,$s0,1
	j loop_estagio_1
exit_loop_estagio_1:

				
addi $v0, $zero,10
syscall
