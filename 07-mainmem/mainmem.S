@
@ Assembler program to flash three LEDs connected to the
@ Raspberry Pi GPIO writing to the registers directly.
@
@

#include "hardware/regs/addressmap.h"
#include "hardware/regs/sio.h"
#include "hardware/regs/io_bank0.h"
#include "hardware/regs/pads_bank0.h"

	.EQU LED_PIN1, 18
	.EQU LED_PIN2, 19
	.EQU LED_PIN3, 20

	.EQU FUNCSEL_VALUE_SIO, 5
	
	.EQU sleep_time,	200

.thumb_func
.global main	        @ Provide program starting address

	.align  4	@ necessary alignment
main:
	
@ Init each of the three pins and set them to output
	MOV	R0, #LED_PIN1		
	BL	gpioinit
	MOV	R0, #LED_PIN2
	BL	gpioinit
	MOV	R0, #LED_PIN3
	BL	gpioinit

loop:
@ Turn each pin on, sleep and then turn the pin off
	MOV	R0, #LED_PIN1	
	BL	gpio_on
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN1	
	BL	gpio_off
	MOV	R0, #LED_PIN2
	BL	gpio_on
    LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN2
	BL	gpio_off
	MOV	R0, #LED_PIN3
	BL	gpio_on
    LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN3
	BL	gpio_off
       
    B   loop	@ loop forever

@ Initialize the GPIO to SIO. r0 = pin to init.
gpioinit:

@ Initialize the GPIO	
	MOV	R3, #1
	LSL	R3, R0	@ shift over to pin position
	LDR	R2, gpiobase	@ address we want	
	STR	R3, [R2, #SIO_GPIO_OE_SET_OFFSET]
	STR	R3, [R2, #SIO_GPIO_OUT_CLR_OFFSET]

@ Enable input and output for the pin
	LDR	R2, padsbank0	
	LSL	R3, R0, #2	@ pin * 4 for register address
	ADD	R2, R3		@ Actual set of registers for pin
	MOV	R1, #PADS_BANK0_GPIO0_IE_BITS
	LDR	R4, setoffset
	ORR	R2, R4
	STR	R1, [R2, #PADS_BANK0_GPIO0_OFFSET]

@ Set the function number to SIO.
	MOV R4, R0
	LSL	R4, #3		@ each GPIO has 8 bytes of registers
	LDR	R2, iobank0	@ address we want
	ADD	R2, R4		@ add the offset for the pin number
	MOV	R1, #FUNCSEL_VALUE_SIO
	STR	R1, [R2, #IO_BANK0_GPIO0_CTRL_OFFSET]
#if HAS_PADS_BANK0_ISOLATION
@ Remove pad isolation now that the correct peripheral is set
	LDR	R2, padsbank0
	LSL	R3, R0, #2	@ pin * 4 for register address
	ADD	R2, R3		@ Actual set of registers for pin  
	LDR	R4, clearoffset
	ADD	R2, R4	 
	LDR R1, PBGIB
    STR	R1, [R2, #PADS_BANK0_GPIO0_OFFSET]
#endif	
	BX	LR

@ Turn on a GPIO pin.
gpio_on:
	MOV	R3, #1
	LSL	R3, R0	@ shift over to pin position
	LDR	R2, gpiobase	@ address we want
	STR	R3, [R2, #SIO_GPIO_OUT_SET_OFFSET]
	BX	LR

@ Turn off a GPIO pin.
gpio_off:
	MOV	R3, #1
	LSL	R3, R0	@ shift over to pin position
	LDR	R2, gpiobase	@ address we want
	STR	R3, [R2, #SIO_GPIO_OUT_CLR_OFFSET]
	BX	LR

	      	.align  4	@ necessary alignment
gpiobase:	.word	SIO_BASE     @ base of the GPIO registers
iobank0:	.word	IO_BANK0_BASE @ base of io config registers
padsbank0:	.word	PADS_BANK0_BASE
setoffset:	.word	REG_ALIAS_SET_BITS
clearoffset:.word	REG_ALIAS_CLR_BITS
padenaboff: .word PADS_BANK0_GPIO0_OFFSET
PBGIB:      .word   PADS_BANK0_GPIO0_ISO_BITS

