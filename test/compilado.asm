.data
salto_linea: .asciiz "\n"

.text
main:

# Declaración de variable: num, Tipo: INT
subu $sp, $sp, 4
sw $t0, 0($sp)

# Declaración y asignación de variable: var, Tipo: FLOAT
li.s $f0, 345.45
s.s $f0, 0($sp)
addu $sp, $sp, 4

# Declaración y asignación de variable: var, Tipo: STRING
lw $t0, 0($sp)
sw $t0, 0($sp)
addu $sp, $sp, 4

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

