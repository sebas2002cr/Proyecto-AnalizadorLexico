.data

.text
main:
# Registro de activacion
move $fp, $sp
# LineaExpresion: Literal -> 123
li $t0, 123
# Print
li $t0, 1092
li $v0, 1
move $a0, $t0
syscall
jr $ra

function_prueba:
# Registro de activacion
move $fp, $sp
jr $ra

