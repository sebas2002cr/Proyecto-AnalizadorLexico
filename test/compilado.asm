.data
salto_linea: .asciiz "\n"
resultado_read: .space 100
string_erbuucliah: .asciiz "\n"

.text
main:
move $fp, $sp

# Print 1.23
li.s $f0, 1.23
mov.s $f12, $f0
li $v0, 2
syscall
# jal imprimir_salto_linea

# Print "\n"
la $t0, string_erbuucliah
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Print semantic.Operacion@1d81eb93
li.s $f0, 1.123
subu $sp, $sp, 4
swc1 $f0, 0($sp)
li.s $f0, 3.45
# SUMA
l.s $f1, 0($sp)
addiu $sp, $sp, 4
add.s $f0, $f1, $f0
mov.s $f12, $f0
li $v0, 2
syscall
# jal imprimir_salto_linea

# Declaración y asignación de variable: flotante, Tipo: FLOAT
li.s $f0, 3.21
subu $sp, $sp, 4
s.s $f0, 0($sp)

# LineaExpresion: Operacion -> semantic.Operacion@7291c18f
l.s $f0, -4($fp)
# DECREMENTO
li.s $f1, 1.0
sub.s $f0, $f0, $f1
swc1 $f0, -4($fp)

# Print "\n"
la $t0, string_erbuucliah
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Print flotante
l.s $f0, -4($fp)
mov.s $f12, $f0
li $v0, 2
syscall
# jal imprimir_salto_linea

# Print "\n"
la $t0, string_erbuucliah
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Print semantic.Operacion@27973e9b
l.s $f0, -4($fp)
# NEGATIVO
neg.s $f0, $f0
mov.s $f12, $f0
li $v0, 2
syscall
# jal imprimir_salto_linea

# Print "\n"
la $t0, string_erbuucliah
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Print semantic.Operacion@312b1dae
l.s $f0, -4($fp)
subu $sp, $sp, 4
swc1 $f0, 0($sp)
li.s $f0, 3.22
# MAYOR_IGUAL
l.s $f1, 0($sp)
addiu $sp, $sp, 4
c.lt.s $f1, $f0
bc1t mayor_igual_kwzohuxoyx
li $t0, 1
mayor_igual_kwzohuxoyx: li $t0, 0
move $a0, $t0
li $v0, 1
syscall
# jal imprimir_salto_linea

# Print semantic.Operacion@9807454
l.s $f0, -4($fp)
subu $sp, $sp, 4
swc1 $f0, 0($sp)
li.s $f0, 3.22
# MENOR_IGUAL
l.s $f1, 0($sp)
addiu $sp, $sp, 4
c.lt.s $f0, $f1
bc1t menor_igual_tmwsfctjly
li $t0, 1
menor_igual_tmwsfctjly: li $t0, 0
move $a0, $t0
li $v0, 1
syscall
# jal imprimir_salto_linea

# Print semantic.Operacion@3d494fbf
li.s $f0, 2.3
subu $sp, $sp, 4
swc1 $f0, 0($sp)
li.s $f0, 2.3
# IGUAL
l.s $f1, 0($sp)
addiu $sp, $sp, 4
c.eq.s $f1, $f0
bc1t igual_jrvkqasqzh
li $t0, 0
igual_jrvkqasqzh: li $t0, 1
move $a0, $t0
li $v0, 1
syscall
# jal imprimir_salto_linea

# Print semantic.Operacion@1ddc4ec2
li.s $f0, 2.3
subu $sp, $sp, 4
swc1 $f0, 0($sp)
li.s $f0, 2.3
# DISTINTO
l.s $f1, 0($sp)
addiu $sp, $sp, 4
c.eq.s $f1, $f0
bc1f distinto_sxcpmvbver
li $t0, 0
distinto_sxcpmvbver: li $t0, 1
move $a0, $t0
li $v0, 1
syscall
# jal imprimir_salto_linea

# Print "\n"
la $t0, string_erbuucliah
move $a0, $t0
li $v0, 4
syscall
# jal imprimir_salto_linea

# Print semantic.Operacion@133314b
subu $sp, $sp, 4 # Aparta campo en la pila para el $fp
sw $fp, 0($sp) # Guarda el $fp
move $fp, $sp # Nuevo registro de activación para la función actual
jal function_pi
addu $sp, $sp, 0 # Libera los parámetros de la pila
lw $fp, 0($sp) # Restaura el $fp anterior
addu $sp, $sp, 4 # Libera el fp de la pila
subu $sp, $sp, 4
swc1 $f0, 0($sp)
li.s $f0, 1.1
# SUMA
l.s $f1, 0($sp)
addiu $sp, $sp, 4
add.s $f0, $f1, $f0
mov.s $f12, $f0
li $v0, 2
syscall
# jal imprimir_salto_linea

# Terminar el programa
li $v0, 10
syscall

function_pi:

li.s $f0, 3.14
# Return
addu $sp, $sp, 0 # Libera las variables de la pila
jr $ra

# Salir funcion pi
addu $sp, $sp, 0 # Libera las variables de la pila
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
