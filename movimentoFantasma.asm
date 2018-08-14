#Coloca em $vo se o fantasma está dentro da caixa
# $v0 é 1 quando está
# $v0 é 0  se não está
.macro dentroDaCaixaM1(%pos)
	move $a0, %pos
	addi $a1, $0, 3896
	move $t1, $a1
		move $t3, $0
	move $v0, $0
	jal dentroDaCaixaM1_function
.end_macro

dentroDaCaixaM1_function:
	save_return_address
	loop_linha:
		beq $t3, 3, soma
		beq $a0, $t1, esta
		addi $t1, $t1, 4
		addi $t3, $t3, 1
	j loop_linha
soma:	
	beq $t1, 4676, sair
	addi $t1, $a1, 256
	move $a1, $t1
	move $t3, $0
	j loop_linha
esta:
	addi $v0, $0, 1
	get_return_address
	jr $ra
sair:
	beq $a0, $t1, esta
	get_return_address
	jr $ra
#	movimento = 0 é esquerda
#	movimento = 1 é direita
#	movimento = 2 é cima
#	movimento = 3 é baixo
#	$v0 é o movimento que ele deve executar
.macro verificandoMovimento(%pos, %movimento, %corBorda)
	move $a0, %pos
	move $a1, %movimento
	la $a2, %corBorda
	jal verificandoMovimento_function
.end_macro
verificandoMovimento_function:
	save_return_address
	beq $a1, 0, esquerda
	beq $a1, 1, direita
	beq $a1, 2, cima
	beq $a1, 3, baixo
esquerda:
	addi $t0, $a0, -4 #verificando esquerda
	beq  $t0, $a2, naoPode
	addi $v0, $0, 0
	get_return_address
	jr $ra
direita:
	addi $t0, $a0,  4 #verificando direita
	beq  $t0, $a2, naoPode
	addi $v0, $0, 1
	get_return_address
	jr $ra
cima:
	addi $t0, $a0, 256 #verificando direita
	beq  $t0, $a2, naoPode
	addi $v0, $0, 2
	get_return_address
	jr $ra
baixo:
	addi $t0, $a0, -256 #verificando direita
	beq  $t0, $a2, naoPodeBaixo
	addi $v0, $0, 3
	get_return_address
	jr $ra
naoPode:
	addi $a1, $a1, 1
	j verificandoMovimento_function
naoPodeBaixo:
	move $a1, $0
	j verificandoMovimento_function

.macro gerarNumero
	li $v0, 42
	li $a0, 0
	li $a1, 3
	syscall
	move $v0, $a0
.end_macro	 
# $s3 é o laranja
.macro movimento_laranja(%mapa)
	addi $a0, $0, %mapa
	jal movimento_laranja_function
.end_macro
movimento_laranja_function:
	save_return_address
	dentroDaCaixaM1($s3)
	beq $v0, 1, sairDaCaixaM1
	j movendoLaranja
sairDaCaixaM1:
	move $t0, $0
		mover_para_cima($s3,corLaranja)
		move $s3, $v0
	get_return_address
	jr $ra
 movendoLaranja:
 	gerarNumero
 	verificandoMovimento($s3, $v0, cor_mapa)
 	beq $v0, 0, moverEsquerdaLaranja
 	beq $v0, 1, moverDireitaLaranja
 	beq $v0, 2, moverCimaLaranja
 	beq $v0, 3, moverBaixoLaranja
 moverEsquerdaLaranja:
 	move $t0, $0
 	mover_para_esquerda($s3,corLaranja)
 	move $s3, $v0
 	j sair2
 moverDireitaLaranja:
 	move $t0, $0
 	mover_para_direita($s3,corLaranja)
 	move $s3, $v0
 	j sair2
 moverCimaLaranja:
 	move $t0, $0
 	mover_para_cima($s3,corLaranja)
 	move $s3, $v0
 	j sair2
 moverBaixoLaranja:
 	move $t0, $0
 	mover_para_baixo($s3,corLaranja)
 	move $s3, $v0
 	j sair2
 sair2:
 	get_return_address
	jr $ra
