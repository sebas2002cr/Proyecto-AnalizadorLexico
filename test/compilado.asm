.data
salto_linea: .asciiz "\n"
string_xlzsrgwycy: .asciiz "imprimir string"

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
la $t0, string_xlzsrgwycy
move $a0, $t0
li $v0, 4
syscall
jal imprimir_salto_linea

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

# LineaExpresion: LlamadaFuncion -> prueba
move $fp, $sp
jal prueba
addu $sp, $sp, 0

# Terminar el programa
li $v0, 10
syscall

function_prueba:

# Salir funcion prueba
addu $sp, $sp, 8
jr $ra

imprimir_salto_linea:
	li, $v0, 4
	la $a0, salto_linea
	syscall
	jr $ra

