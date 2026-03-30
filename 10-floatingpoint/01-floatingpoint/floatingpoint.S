@
@ Examples of the floating point routines.
@

.thumb_func		    @ Necessary because sdk uses BLX
.global main	            @ Provide program starting address to linker

	.equ	N, 3	@ Number of points.

main:	BL	stdio_init_all	@ initialize uart or usb	

	ldr	r6, =points	@ pointer to current points
	
	mov	r7, #N		@ number of loop iterations

loop:	mov	r0, r6		@ move pointer to parameter 1 (r0)

	bl	distance	@ call distance function

@ need to take the single precision return value
@ and convert it to a double, because the C printf
@ function can only print doubles.
	bl __aeabi_f2d	
	mov		r2, r0
	mov		r3, r1
	ldr	r0, =prtstr	@ load print string
	bl	printf		@ print the distance

	add	r6, #(4*4) 	@ 4 points each 4 bytes
	sub	r7, #1		@ decrement loop counter
	cmp r7, #0		@ is the loop done?
	bne	loop		@ loop if more points

loop2:	
	B	loop2

.data
	       .align  4	@ necessary alignment
points:	.single	0.0, 0.0, 3.0, 4.0
	.single	1.3, 5.4, 3.1, -1.5
	.single 1.323e10, -1.2e-4, 34.55, 5454.234
prtstr:	.asciz "Distance = %f\n"


