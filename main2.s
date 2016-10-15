
.text
.align 2
.global main
main:

	bl getScreenAddr
	ldr r1,=pixelAddr
	str r0,[r1]

	bl GetGpioAddress

	@@ PUERTOS DE LECTURA @@

	mov r0,#17
	mov r1, #0
	bl SetGpioFunction
	
	
	mov r0,#18
	mov r1, #0
	bl SetGpioFunction

	
	mov r0,#27
	mov r1, #0
	bl SetGpioFunction

	
	mov r0,#22
	mov r1, #0
	bl SetGpioFunction

	
	mov r0,#23
	mov r1, #0
	bl SetGpioFunction

loop:

	@@ Terminar el juego

	ldr r0,=terminarJuego 		@@ terminarJuego
	ldr r0,[r0]
	cmp r0,#1
	beq findelJuego			

	bl fondo
	
loop2:

	mov r0,#0
	bl dibujarPersonaje
	
	bl wait
	
	mov r0, #17
	bl getGpio
	mov r4, r0
	cmp r4, #0
	bne presionadoStart
	beq sinPresionarStart
	
sinPresionarStart:
	@@mover derecha
	mov r0, #18
	bl getGpio
	mov r4, r0
	cmp r4, #0
	bne presionaDerecha
	beq noPresionaDerecha
	
noPresionaDerecha:
	@@mover abajo
	mov r0, #27
	bl getGpio
	mov r4, r0
	cmp r4, #0
	bne presionaAbajo
	beq noPresionaAbajo
	
noPresionaAbajo:
	@@mover arriba
	mov r0, #22
	bl getGpio
	mov r4, r0
	cmp r4, #0
	bne presionaArriba
	@@beq noPresionaArriba
	
presionaArriba:
	
	mov r0,#1
	mov r1,#1
	mov r3,#1
	bl dibujarPersonaje
	b loop
	
presionaAbajo:
	
	mov r0,#1
	mov r1,#1
	mov r3,#0
	bl dibujarPersonaje
	
	b loop
	
presionaDerecha:
	mov r0,#1
	mov r1,#0
	mov r2,#1
	bl dibujarPersonaje
	
	b loop
presionadoStart:

	mov r0,#1
	mov r1,#0
	mov r2,#0
	bl dibujarPersonaje

	b loop
	
findelJuego:

	mov r7,#1
	swi 0







terminarJuego1:

	push {lr}
	

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
	bl imprimirImagen
	pop {pc}


wait:
	push {lr}
	mov r0, #0x6000000 @ big number
	sleepLoop:
	subs r0,#1
	bne sleepLoop @ loop delay
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

	bl imprimirImagen

	b fin2
	
movDer:
	ldr r6, =xCar
	ldr r6,[r6] 

	add r6, r6, #20

	mov r4, r6
	ldr r7,=xCar
	str r6,[r7]

	@@ Restriccion de Pantalla en X@@

	ldr r1,=finScreenX
	ldr r1,[r1]

	cmp r5,r1
	bgt fin2

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



	bl imprimirImagen

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

	bl imprimirImagen

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

	bl imprimirImagen

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

	bl imprimirImagen
	b fin2

fin2:
	pop {pc}




.data
.align 2

terminarJuego:
	.word 0
murio:
	.word 0

xCar: 
	.word 20
yCar: 
	.word 10
finScreenY: 
	.word 370
finScreenX:
	.word 370


.global pixelAddr
.global posX
.global posY
.global tempSizeY
.global tempSizeX
.global posCharacterY
.global posArrowX
.global posArrowY
.global myloc
.global posXbarra
.global posYbarra






myloc: 
	.word 0
pixelAddr: .word 0
masmenosX: .word 20
masmenosY: .word 20
posX: .word 0
posY: .word 200

posXlink: .word 20
posYlink: .word 10


tempSizeX: .word 0
tempSizeY: .word 0
posCharacterY: .word 200
usuario: .asciz " "
posArrowY: .word 0
posArrowX: .word 0
topePantalla: .word 370
prueba: .asciz "prueba \n"
prueba2: .asciz "prueba wait \n"
disparoFlechaBoolean: .word 0
posYbarra: .word 100
posXbarra: .word 200
topePantallaX: .word 550
topebarra: .word 360
caminataGanodorfBoolean: .word 0
booleanEndGame: .word 0
.end

