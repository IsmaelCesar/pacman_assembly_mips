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

################ Movimentos Básicos #####################
#### Procedimento para mover um peronagem para cima
# $a0 -> endereço contendo a posição do personagem anderior
# $a1 -> Cor do personagem
.macro mover_para_cima(%posIni,%corPers)
	add $a0,$zero,%posIni
	add $a1,$zero,%corPers
	jal mover_para_cima_function
.end_macro
mover_para_cima_function:

	addi $t0,$a0,0 #Salvando endereço em temporário

