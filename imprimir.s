/*******************************************
* Universidad del Valle de Guatemala		*
* Taller de Assembler						*
* Seccion 11								*
* Laboratorio 3								*
* Jose Gerardo Molina 14492					*
* Diego Felix					*
*
*										*
********************************************/

@@ r0 - posicionY
@@ r1 - matriz
@@ r2 - ancho
@@ r3 - alto
@@ r4 - posicionX 

.global imprimirImg

imprimirImg:

	
	push {lr}
	
	ancho .req r10
	alto  .req r11	
	fondo .req r7
	
	
	@@ Posicion temporal de x
	ldr r8,=xtemp		@@ variable global en main
	str r2,[r8]

	mov r6,r4

	ldr r8,=ytemp		@@ variable global en main
	str r3,[r8]
	
	ldr r8,=y		@@ variable global en main
	str r0,[r8]

	ldr r8,=x		@@ variable global en main
	str r4,[r6]

	push {r1}
	mov r9,r2
	pop {r4}
	
	mov r7,r4
	ldr r7,[r7]
	push {r4}

row:

	@@ Comprobamos si ya termino la fila
	
	ldr ancho,=xtemp
	ldr ancho,[ancho]
	
	sub ancho,#1

	teq ancho,#0
	blt bajo

	ldr r0,=xtemp
	str ancho,[r0]

	ldr r0,=pixelAddr 	@@ Variable global en el main
	ldr r0,[r0]

	ldr r1,=x
	ldr r1,[r1]

	ldr r2,=y
	ldr r2,[r2]

	pop {r4}
	
	ldrb r3,[r4],#4
	push {r4}

	cmp r3,r7
	beq sinFondo
	bl pixel


sinFondo:

	ldr r0,=x
	ldr r0,[r0]

	add r0,#1

	ldr r1,=x
	str r0,[r1]

	b row

bajo:

	ldr alto,=ytemp
	ldr alto,[alto]

	sub alto,#1

	cmp alto,#0
	beq fin

	ldr r0,=ytemp
	str alto,[r0]


	ldr r0,=x
	mov r1,r6
	str r1,[r0]
	
	ldr r0,=xtemp
	str r9,[r0]

	ldr r0,=y
	ldr r0,[r0]
	
	add r0,#1

	ldr r1,=y
	str r0,[r1]

	b row

fin:
	pop {r9}
	pop {pc}

	


	





	