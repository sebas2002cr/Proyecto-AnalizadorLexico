.data
salto_linea: .asciiz "\n"
resultado_read: .space 100
string_ydeqvbelfr: .asciiz "en main"
string_odaveuwsyo: .asciiz "\n"
string_tkeuoiplql: .asciiz "prueba en prueba"
string_svclnkqpkv: .asciiz "variable"
string_hrtvxjqhgo: .asciiz "\nfunciÃ³n de string"

.text
main:
move $fp, $sp

# LineaExpresion: LlamadaFuncion -> prueba
subu $sp, $sp, 4 # Aparta campo en la pila para el $fp
sw $fp, 0($sp) # Guarda el $fp
move $fp, $sp # Nuevo registro de activación para la función actual
jal function_prueba
addu $sp, $sp, 0 # Libera los parámetros de la pila
lw $fp, 0($sp) # Restaura el $fp anterior
addu $sp, $sp, 4 # Libera el fp de la pila

# Print cadena
subu $sp, $sp, 4 # Aparta campo en la pila para el $fp
sw $fp, 0($sp) # Guarda el $fp
move $fp, $sp # Nuevo registro de activación para la función actual
li $t0, 11
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 12
subu $sp, $sp, 4
sw $t0, 0($sp)
jal function_cadena
addu $sp, $sp, 8 # Libera los parámetros de la pila
lw $fp, 0($sp) # Restaura el $fp anterior
addu $sp, $sp, 4 # Libera el fp de la pila
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Declaración y asignación de variable: texto, Tipo: STRING
la $t0, string_ydeqvbelfr
subu $sp, $sp, 4
sw $t0, 0($sp)

# Print "\n"
la $t0, string_odaveuwsyo
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Print texto
lw $t0, -4($fp)
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Terminar el programa
li $v0, 10
syscall

function_prueba:

# Print "prueba en prueba"
la $t0, string_tkeuoiplql
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

li $t0, 1
# Return
addu $sp, $sp, 0 # Libera las variables de la pila
jr $ra

# Salir funcion prueba
addu $sp, $sp, 0 # Libera las variables de la pila
jr $ra
function_cadena:

# Declaración y asignación de variable: variable, Tipo: STRING
la $t0, string_svclnkqpkv
subu $sp, $sp, 4
sw $t0, 0($sp)

# Print "\n"
la $t0, string_odaveuwsyo
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Print variable
lw $t0, -12($fp)
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Declaración y asignación de variable: numero, Tipo: INT
li $t0, 20
subu $sp, $sp, 4
sw $t0, 0($sp)

# LineaExpresion: Operacion -> semantic.Operacion@27bc2616
lw $t0, -16($fp)
# DECREMENTO
addi $t0, $t0, -1
sw $t0, -16($fp)

# Print "\n"
la $t0, string_odaveuwsyo
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Print numero
lw $t0, -16($fp)
move $a0, $t0
li $v0, 1
syscall
# jal imprimir_salto_linea

la $t0, string_hrtvxjqhgo
# Return
addu $sp, $sp, 8 # Libera las variables de la pila
jr $ra

# Salir funcion cadena
addu $sp, $sp, 8 # Libera las variables de la pila
jr $ra

imprimir_salto_linea:
	li, $v0, 4
	la $a0, salto_linea
	syscall
	jr $ra

potencia:
	# $t1: base
	# $t0: exponente
	# $t0 -> resultado
	li $t2, 1
	multiplicar_potencia:
	beq $t0, $zero, salir_potencia
		mul $t2, $t2, $t1
		addi $t0, $t0, -1
		j multiplicar_potencia
	salir_potencia:
		move $t0, $t2
		jr $ra
