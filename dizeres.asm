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
  
	
#	addi $a0,$zero,2412
#	addi $a1,$zero,3948
#	lw   $a2, corPac	
#	lw   $a3, bitmap_address
 #       jal desenharV
 
 
#Procedimento para desenhar a parte do lado
# $a0 -> é endereço inicial da coluna
# $a1 -> é o endereço final da coluna
# $a3 -> é endereço base
# $a2 -> cor
.text
.macro desenharL(%endIni,%endFin,%cor,%baseAddr)
	add $a0,$zero,%endIni
	add $a1,$zero,%endFin
	lw   $a2, %cor	
	lw   $a3, %baseAddr
        jal desenharL_function
.end_macro
desenharL_function:
	addi $sp,$sp,-20
	sw   $a0,0($sp)
	sw   $a1,4($sp)
	sw   $a2,8($sp)
	sw   $a3,12($sp)
	sw   $ra,16($sp)
	desenhar_coluna($a0,$a1,$a2,$a3)
	lw $a0, 4($sp) #passa o valor do fim da coluna
	addi $a1, $zero, 4
	addi $a2, $zero, 2
	lw $a3, 8($sp)
	lw   $v0,bitmap_address	
	#jal 	desenhar_obstaculo($a0,$a1,$a2,corPac,$v0)
	lw $ra,16($sp)
	addi $sp,$sp,20
	jr $ra

.globl desenhar_lado
desenhar_lado:

        desenharL(396,2956,corPac,bitmap_address)   