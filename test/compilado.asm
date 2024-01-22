.data
salto_linea: .asciiz "\n"
resultado_read: .space 100
string_kwwkmgrxql: .asciiz "\n"
string_yqhryemdpu: .asciiz "es 0"
string_asulgqngnf: .asciiz "es 1"
string_qnnbyepgyg: .asciiz "es otro"

.text
function_factorial:

# Declaración y asignación de variable: resultado, Tipo: INT
li $t0, 1
subu $sp, $sp, 4
sw $t0, 0($sp)

# Do until
do_until_dpdlvlfnlh:

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

# LineaExpresion: Operacion -> semantic.Operacion@7cd84586
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
beq $t0, $t1, igual_jojdmrquyz
li $t0, 0
j no_igual_jojdmrquyz
igual_jojdmrquyz: li $t0, 1
no_igual_jojdmrquyz:
beq $t0, $zero, do_until_dpdlvlfnlh
final_do_until_dpdlvlfnlh:

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
la $t0, string_kwwkmgrxql
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
la $t0, string_kwwkmgrxql
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
la $t0, string_kwwkmgrxql
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
la $t0, string_kwwkmgrxql
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
la $t0, string_kwwkmgrxql
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

# Print "\n"
la $t0, string_kwwkmgrxql
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Print semantic.Operacion@79fc0f2f
li $t0, 2
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# MAYOR
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t0, $t1
# AND
lw $t1, 0($sp)
addiu $sp, $sp, 4
and $t0, $t0, $t1
move $a0, $t0
li $v0, 1
syscall
# jal imprimir_salto_linea

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
for_inicio_wciqmpsdjv:
lw $t0, -16($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
lw $t0, -8($fp)
# MENOR
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
beq $t0, $zero, for_fin_wciqmpsdjv

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
j for_inicio_wciqmpsdjv
for_fin_wciqmpsdjv:

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
beq $t0, $t1, igual_cbkmnrdcwy
li $t0, 0
j no_igual_cbkmnrdcwy
igual_cbkmnrdcwy: li $t0, 1
no_igual_cbkmnrdcwy:
beq $t0, $zero, sino_if_mfyovplfqy
if_mfyovplfqy:

la $t0, string_yqhryemdpu
# Return
addu $sp, $sp, 0 # Libera las variables de la pila
jr $ra
j fin_if_mfyovplfqy
sino_if_mfyovplfqy:
# Elif 
lw $t0, -4($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
beq $t0, $t1, igual_bqvxgftpvo
li $t0, 0
j no_igual_bqvxgftpvo
igual_bqvxgftpvo: li $t0, 1
no_igual_bqvxgftpvo:
beq $t0, $zero, sino_elif_smpkfinrcr
elif_smpkfinrcr:

la $t0, string_asulgqngnf
# Return
addu $sp, $sp, 0 # Libera las variables de la pila
jr $ra
j fin_elif_smpkfinrcr
sino_elif_smpkfinrcr:
# Else
elsegnsqrixydv:

la $t0, string_qnnbyepgyg
# Return
addu $sp, $sp, 0 # Libera las variables de la pila
jr $ra
fin_else_gnsqrixydv:
fin_elif_smpkfinrcr:
fin_if_mfyovplfqy:

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
for_inicio_cjkeebzffx:
lw $t0, -4($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 10
# MENOR
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
beq $t0, $zero, for_fin_cjkeebzffx

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
beq $t0, $t1, igual_eejxwclnmy
li $t0, 0
j no_igual_eejxwclnmy
igual_eejxwclnmy: li $t0, 1
no_igual_eejxwclnmy:
beq $t0, $zero, sino_if_yzocloocfx
if_yzocloocfx:

j for_fin_cjkeebzffx
j fin_if_yzocloocfx
sino_if_yzocloocfx:
fin_if_yzocloocfx:
lw $t0, -4($fp)
# INCREMENTO
addi $t0, $t0, 1
sw $t0, -4($fp)
j for_inicio_cjkeebzffx
for_fin_cjkeebzffx:

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
for_inicio_tdolpqcqea:
lw $t0, -12($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
lw $t0, -4($fp)
# MENOR
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
beq $t0, $zero, for_fin_tdolpqcqea

# For
# Asignación de variable: j
li $t0, 0
sw $t0, -8($fp)
for_inicio_qiuxwzpcpe:
lw $t0, -8($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
lw $t0, -4($fp)
# MENOR
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
beq $t0, $zero, for_fin_qiuxwzpcpe

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
j for_inicio_qiuxwzpcpe
for_fin_qiuxwzpcpe:
lw $t0, -12($fp)
# INCREMENTO
addi $t0, $t0, 1
sw $t0, -12($fp)
j for_inicio_tdolpqcqea
for_fin_tdolpqcqea:

# Declaración de variable: lista, Tipo: LIST_INT
subu $sp, $sp, 4
sw $t0, 0($sp)

li $t0, 0
# Return
addu $sp, $sp, 12 # Libera las variables de la pila
jr $ra

# Salir funcion ciclo
addu $sp, $sp, 12 # Libera las variables de la pila
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
