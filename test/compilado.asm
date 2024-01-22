.data
salto_linea: .asciiz "\n"
resultado_read: .space 100
string_tqoqantugn: .asciiz "\n"
string_etksfqwahz: .asciiz "es 0"
string_xhsidcuhoc: .asciiz "es 1"
string_iuwiczqush: .asciiz "es otro"

.text
function_factorial:

# Declaración y asignación de variable: resultado, Tipo: INT
li $t0, 1
subu $sp, $sp, 4
sw $t0, 0($sp)

# Do until
do_until_affnizpysn:

# Asignación de variable: resultado
lw $t0, -8($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
lw $t0, -4($fp)
# MULTIPLICACION
lw $t1, 0($sp)
addiu $sp, $sp, 4
mul $t0, $t1, $t0
sw $t0, -8($fp)

# LineaExpresion: Operacion -> semantic.Operacion@b1bc7ed
lw $t0, -4($fp)
# DECREMENTO
addi $t0, $t0, -1
sw $t0, -4($fp)
lw $t0, -4($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
beq $t0, $t1, igual_zyogwbxahv
li $t0, 0
j no_igual_zyogwbxahv
igual_zyogwbxahv: li $t0, 1
no_igual_zyogwbxahv:
beq $t0, $zero, do_until_affnizpysn
final_do_until_affnizpysn:

lw $t0, -8($fp)
# Return
addu $sp, $sp, 4 # Libera las variables de la pila
jr $ra

# Salir funcion factorial
addu $sp, $sp, 4 # Libera las variables de la pila
jr $ra
main:
move $fp, $sp

# Print cuadrado
subu $sp, $sp, 4 # Aparta campo en la pila para el $fp
sw $fp, 0($sp) # Guarda el $fp
move $fp, $sp # Nuevo registro de activación para la función actual
li $t0, 4
subu $sp, $sp, 4
sw $t0, 0($sp)
jal function_cuadrado
addu $sp, $sp, 4 # Libera los parámetros de la pila
lw $fp, 0($sp) # Restaura el $fp anterior
addu $sp, $sp, 4 # Libera el fp de la pila
move $a0, $t0
li $v0, 1
syscall
# jal imprimir_salto_linea

# Print "\n"
la $t0, string_tqoqantugn
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Print potencia
subu $sp, $sp, 4 # Aparta campo en la pila para el $fp
sw $fp, 0($sp) # Guarda el $fp
move $fp, $sp # Nuevo registro de activación para la función actual
li $t0, 4
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 3
subu $sp, $sp, 4
sw $t0, 0($sp)
jal function_potencia
addu $sp, $sp, 8 # Libera los parámetros de la pila
lw $fp, 0($sp) # Restaura el $fp anterior
addu $sp, $sp, 4 # Libera el fp de la pila
move $a0, $t0
li $v0, 1
syscall
# jal imprimir_salto_linea

# Print "\n"
la $t0, string_tqoqantugn
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Print factorial
subu $sp, $sp, 4 # Aparta campo en la pila para el $fp
sw $fp, 0($sp) # Guarda el $fp
move $fp, $sp # Nuevo registro de activación para la función actual
li $t0, 6
subu $sp, $sp, 4
sw $t0, 0($sp)
jal function_factorial
addu $sp, $sp, 4 # Libera los parámetros de la pila
lw $fp, 0($sp) # Restaura el $fp anterior
addu $sp, $sp, 4 # Libera el fp de la pila
move $a0, $t0
li $v0, 1
syscall
# jal imprimir_salto_linea

# Print "\n"
la $t0, string_tqoqantugn
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Print indice
subu $sp, $sp, 4 # Aparta campo en la pila para el $fp
sw $fp, 0($sp) # Guarda el $fp
move $fp, $sp # Nuevo registro de activación para la función actual
li $t0, 2
subu $sp, $sp, 4
sw $t0, 0($sp)
jal function_indice
addu $sp, $sp, 4 # Libera los parámetros de la pila
lw $fp, 0($sp) # Restaura el $fp anterior
addu $sp, $sp, 4 # Libera el fp de la pila
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Print "\n"
la $t0, string_tqoqantugn
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# LineaExpresion: LlamadaFuncion -> prueba
subu $sp, $sp, 4 # Aparta campo en la pila para el $fp
sw $fp, 0($sp) # Guarda el $fp
move $fp, $sp # Nuevo registro de activación para la función actual
jal function_prueba
addu $sp, $sp, 0 # Libera los parámetros de la pila
lw $fp, 0($sp) # Restaura el $fp anterior
addu $sp, $sp, 4 # Libera el fp de la pila

# Print "\n"
la $t0, string_tqoqantugn
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# LineaExpresion: LlamadaFuncion -> ciclo
subu $sp, $sp, 4 # Aparta campo en la pila para el $fp
sw $fp, 0($sp) # Guarda el $fp
move $fp, $sp # Nuevo registro de activación para la función actual
li $t0, 2
subu $sp, $sp, 4
sw $t0, 0($sp)
jal function_ciclo
addu $sp, $sp, 4 # Libera los parámetros de la pila
lw $fp, 0($sp) # Restaura el $fp anterior
addu $sp, $sp, 4 # Libera el fp de la pila

# Terminar el programa
li $v0, 10
syscall

function_cuadrado:

lw $t0, -4($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
lw $t0, -4($fp)
# MULTIPLICACION
lw $t1, 0($sp)
addiu $sp, $sp, 4
mul $t0, $t1, $t0
# Return
addu $sp, $sp, 0 # Libera las variables de la pila
jr $ra

# Salir funcion cuadrado
addu $sp, $sp, 0 # Libera las variables de la pila
jr $ra
function_potencia:

# Declaración y asignación de variable: resultado, Tipo: INT
lw $t0, -4($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)

# For
# Declaración y asignación de variable: i, Tipo: INT
li $t0, 1
subu $sp, $sp, 4
sw $t0, 0($sp)
for_inicio_tbvjtblpce:
lw $t0, -16($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
lw $t0, -8($fp)
# MENOR
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
beq $t0, $zero, for_fin_tbvjtblpce

# Asignación de variable: resultado
lw $t0, -12($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
lw $t0, -4($fp)
# MULTIPLICACION
lw $t1, 0($sp)
addiu $sp, $sp, 4
mul $t0, $t1, $t0
sw $t0, -12($fp)
lw $t0, -16($fp)
# INCREMENTO
addi $t0, $t0, 1
sw $t0, -16($fp)
j for_inicio_tbvjtblpce
for_fin_tbvjtblpce:

lw $t0, -12($fp)
# Return
addu $sp, $sp, 8 # Libera las variables de la pila
jr $ra

# Salir funcion potencia
addu $sp, $sp, 8 # Libera las variables de la pila
jr $ra
function_indice:

# If 
lw $t0, -4($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 0
# IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
beq $t0, $t1, igual_ehqowhrnkq
li $t0, 0
j no_igual_ehqowhrnkq
igual_ehqowhrnkq: li $t0, 1
no_igual_ehqowhrnkq:
beq $t0, $zero, sino_if_jjqhvnnvpj
if_jjqhvnnvpj:

la $t0, string_etksfqwahz
# Return
addu $sp, $sp, 0 # Libera las variables de la pila
jr $ra
j fin_if_jjqhvnnvpj
sino_if_jjqhvnnvpj:
# Elif 
lw $t0, -4($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
beq $t0, $t1, igual_rcvlrxhfbw
li $t0, 0
j no_igual_rcvlrxhfbw
igual_rcvlrxhfbw: li $t0, 1
no_igual_rcvlrxhfbw:
beq $t0, $zero, sino_elif_ibwnjvqbqk
elif_ibwnjvqbqk:

la $t0, string_xhsidcuhoc
# Return
addu $sp, $sp, 0 # Libera las variables de la pila
jr $ra
j fin_elif_ibwnjvqbqk
sino_elif_ibwnjvqbqk:
# Else
elsebajfevbcvk:

la $t0, string_iuwiczqush
# Return
addu $sp, $sp, 0 # Libera las variables de la pila
jr $ra
fin_else_bajfevbcvk:
fin_elif_ibwnjvqbqk:
fin_if_jjqhvnnvpj:

# Salir funcion indice
addu $sp, $sp, 0 # Libera las variables de la pila
jr $ra
function_prueba:

# Declaración de variable: contador, Tipo: INT
subu $sp, $sp, 4
sw $t0, 0($sp)

# For
# Asignación de variable: contador
li $t0, 0
sw $t0, -4($fp)
for_inicio_wdxzmrmikw:
lw $t0, -4($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 10
# MENOR
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
beq $t0, $zero, for_fin_wdxzmrmikw

# Print contador
lw $t0, -4($fp)
move $a0, $t0
li $v0, 1
syscall
# jal imprimir_salto_linea

# Print ' '
li $t0, 32
move $a0, $t0
li $v0, 11
syscall
# jal imprimir_salto_linea

# If 
lw $t0, -4($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 5
# IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
beq $t0, $t1, igual_nzlluxxwnn
li $t0, 0
j no_igual_nzlluxxwnn
igual_nzlluxxwnn: li $t0, 1
no_igual_nzlluxxwnn:
beq $t0, $zero, sino_if_kcaozaqlay
if_kcaozaqlay:

j for_fin_wdxzmrmikw
j fin_if_kcaozaqlay
sino_if_kcaozaqlay:
fin_if_kcaozaqlay:
lw $t0, -4($fp)
# INCREMENTO
addi $t0, $t0, 1
sw $t0, -4($fp)
j for_inicio_wdxzmrmikw
for_fin_wdxzmrmikw:

li $t0, 49
# Return
addu $sp, $sp, 4 # Libera las variables de la pila
jr $ra

# Salir funcion prueba
addu $sp, $sp, 4 # Libera las variables de la pila
jr $ra
function_ciclo:

# Declaración y asignación de variable: j, Tipo: INT
li $t0, 0
subu $sp, $sp, 4
sw $t0, 0($sp)

# For
# Declaración y asignación de variable: i, Tipo: INT
li $t0, 0
subu $sp, $sp, 4
sw $t0, 0($sp)
for_inicio_zdidovyjom:
lw $t0, -12($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
lw $t0, -4($fp)
# MENOR
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
beq $t0, $zero, for_fin_zdidovyjom

# For
# Asignación de variable: j
li $t0, 0
sw $t0, -8($fp)
for_inicio_kcvxxobmnq:
lw $t0, -8($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
lw $t0, -4($fp)
# MENOR
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
beq $t0, $zero, for_fin_kcvxxobmnq

# Print '.'
li $t0, 46
move $a0, $t0
li $v0, 11
syscall
# jal imprimir_salto_linea
lw $t0, -8($fp)
# INCREMENTO
addi $t0, $t0, 1
sw $t0, -8($fp)
j for_inicio_kcvxxobmnq
for_fin_kcvxxobmnq:
lw $t0, -12($fp)
# INCREMENTO
addi $t0, $t0, 1
sw $t0, -12($fp)
j for_inicio_zdidovyjom
for_fin_zdidovyjom:

li $t0, 0
# Return
addu $sp, $sp, 8 # Libera las variables de la pila
jr $ra

# Salir funcion ciclo
addu $sp, $sp, 8 # Libera las variables de la pila
jr $ra

imprimir_salto_linea:
	li, $v0, 4
	la $a0, salto_linea
	syscall
	jr $ra

potencia_entera:
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

potencia_flotante:
	# $f1: base
	# $f0: exponente
	# $f0 -> resultado
	li.s $f2, 1.0
	li.s $f30, 0.0
	li.s $f31, 1.0
	loop_potencia_float:
       c.eq.s $f0, $f30
		bc1t fin_potencia_float
		mul.s $f2, $f2, $f1
		sub.s $f0, $f0, $f31
		j loop_potencia_float
	fin_potencia_float:
       mov.s $f0, $f2
       jr $ra
