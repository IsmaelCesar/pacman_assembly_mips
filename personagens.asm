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

################ Movimentos B�sicos #####################
#### Procedimento para mover um peronagem para cima
# $a0 -> endere�o contendo a posi��o do personagem anderior
# $a1 -> Cor do personagem
.macro mover_para_cima(%posIni,%corPers)
	add $a0,$zero,%posIni
	add $a1,$zero,%corPers
	jal mover_para_cima_function
.end_macro
mover_para_cima_function:

	addi $t0,$a0,0 #Salvando endere�o em tempor�rio

