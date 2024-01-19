.data
salto_linea: .asciiz "\n"
resultado_read: .space 100
string_teoqjnmhmd: .asciiz "imprimir string"
string_ghrkvklsua: .asciiz "hola"
string_ibxidgquvk: .asciiz "escribe string"
string_oykakpbqxj: .asciiz "escribe entero"
string_nvrzwjkbst: .asciiz "escribe flotante"

.text
main:

# LineaExpresion: Literal -> 123
li $t0, 123

# Print 1092
li $t0, 1092
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print "imprimir string"
la $t0, string_teoqjnmhmd
move $a0, $t0
li $v0, 4
syscall
jal imprimir_salto_linea

# Declaración y asignación de variable: var, Tipo: STRING
la $t0, string_ghrkvklsua
lw $t0, 0($sp)
sw $t0, 0($sp)
addu $sp, $sp, 4

# Declaración de variable: num, Tipo: INT
subu $sp, $sp, 4
sw $t0, 0($sp)

# Declaración y asignación de variable: fr, Tipo: BOOLEAN
li $t0, 1
lw $t0, 0($sp)
sw $t0, 0($sp)
addu $sp, $sp, 4

# Print true
li $t0, 1
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print 'a'
li $t0, 97
move $a0, $t0
li $v0, 11
syscall
jal imprimir_salto_linea

# Print 3.14
li.s $f0, 3.14
mov.s $f12, $f0
li $v0, 2
syscall
jal imprimir_salto_linea

# Print "escribe string"
la $t0, string_ibxidgquvk
move $a0, $t0
li $v0, 4
syscall
jal imprimir_salto_linea

# Print Read
# Read STRING
li $v0, 8
la $a0, resultado_read
la $a1, 100
syscall
la $t0, resultado_read
move $a0, $t0
li $v0, 4
syscall
jal imprimir_salto_linea

# Print "escribe entero"
la $t0, string_oykakpbqxj
move $a0, $t0
li $v0, 4
syscall
jal imprimir_salto_linea

# Print Read
# Read INT
li $v0, 5
syscall
move $t0, $v0
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print "escribe flotante"
la $t0, string_nvrzwjkbst
move $a0, $t0
li $v0, 4
syscall
jal imprimir_salto_linea

# Print Read
# Read FLOAT
li $v0, 6
syscall
mov.s $f12, $f0
li $v0, 2
syscall
jal imprimir_salto_linea

# Terminar el programa
li $v0, 10
syscall


imprimir_salto_linea:
	li, $v0, 4
	la $a0, salto_linea
	syscall
	jr $ra
