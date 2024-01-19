.data
salto_linea: .asciiz "\n"
string_wmirffmqac: .asciiz "imprimir string"

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
la $t0, string_wmirffmqac
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
# Guardar el antiguo valor de $fp
subu $sp, $sp, 4
sw $fp, 0($sp)
# Establecer $fp igual a $sp
move $fp, $sp
# Llamada a la función
jal prueba
# Limpiar la pila después de la llamada
addu $sp, $fp, 0
# Restaurar el valor antiguo de $fp
lw $fp, 0($sp)
addu $sp, $sp, 4

# Terminar el programa
li $v0, 10
syscall

function_prueba:

# Salir funcion prueba
jr $ra

imprimir_salto_linea:
	li, $v0, 4
	la $a0, salto_linea
	syscall
	jr $ra

