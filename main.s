
.text
.align 2
.global main

main:

	bl getScreenAddr
	ldr r1,=pixelAddr
	str r0,[r1]

	ldr r0,=y
	ldr r0,[r0]
	ldr r1,=matriz
	ldr r2,=matrizAlto
	ldr r2,[r2]
	ldr r3,=matrizAncho
	ldr r3,[r3]
	ldr r4,=x
	ldr r4,[r4]
	
	bl imprimirImagen
	
	mov r7,#1
	swi 0

.data
.align 2

.global pixelAddr
pixelAddr:
	.word 0

.global xtemp
xtemp:
	.word 0
.global ytemp
ytemp:
	.word 0

.global x
x: 
	.word 100

.global y
y:
	.word 100

