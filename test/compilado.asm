.data
salto_linea: .asciiz "\n"
resultado_read: .space 100
string_zvltjqnoeu: .asciiz "prueba en MAIN\n"
string_kusmrrqrga: .asciiz "prueba en prueba"
string_vwwujlkajv: .asciiz "\nnumero: "
string_zjdpftsxkw: .asciiz "variable"
string_qhnzilesic: .asciiz "\n"
string_yybaquviks: .asciiz "asignacion"
string_ndwlyjhkdf: .asciiz "var1"
string_fuorsagwtv: .asciiz "\nfunciÃ³n de string"

.text
main:

# LineaExpresion: LlamadaFuncion -> prueba
subu $sp, $sp, 4 # Aparta campo en la pila para el $fp
sw $fp, 0($sp) # Guarda el $fp
move $fp, $sp # Nuevo registro de activación para la función actual
jal function_prueba
addu $sp, $sp, 0 # Libera los parámetros de la pila
lw $fp, 0($sp) # Restaura el $fp anterior
addu $sp, $sp, 4 # Libera el fp de la pila

# Print "prueba en MAIN\n"
la $t0, string_zvltjqnoeu
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Print prueba
subu $sp, $sp, 4 # Aparta campo en la pila para el $fp
sw $fp, 0($sp) # Guarda el $fp
move $fp, $sp # Nuevo registro de activación para la función actual
jal function_prueba
addu $sp, $sp, 0 # Libera los parámetros de la pila
lw $fp, 0($sp) # Restaura el $fp anterior
addu $sp, $sp, 4 # Libera el fp de la pila
move $a0, $t0
li $v0, 1
syscall
# jal imprimir_salto_linea

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

# Terminar el programa
li $v0, 10
syscall

function_prueba:

# Print "prueba en prueba"
la $t0, string_kusmrrqrga
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

li $t0, 1
# Return
jr $ra

# Salir funcion prueba
jr $ra
function_cadena:

# Print "\nnumero: "
la $t0, string_vwwujlkajv
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Print numero1
lw $t0, -4($fp)
move $a0, $t0
li $v0, 1
syscall
# jal imprimir_salto_linea

# Declaración y asignación de variable: variable, Tipo: STRING
la $t0, string_zjdpftsxkw
subu $sp, $sp, 4
sw $t0, 0($sp)

# Print "\n"
la $t0, string_qhnzilesic
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

# Asignación de variable: variable
la $t0, string_yybaquviks
sw $t0, -12($fp)

# Print "\n"
la $t0, string_qhnzilesic
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

# Declaración de variable: var1, Tipo: STRING
subu $sp, $sp, 4
sw $t0, 0($sp)
# Declaración de variable: var2, Tipo: STRING
subu $sp, $sp, 4
sw $t0, 0($sp)

# Asignación de variable: var1
la $t0, string_ndwlyjhkdf
sw $t0, -16($fp)

# Print "\n"
la $t0, string_qhnzilesic
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Print var1
lw $t0, -16($fp)
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

la $t0, string_fuorsagwtv
# Return
jr $ra

# Salir funcion cadena
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
