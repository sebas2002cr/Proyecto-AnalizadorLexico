.data
salto_linea: .asciiz "\n"
resultado_read: .space 100
string_emxjbogyym: .asciiz "imprimir string"
string_urtwxyjdwk: .asciiz "hola"

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
la $t0, string_emxjbogyym
move $a0, $t0
li $v0, 4
syscall
jal imprimir_salto_linea

# Declaración y asignación de variable: var, Tipo: STRING
la $t0, string_urtwxyjdwk
sw $t0, 0($sp)
addu $sp, $sp, 4

# Declaración de variable: num, Tipo: INT
subu $sp, $sp, 4
sw $t0, 0($sp)

# Declaración y asignación de variable: fr, Tipo: BOOLEAN
li $t0, 1
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

# Print semantic.Operacion@24d46ca6
li $t0, 3
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 4
# MULTIPLICACION
lw $t1, 0($sp)
addiu $sp, $sp, 4
mul $t0, $t0, $t1
# SUMA
lw $t1, 0($sp)
addiu $sp, $sp, 4
add $t0, $t0, $t1
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@4517d9a3
li $t0, 14
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 2
# DIVISION
lw $t1, 0($sp)
addiu $sp, $sp, 4
div $t1, $t0
mflo $t0
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@372f7a8d
li $t0, 1
# INCREMENTO
addi $t0, $t0, 1
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@2f92e0f4
li $t0, 1
# DECREMENTO
addi $t0, $t0, -1
addi $t0, $t0, -1
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@28a418fc
li $t0, 1
# NEGATIVO
li $t1, -1
mul $t0, $t0, $t1
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@5305068a
li $t0, 1
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 2
# DISTINTO
lw $t1, 0($sp)
addiu $sp, $sp, 4
bne $t0, $t1, distinto_cgghcipzez
li $t0, 0
j no_distinto_cgghcipzez
distinto_cgghcipzez: li $t0, 1
no_distinto_cgghcipzez:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@4a574795
li $t0, 1
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 2
# IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
beq $t0, $t1, igual_dfaluinhdp
li $t0, 0
j no_igual_dfaluinhdp
igual_dfaluinhdp: li $t0, 1
no_igual_dfaluinhdp:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@f6f4d33
li $t0, 1
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# MENOR
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@23fc625e
li $t0, 1
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# MAYOR
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t0, $t1
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@3f99bd52
li $t0, 1
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# MENOR_IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t0, $t1
li $t1, 0
beq $t0, $t1, menor_igual_oeiglmyfpu
li $t0, 0
j no_menor_igual_oeiglmyfpu
menor_igual_oeiglmyfpu: li $t0, 1
no_menor_igual_oeiglmyfpu:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@4f023edb
li $t0, 0
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# MENOR_IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t0, $t1
li $t1, 0
beq $t0, $t1, menor_igual_nheuggdbld
li $t0, 0
j no_menor_igual_nheuggdbld
menor_igual_nheuggdbld: li $t0, 1
no_menor_igual_nheuggdbld:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@3a71f4dd
li $t0, 2
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# MENOR_IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t0, $t1
li $t1, 0
beq $t0, $t1, menor_igual_ndimxvhzhm
li $t0, 0
j no_menor_igual_ndimxvhzhm
menor_igual_ndimxvhzhm: li $t0, 1
no_menor_igual_ndimxvhzhm:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@7adf9f5f
li $t0, 1
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# MAYOR_IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
li $t1, 0
beq $t0, $t1, mayor_igual_lprlwsxcfc
li $t0, 0
j no_mayor_igual_lprlwsxcfc
mayor_igual_lprlwsxcfc: li $t0, 1
no_mayor_igual_lprlwsxcfc:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@85ede7b
li $t0, 0
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# MAYOR_IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
li $t1, 0
beq $t0, $t1, mayor_igual_puqtiiluam
li $t0, 0
j no_mayor_igual_puqtiiluam
mayor_igual_puqtiiluam: li $t0, 1
no_mayor_igual_puqtiiluam:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@5674cd4d
li $t0, 2
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# MAYOR_IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
li $t1, 0
beq $t0, $t1, mayor_igual_wfsmhycpot
li $t0, 0
j no_mayor_igual_wfsmhycpot
mayor_igual_wfsmhycpot: li $t0, 1
no_mayor_igual_wfsmhycpot:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@63961c42
li $t0, 9
# SUMA
lw $t1, 0($sp)
addiu $sp, $sp, 4
add $t0, $t0, $t1
# MENOR_IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t0, $t1
li $t1, 0
beq $t0, $t1, menor_igual_jowqlmdfma
li $t0, 0
j no_menor_igual_jowqlmdfma
menor_igual_jowqlmdfma: li $t0, 1
no_menor_igual_jowqlmdfma:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@65b54208
li $t0, 1
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# AND
lw $t1, 0($sp)
addiu $sp, $sp, 4
and $t0, $t0, $t1
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@1be6f5c3
li $t0, 2
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 3
# POTENCIA
lw $t1, 0($sp)
addiu $sp, $sp, 4
jal potencia
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@6b884d57
li $t0, 10
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 4
# POTENCIA
lw $t1, 0($sp)
addiu $sp, $sp, 4
jal potencia
move $a0, $t0
li $v0, 1
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
