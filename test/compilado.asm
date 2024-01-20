.data
salto_linea: .asciiz "\n"
resultado_read: .space 100
string_uyortncswf: .asciiz "imprimir string"
string_xpirsyxkhf: .asciiz "hola"

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
la $t0, string_uyortncswf
move $a0, $t0
li $v0, 4
syscall
jal imprimir_salto_linea

# Declaración y asignación de variable: var, Tipo: STRING
la $t0, string_xpirsyxkhf
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

# Print semantic.Operacion@52cc8049
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

# Print semantic.Operacion@5b6f7412
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

# Print semantic.Operacion@27973e9b
li $t0, 1
# INCREMENTO
addi $t0, $t0, 1
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@312b1dae
li $t0, 1
# DECREMENTO
addi $t0, $t0, -1
addi $t0, $t0, -1
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@7530d0a
li $t0, 1
# NEGATIVO
li $t1, -1
mul $t0, $t0, $t1
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@27bc2616
li $t0, 1
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 2
# DISTINTO
lw $t1, 0($sp)
addiu $sp, $sp, 4
bne $t0, $t1, distinto_flbxghxqky
li $t0, 0
j no_distinto_flbxghxqky
distinto_flbxghxqky: li $t0, 1
no_distinto_flbxghxqky:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@4edde6e5
li $t0, 1
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 2
# IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
beq $t0, $t1, igual_oefukmrvfk
li $t0, 0
j no_igual_oefukmrvfk
igual_oefukmrvfk: li $t0, 1
no_igual_oefukmrvfk:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@70177ecd
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

# Print semantic.Operacion@1e80bfe8
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

# Print semantic.Operacion@66a29884
li $t0, 1
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# MENOR_IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t0, $t1
li $t1, 0
beq $t0, $t1, menor_igual_hmmlhvqcro
li $t0, 0
j no_menor_igual_hmmlhvqcro
menor_igual_hmmlhvqcro: li $t0, 1
no_menor_igual_hmmlhvqcro:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@4769b07b
li $t0, 0
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# MENOR_IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t0, $t1
li $t1, 0
beq $t0, $t1, menor_igual_gizphpvssz
li $t0, 0
j no_menor_igual_gizphpvssz
menor_igual_gizphpvssz: li $t0, 1
no_menor_igual_gizphpvssz:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@cc34f4d
li $t0, 2
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# MENOR_IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t0, $t1
li $t1, 0
beq $t0, $t1, menor_igual_zujrnkaaiu
li $t0, 0
j no_menor_igual_zujrnkaaiu
menor_igual_zujrnkaaiu: li $t0, 1
no_menor_igual_zujrnkaaiu:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@17a7cec2
li $t0, 1
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# MAYOR_IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
li $t1, 0
beq $t0, $t1, mayor_igual_flnqikongr
li $t0, 0
j no_mayor_igual_flnqikongr
mayor_igual_flnqikongr: li $t0, 1
no_mayor_igual_flnqikongr:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@65b3120a
li $t0, 0
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# MAYOR_IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
li $t1, 0
beq $t0, $t1, mayor_igual_akujpsjkgi
li $t0, 0
j no_mayor_igual_akujpsjkgi
mayor_igual_akujpsjkgi: li $t0, 1
no_mayor_igual_akujpsjkgi:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@6f539caf
li $t0, 2
subu $sp, $sp, 4
sw $t0, 0($sp)
li $t0, 1
# MAYOR_IGUAL
lw $t1, 0($sp)
addiu $sp, $sp, 4
slt $t0, $t1, $t0
li $t1, 0
beq $t0, $t1, mayor_igual_igadugfvnf
li $t0, 0
j no_mayor_igual_igadugfvnf
mayor_igual_igadugfvnf: li $t0, 1
no_mayor_igual_igadugfvnf:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@79fc0f2f
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
beq $t0, $t1, menor_igual_hsxlughkmo
li $t0, 0
j no_menor_igual_hsxlughkmo
menor_igual_hsxlughkmo: li $t0, 1
no_menor_igual_hsxlughkmo:
move $a0, $t0
li $v0, 1
syscall
jal imprimir_salto_linea

# Print semantic.Operacion@50040f0c
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

# Print semantic.Operacion@2dda6444
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

# Print semantic.Operacion@5e9f23b4
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
