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
   
################## LETRAS ############################### 
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
# $a0 -> Argumento com endereço inicial
.macro desenharV(%endIni)
	add $a0,$zero,%endIni
	jal desenhar_v_function
.end_macro
desenhar_v_function:
	addi $sp,$sp,-4
	sw   $ra,0($sp)
	###############
	lw  $t4, bitmap_address #carregando endereço base
	#Adicionando imediatos a o endereço base
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

###################################### VIDAS ################################################################
#Procedimento para desenhar corações
# $a0 -> Argumento com o endereço inicial da caixinha(Será uma caixa 5x5)
.macro desenhar_coracao(%endIni)
	add $a0,$zero,%endIni
	jal desenhar_coracao_funtion
.end_macro
desenhar_coracao_funtion:
	addi $sp,$sp,-4
	sw   $ra,0($sp)
	##############
	addi $t0,$a0,0 #salvando endereco inicial em $t0
	addi $t1,$t0,0 #registrador auxiliar para incremento
	
	#desenhando pontas do coração
	addi $t1,$t1,4
	addi $sp,$sp,-8
	#Salvando Registros
	sw   $t0,0($sp)
	sw   $t1,4($sp)
	desenhar_obstaculo($t1,1,1,corVernelha,bitmap_address)
	lw   $t0,0($sp)
	lw   $t1,4($sp)
	
	addi $t1,$t1,8
	
	sw   $t0,0($sp)
	sw   $t1,4($sp)
	desenhar_obstaculo($t1,1,1,corVernelha,bitmap_address)
	lw   $t0,0($sp)
	lw   $t1,4($sp)
	
	add $t1,$zero,$t0 #reinicializando $t1
	addi $t1,$t1,256
	sw   $t0,0($sp)
	sw   $t1,4($sp)
	desenhar_obstaculo($t1,5,2,corVernelha,bitmap_address)
	lw   $t0,0($sp)
	lw   $t1,4($sp)
	
	addi $t1,$t1,516 #256*2+4 
	sw   $t0,0($sp)
	sw   $t1,4($sp)
	desenhar_obstaculo($t1,3,1,corVernelha,bitmap_address)
	lw   $t0,0($sp)
	lw   $t1,4($sp)
	
	add $t1,$zero,$t0 #reinicializando $t1
	addi $t1,$t1,1032
	sw   $t0,0($sp)
	sw   $t1,4($sp)
	desenhar_obstaculo($t1,1,1,corVernelha,bitmap_address)
	addi $sp,$sp,8
	#############################
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

#Procedimento para desenhar vidas ao lado do mapa
# $a0 -> Argumento com o endereço inicial da caixinha(Será uma caixa 5x5) 
#        Relativo as três vidas a serem desenhadas 
.macro desenhar_vidas(%endIni)
	add $a0,$zero,%endIni
	jal desenhar_vidas_function
.end_macro
desenhar_vidas_function:
	addi $sp,$sp,-8
	sw   $ra,0($sp)
	##############
	sw   $a0,4($sp)
	desenhar_coracao($a0)
	lw   $a0,4($sp)
	addi $a0,$a0,28
	sw   $a0,4($sp)
	desenhar_coracao($a0)
	lw   $a0,4($sp)
	addi $a0,$a0,28
	sw   $a0,4($sp)
	desenhar_coracao($a0)
	lw   $a0,4($sp)
	
	lw   $ra,0($sp)
	addi $sp,$sp,8
	jr $ra	

#Procedimento para apagar a vida do mapa
# $a0 -> Argumento com o endereço inicial da caixinha 5x5 onde a vida está contida
.macro apagar_vida(%endIni)
	add $a0,$zero,%endIni
	jal apagar_vida_function
.end_macro
apagar_vida_function:
	addi $sp,$sp,-4
	sw   $ra,0($sp)
	desenhar_obstaculo($a0,5,5,corPreta,bitmap_address)
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

######################################################################################################


#Procedimento para desenhar o numero do level
# $a0 -> Argumento com o número indicando o Nível
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
        
        desenhar_vidas(6792)
        
        lw   $ra,0($sp)
        addi $sp,$sp,8
        jr $ra
        
