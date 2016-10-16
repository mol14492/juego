.text
.align 2
.global main
main:


	bl getScreenAddr

	ldr r1,=pixelAddr
	str r0,[r1]


	bl GetGpioAddress

	@@ PUERTOS DE LECTURA @@
	
	@@ Arriba
	mov r0,#17
	mov r1, #0
	bl SetGpioFunction
	
	@@ Abajo
	mov r0,#18
	mov r1, #0
	bl SetGpioFunction

	@@ Izquierda
	mov r0,#27
	mov r1, #0
	bl SetGpioFunction

	@@ Derecha
	mov r0,#22
	mov r1, #0
	bl SetGpioFunction

	@@ PUERTOS DE ESCRITURA @@

	mov r0,#23
	mov r1, #1
	bl SetGpioFunction

inicio:
	@@ Apagar el led
	mov r0,#23
	mov r1,#0
	bl SetGpio

	ldr r0,=terminar
	ldr r0,[r0]
	cmp r0,#1
	beq fin
	
	bl fondo

	mov r0,#0

	bl dibujarPersonaje 
	
	bl delay
	bl delay


	mov r0, #18
	bl GetGpio
	mov r4, r0
	cmp r4, #0
	bne botDer
	beq noBotDer
	
noBotDer:
	
	mov r0, #27
	bl GetGpio
	mov r4, r0
	cmp r4, #0
	bne botAbajo
	beq noBotAbajo
	
noBotAbajo:

	mov r0, #22
	bl GetGpio
	mov r4, r0
	cmp r4, #0
	bne botArri
	beq noBotArri
	
noBotArri:
	
	mov r0, #23
	bl GetGpio
	mov r4, r0
	cmp r4, #0
	beq noBotIzq
	
noBotIzq:
	
	b inicio
	
botArri:
	
	mov r0,#1
	mov r1,#1
	mov r3,#1
	bl dibujarPersonaje 
	b inicio
	
botAbajo:
	
	mov r0,#1
	mov r1,#1
	mov r3,#0
	bl dibujarPersonaje
	b inicio
	
botDer:
	mov r0,#1
	mov r1,#0
	mov r2,#1
	bl dibujarPersonaje
	
	b inicio


fin:

	@@ Encender el led
	mov r0,#23
	mov r1,#1
	bl SetGpio

	mov r7,#1
	swi 0


GetGpio:
	push {lr}
	mov r9, r0
	ldr r6, =myloc
 	ldr r0, [r6] @ obtener direccion 
	ldr r5,[r0,#0x34]
	mov r7,#1
	lsl r7,r9
	and r5,r7 

	teq r5, #0
	movne r5, #1
	mov r0, r5
	pop {pc}


delay:
	push {lr}

	mov r0, #0x9000000 
	sleepinicio:
	subs r0,#1
	bne sleepinicio 

	pop {pc}


fondo:
	push {lr}

	mov r0,#0
	ldr r1,=final
	ldr r2,=finalWidth
	ldr r2,[r2]
	ldr r3,=finalHeight
	ldr r3,[r3]
	mov r4, #0
	bl dibujar

	pop {pc}


dibujarPersonaje:
	push {lr}

	cmp r0, #0
	beq noMov
	bne siMov
	
siMov:
	cmp r1,#0
	beq movX
	bne movY
	
movX:
	cmp r2,#0
	beq movIzq
	bne movDer
	
movIzq:
	ldr r5,=yCar
	ldr r5,[r5] 

	mov r0, r5

	ldr r7,=yCar
	str r5,[r7]

	ldr r1,=goku
	ldr r2,=gokuWidth
	ldr r2,[r2]
	ldr r3,=gokuHeight
	ldr r3,[r3]

	ldr r6, =xCar
	ldr r6,[r6] 

	sub r6, r6, #20
	mov r4, r6
	ldr r7,=xCar
	str r6,[r7]

	bl dibujar

	b fin2
	
movDer:
	ldr r5,=yCar
	ldr r5,[r5] 

	mov r0, r5

	ldr r7,=yCar
	str r5,[r7]

	ldr r6, =xCar
	ldr r6,[r6] 

	add r6, r6, #20

	@@ Restriccion de Pantalla en X@@

	ldr r1,=finScreenX
	ldr r1,[r1]

	cmp r6,r1
	bgt fin2

	ldr r1,=goku
	ldr r2,=gokuWidth
	ldr r2,[r2]
	ldr r3,=gokuHeight
	ldr r3,[r3]

	mov r4, r6
	ldr r7,=xCar
	str r6,[r7]


	bl dibujar

	b fin2
	
movY:
	cmp r3, #0
	beq movAbajo
	bne movArriba
	
movAbajo:
	ldr r5,=yCar
	ldr r5,[r5] 

	add r5, r5, #20

	@@ Restriccion de Pantalla en Y@@

	ldr r1,=finScreenY
	ldr r1,[r1]

	cmp r5,r1
	bgt fin2

	mov r0, r5
	ldr r7,=yCar
	str r5,[r7]

	ldr r1,=goku
	ldr r2,=gokuWidth
	ldr r2,[r2]
	ldr r3,=gokuHeight
	ldr r3,[r3]

	ldr r6, =xCar
	ldr r6,[r6] 
	mov r4, r6

	bl dibujar

	b fin2
	
movArriba:
	ldr r5,=yCar
	ldr r5,[r5] 

	sub r5, r5, #20

	cmp r5,#1
	blt fin2

	mov r0, r5
	ldr r7,=yCar
	str r5,[r7]

	ldr r1,=goku
	ldr r2,=gokuWidth
	ldr r2,[r2]
	ldr r3,=gokuHeight
	ldr r3,[r3]

	ldr r6, =xCar
	ldr r6,[r6] 
	mov r4, r6

	bl dibujar

	b fin2
	
noMov:
	ldr r5,=yCar
	ldr r5,[r5] 
	mov r0, r5

	ldr r1,=goku
	ldr r2,=gokuWidth
	ldr r2,[r2]
	ldr r3,=gokuHeight
	ldr r3,[r3]

	ldr r6,=xCar
	ldr r6,[r6] 
	mov r4,r6

	bl dibujar
	b fin2

fin2:
	pop {pc}


.data
.align 2

.global myloc
myloc: 
	.word 0

.global pixelAddr
pixelAddr: 
	.word 0
.global x
x: 
	.word 0
.global y
y: 
	.word 200

xCar: 
	.word 20
yCar: 
	.word 10
finScreenY: 
	.word 370
finScreenX:
	.word 550

.global xTemp
xTemp: 
	.word 0
.global yTemp
yTemp: 
	.word 0

terminar:
	.word 0
.end
