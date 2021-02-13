.data
#Escolher tamanho de pixel 8x8 configuracao tamanho de display 512x256
# valor ask cacacteres A = 41, S = 53, D = 44, F = 46
cor:            .word 0x00000fff
preto:		.word 0x00ffffff
corPac:		.word 0x00f4f442
corComida:      .word 0x00ffffff	
cor_mapa:       .word 0x000000e6
bitmap_address: .word 0x10010000
key_board_addr: .word 0x00007f04
bitmap_size:    .word 16384 #  512 x 256 = 131072 / 8 Tamano de Pixel = 16284 pixls
.text	

.macro movimentar(%pos, %fim, %cor, %endBase)
	add $a0, $zero, %pos
	add $a1, $zero, %fim
	lw $a2, %cor
	lw $a3, %endBase
	jal movimentar_function
.end_macro

movimentar_function:
	add $a0, $a3, $a0 #Inclui o valor no endereço base
	add $a1, $a3, $a1 #Inclui o valor no endereço base
	lw $t0, preto
	sw  $t0,0($a0)
			addi $v0, $zero,31
			addi $a0, $zero,500
			syscall #espera meio segundo
	sw $a2, 0($a1)
.globl main
main:

	addi $t0, $zero, 0
	lw  $t5, bitmap_address
	lw  $t3, corPac
	sw  $t3,0($t5)
	
	addi $t1, $zero, 4
	
	addi $v0, $zero,31
	addi $a0, $zero,1000
	syscall #espera meio segundo
	movimentar($t0, $t1, corPac, bitmap_address)