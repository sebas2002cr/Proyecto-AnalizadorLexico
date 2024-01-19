.data
salto_linea: .asciiz "\n"
string_vlorxdgibd: .asciiz "imprimir string"
string_jsyrmxbare: .asciiz "hola"

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
la $t0, string_vlorxdgibd
move $a0, $t0
li $v0, 4
syscall
jal imprimir_salto_linea

# Declaración y asignación de variable: var, Tipo: STRING
la $t0, string_jsyrmxbare
lw $t0, 0($sp)
sw $t0, 0($sp)
addu $sp, $sp, 4

# Declaració