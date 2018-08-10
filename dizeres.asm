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
  
	
#	addi $a0,$zero,2412
#	addi $a1,$zero,3948
#	lw   $a2, corPac	
#	lw   $a3, bitmap_address
 #       jal desenharV
 
 
#Procedimento para desenhar a parte do lado
# $a0 -> � endere�o inicial da coluna
# $a1 -> � o endere�o final da coluna
# $a3 -> � endere�o base
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
	desenhar_coluna($a0,$a1,corPac,bitmap_address)
	lw $a0, 4($sp) #passa o valor do fim da coluna	
	addi $a1, $zero, 4
	addi $a2, $zero, 2
	lw $a3, 8($sp)
	lw   $v0,bitmap_address	
	desenhar_obstaculo($a0,$a1,$a2,corPac,bitmap_address)
	lw $ra,16($sp)
	addi $sp,$sp,20
	jr $ra

#Procedimeto para desenhar a letra V
# $a0 -> Argumento com endere�o inicial
.macro desenharV(%endIni)
	add $a0,$zero,%endIni
	jal desenhar_v_function
.end_macro
desenhar_v_function:
	addi $sp,$sp,-4
	sw   $ra,0($sp)
	###############
	lw  $t4, bitmap_address #carregando endere�o base
	#Adicionando imediatos a o endere�o base
	add $t0,$a0,$zero
	#salva os registros
	add $sp,$sp,-4
	sw  $t0,0($sp)				
	desenhar_obstaculo($t0,1,4,corPac,bitmap_address)
	lw  $t0,0($sp)				
	addi $t0,$t0,1024
	addi $t0,$t0,4
	#salva os registros
	sw  $t0,0($sp)				
	desenhar_obstaculo($t0,1,3,corPac,bitmap_address)
	lw  $t0,0($sp)
	addi $t0,$t0,768
	addi $t0,$t0,4
	#salva os registros
	sw  $t0,0($sp)
	desenhar_obstaculo($t0,1,2,corPac,bitmap_address)
	lw  $t0,0($sp)
	addi $t0,$t0,512
	addi $t0,$t0,4
	#salva os registros
	sw  $t0,0($sp)
	desenhar_obstaculo($t0,1,2,corPac,bitmap_address)
	
	#####Subindo no desenho do V
	lw  $t0,0($sp)
	addi $t0,$t0,-512
	addi $t0,$t0,4
	#salva os registros
	sw  $t0,0($sp)
	desenhar_obstaculo($t0,1,2,corPac,bitmap_address)
	lw  $t0,0($sp)
	addi $t0,$t0,-768
	addi $t0,$t0,4
	#salva os registros
	sw  $t0,0($sp)
	desenhar_obstaculo($t0,1,3,corPac,bitmap_address)
	lw  $t0,0($sp)
	addi $t0,$t0,-1024
	addi $t0,$t0,4
	#salva os registros
	sw  $t0,0($sp)
	desenhar_obstaculo($t0,1,4,corPac,bitmap_address)
	addi $sp,$sp,4
	
	lw   $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

#Procedimento para desenhar o numero do level
# $a0 -> Argumento com o n�mero indicando o N�vel
.macro desenhar_lado(%level)
	add $a0,$zero,%level
	jal desenhar_lado_function
.end_macro
desenhar_lado_function:
	addi $sp,$sp,-8
	sw   $ra,0($sp)
	sw   $a0,4($sp)
        desenharL(396,2956,corPac,bitmap_address)           
        desenharV(672)        
        desenharL(448,3008,corPac,bitmap_address)
        lw   $t0,4($sp)
        desenhar_numero($t0,732,corPac,bitmap_address)       	        
        
        lw   $ra,0($sp)
        addi $sp,$sp,8
        jr $ra
        
