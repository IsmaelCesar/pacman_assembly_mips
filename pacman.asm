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
.data
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



.globl main
main:

jal desenhar_mapa_1
addi $s0, $zero,789
calcular_desenhar($s0) 
	
	
	#Sequencia de comandos para desenhar acomida
	#Parte inferior do mapa
				
addi $v0, $zero,10
syscall