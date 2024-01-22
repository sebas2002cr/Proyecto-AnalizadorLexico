.data
salto_linea: .asciiz "\n"
resultado_read: .space 100
string_qcjbrkfygy: .asciiz "\n"
string_mrtpqbbhip: .asciiz "es 0"
string_gxjeghwkvv: .asciiz "es 1"
string_rywfuypoos: .asciiz "es otro"

.text
function_factorial:

# Declaración y asignación de variable: resultado, Tipo: INT
li $t0, 1
subu $sp, $sp, 4
sw $t0, 0($sp)

# Do until
do_until_azchglwrmp:

# Asignación de variable: resultado
lw $t0, -8($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
lw $t0, -4($fp)
# MULTIPLICACION
lw $t1, 0($sp)
addiu $sp, $sp, 4
mul $t0, $t0, $t1
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
beq $t0, $t1, igual_khtdnadmwq
li $t0, 0
j no_igual_khtdnadmwq
igual_khtdnadmwq: li $t0, 1
no_igual_khtdnadmwq:
beq $t0, $zero, do_until_azchglwrmp
final_do_until_azchglwrmp:

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
la $t0, string_qcjbrkfygy
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
la $t0, string_qcjbrkfygy
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
la $t0, string_qcjbrkfygy
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
la $t0, string_qcjbrkfygy
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
mul $t0, $t0, $t1
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
for_inicio_wknohsqqhr:
lw $t0, -16($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
lw $t0, -8($fp)
# MENOR
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
beq $t0, $zero, for_fin_wknohsqqhr

# Asignación de variable: resultado
lw $t0, -12($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
lw $t0, -4($fp)
# MULTIPLICACION
lw $t1, 0($sp)
addiu $sp, $sp, 4
mul $t0, $t0, $t1
sw $t0, -12($fp)
lw $t0, -16($fp)
# INCREMENTO
addi $t0, $t0, 1
sw $t0, -16($fp)
j for_inicio_wknohsqqhr
for_fin_wknohsqqhr:

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
beq $t0, $t1, igual_koqqxtlkyu
li $t0, 0
j no_igual_koqqxtlkyu
igual_koqqxtlkyu: li $t0, 1
no_igual_koqqxtlkyu:
beq $t0, $zero, sino_if_cojszebnvo
if_cojszebnvo:

la $t0, string_mrtpqbbhip
# Return
addu $sp, $sp, 0 # Libera las variables de la pila
jr $ra
j fin_if_cojszebnvo
sino_if_cojszebnvo:
# Elif 
lw $t0, -4($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
beq $t0, $t1, igual_hgahzpiskv
li $t0, 0
j no_igual_hgahzpiskv
igual_hgahzpiskv: li $t0, 1
no_igual_hgahzpiskv:
beq $t0, $zero, sino_elif_mztbluwuhg
elif_mztbluwuhg:

la $t0, string_gxjeghwkvv
# Return
addu $sp, $sp, 0 # Libera las variables de la pila
jr $ra
j fin_elif_mztbluwuhg
sino_elif_mztbluwuhg:
# Else
elsedrvlmpwmrv:

la $t0, string_rywfuypoos
# Return
addu $sp, $sp, 0 # Libera las variables de la pila
jr $ra
fin_else_drvlmpwmrv:
fin_elif_mztbluwuhg:
fin_if_cojszebnvo:

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
for_inicio_rwxmnobkmj:
lw $t0, -4($fp)
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 10
# MENOR
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
beq $t0, $zero, for_fin_rwxmnobkmj

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
beq $t0, $t1, igual_puvrnfeghy
li $t0, 0
j no_igual_puvrnfeghy
igual_puvrnfeghy: li $t0, 1
no_igual_puvrnfeghy:
beq $t0, $zero, sino_if_zmhcjbzmse
if_zmhcjbzmse:

j for_fin_rwxmnobkmj
j fin_if_zmhcjbzmse
sino_if_zmhcjbzmse:
fin_if_zmhcjbzmse:
lw $t0, -4($fp)
# INCREMENTO
addi $t0, $t0, 1
sw $t0, -4($fp)
j for_inicio_rwxmnobkmj
for_fin_rwxmnobkmj:

li $t0, 49
# Return
addu $sp, $sp, 4 # Libera las variables de la pila
jr $ra

# Salir funcion prueba
addu $sp, $sp, 4 # Libera las variables de la pila
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
