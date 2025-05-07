	.file	"main.cpp"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	_Z18initialize_s_tablev
	.type	_Z18initialize_s_tablev, @function
_Z18initialize_s_tablev:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r18,lo8(_ZL13s_table_bytes)
	ldi r19,hi8(_ZL13s_table_bytes)
	ldi r26,lo8(S)
	ldi r27,hi8(S)
.L2:
	movw r30,r18
/* #APP */
 ;  25 "main.cpp" 1
	lpm r24, Z
	
 ;  0 "" 2
/* #NOAPP */
	adiw r30,1
/* #APP */
 ;  25 "main.cpp" 1
	lpm r30, Z
	
 ;  0 "" 2
/* #NOAPP */
	ldi r25,0
	or r25,r30
	st X+,r24
	st X+,r25
	subi r18,-2
	sbci r19,-1
	ldi r31,hi8(S+36)
	cpi r26,lo8(S+36)
	cpc r27,r31
	brne .L2
/* epilogue start */
	ret
	.size	_Z18initialize_s_tablev, .-_Z18initialize_s_tablev
.global	_Z6rotl16jj
	.type	_Z6rotl16jj, @function
_Z6rotl16jj:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	andi r22,15
	clr r23
	movw r18,r24
	mov r0,r22
	rjmp 2f
	1:
	lsl r18
	rol r19
	2:
	dec r0
	brpl 1b
	neg r23
	neg r22
	sbc r23,__zero_reg__
	andi r22,15
	clr r23
	rjmp 2f
	1:
	lsr r25
	ror r24
	2:
	dec r22
	brpl 1b
	or r24,r18
	or r25,r19
	ret
	.size	_Z6rotl16jj, .-_Z6rotl16jj
.global	_Z6rotr16jj
	.type	_Z6rotr16jj, @function
_Z6rotr16jj:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	andi r22,15
	clr r23
	movw r18,r24
	mov r0,r22
	rjmp 2f
	1:
	lsr r19
	ror r18
	2:
	dec r0
	brpl 1b
	neg r23
	neg r22
	sbc r23,__zero_reg__
	andi r22,15
	clr r23
	rjmp 2f
	1:
	lsl r24
	rol r25
	2:
	dec r22
	brpl 1b
	or r24,r18
	or r25,r19
	ret
	.size	_Z6rotr16jj, .-_Z6rotr16jj
.global	_Z10USART_initv
	.type	_Z10USART_initv, @function
_Z10USART_initv:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts 197,__zero_reg__
	ldi r24,lo8(103)
	sts 196,r24
	ldi r24,lo8(8)
	sts 193,r24
	ldi r24,lo8(6)
	sts 194,r24
	ret
	.size	_Z10USART_initv, .-_Z10USART_initv
.global	_Z14USART_transmith
	.type	_Z14USART_transmith, @function
_Z14USART_transmith:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.L9:
	lds r25,192
	sbrs r25,5
	rjmp .L9
	sts 198,r24
	ret
	.size	_Z14USART_transmith, .-_Z14USART_transmith
.global	_Z17USART_send_stringPKc
	.type	_Z17USART_send_stringPKc, @function
_Z17USART_send_stringPKc:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
.L14:
	ld r24,Y+
	tst r24
	breq .L12
	call _Z14USART_transmith
	rjmp .L14
.L12:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	_Z17USART_send_stringPKc, .-_Z17USART_send_stringPKc
.global	_Z9print_hexj
	.type	_Z9print_hexj, @function
_Z9print_hexj:
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,7
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 7 */
/* stack size = 9 */
.L__stack_usage = 9
	ldi r18,lo8(48)
	std Y+1,r18
	ldi r18,lo8(120)
	std Y+2,r18
	std Y+7,__zero_reg__
	movw r30,r28
	adiw r30,1
	movw r22,r28
	subi r22,3
	sbc r23,__zero_reg__
	mov r20,r30
	mov r19,r31
.L18:
	mov r18,r24
	andi r18,lo8(15)
	cpi r18,lo8(10)
	brsh .L16
	subi r18,lo8(-(48))
	rjmp .L20
.L16:
	subi r18,lo8(-(55))
.L20:
	std Z+5,r18
	ldi r18,4
	1:
	lsr r25
	ror r24
	dec r18
	brne 1b
	sbiw r30,1
	cp r30,r22
	cpc r31,r23
	brne .L18
	mov r24,r20
	mov r25,r19
	call _Z17USART_send_stringPKc
/* epilogue start */
	adiw r28,7
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
	.size	_Z9print_hexj, .-_Z9print_hexj
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Plaintext: A0="
.LC1:
	.string	", B0="
.LC2:
	.string	"  Ciphertext: A="
.LC3:
	.string	", B="
.LC4:
	.string	"\n"
.LC5:
	.string	" Decrypted: A="
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call _Z10USART_initv
	call _Z18initialize_s_tablev
	lds r22,S
	lds r23,S+1
	movw r14,r22
	ldi r18,-52
	sub r14,r18
	ldi r18,-19
	sbc r15,r18
	lds r26,S+2
	lds r27,S+2+1
	movw r16,r26
	subi r16,-120
	sbci r17,-87
	ldi r30,lo8(S+32)
	ldi r31,hi8(S+32)
	ldi r28,lo8(S)
	ldi r29,hi8(S)
.L22:
	eor r14,r16
	eor r15,r17
	movw r24,r16
	andi r24,15
	clr r25
	movw r18,r14
	mov r0,r24
	rjmp 2f
	1:
	lsl r18
	rol r19
	2:
	dec r0
	brpl 1b
	neg r25
	neg r24
	sbc r25,__zero_reg__
	andi r24,15
	clr r25
	rjmp 2f
	1:
	lsr r15
	ror r14
	2:
	dec r24
	brpl 1b
	or r14,r18
	or r15,r19
	ldd r24,Y+4
	ldd r25,Y+5
	add r14,r24
	adc r15,r25
	eor r16,r14
	eor r17,r15
	movw r24,r14
	andi r24,15
	clr r25
	movw r18,r16
	mov r0,r24
	rjmp 2f
	1:
	lsl r18
	rol r19
	2:
	dec r0
	brpl 1b
	neg r25
	neg r24
	sbc r25,__zero_reg__
	andi r24,15
	clr r25
	rjmp 2f
	1:
	lsr r17
	ror r16
	2:
	dec r24
	brpl 1b
	or r16,r18
	or r17,r19
	ldd r24,Y+6
	ldd r25,Y+7
	add r16,r24
	adc r17,r25
	adiw r28,4
	ldi r20,hi8(S+32)
	cpi r28,lo8(S+32)
	cpc r29,r20
	brne .L22
	movw r18,r16
	movw r24,r14
.L23:
	ldd r20,Z+2
	ldd r21,Z+3
	sub r18,r20
	sbc r19,r21
	movw r20,r24
	andi r20,15
	clr r21
	movw r28,r18
	mov r0,r20
	rjmp 2f
	1:
	lsr r29
	ror r28
	2:
	dec r0
	brpl 1b
	neg r21
	neg r20
	sbc r21,__zero_reg__
	andi r20,15
	clr r21
	rjmp 2f
	1:
	lsl r18
	rol r19
	2:
	dec r20
	brpl 1b
	or r18,r28
	or r19,r29
	eor r18,r24
	eor r19,r25
	ld r20,Z
	ldd r21,Z+1
	sub r24,r20
	sbc r25,r21
	movw r20,r18
	andi r20,15
	clr r21
	movw r28,r24
	mov r0,r20
	rjmp 2f
	1:
	lsr r29
	ror r28
	2:
	dec r0
	brpl 1b
	neg r21
	neg r20
	sbc r21,__zero_reg__
	andi r20,15
	clr r21
	rjmp 2f
	1:
	lsl r24
	rol r25
	2:
	dec r20
	brpl 1b
	or r24,r28
	or r25,r29
	eor r24,r18
	eor r25,r19
	sbiw r30,4
	ldi r20,hi8(S)
	cpi r30,lo8(S)
	cpc r31,r20
	brne .L23
	movw r12,r18
	sub r12,r26
	sbc r13,r27
	movw r28,r24
	sub r28,r22
	sbc r29,r23
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	call _Z17USART_send_stringPKc
	ldi r24,lo8(52)
	ldi r25,lo8(18)
	call _Z9print_hexj
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	call _Z17USART_send_stringPKc
	ldi r24,lo8(120)
	ldi r25,lo8(86)
	call _Z9print_hexj
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	call _Z17USART_send_stringPKc
	movw r24,r14
	call _Z9print_hexj
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	call _Z17USART_send_stringPKc
	movw r24,r16
	call _Z9print_hexj
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	call _Z17USART_send_stringPKc
	ldi r24,lo8(.LC5)
	ldi r25,hi8(.LC5)
	call _Z17USART_send_stringPKc
	movw r24,r28
	call _Z9print_hexj
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	call _Z17USART_send_stringPKc
	movw r24,r12
	call _Z9print_hexj
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	call _Z17USART_send_stringPKc
.L24:
	ldi r24,lo8(3199999)
	ldi r25,hi8(3199999)
	ldi r18,hlo8(3199999)
1:	subi r24,1
	sbci r25,0
	sbci r18,0
	brne 1b
	rjmp .
	nop
	rjmp .L24
	.size	main, .-main
.global	S
	.section .bss
	.type	S, @object
	.size	S, 36
S:
	.zero	36
	.section	.progmem.data,"a",@progbits
	.type	_ZL13s_table_bytes, @object
	.size	_ZL13s_table_bytes, 36
_ZL13s_table_bytes:
	.byte	-31
	.byte	-73
	.byte	24
	.byte	86
	.byte	79
	.byte	-12
	.byte	-122
	.byte	-110
	.byte	-67
	.byte	48
	.byte	-12
	.byte	-50
	.byte	43
	.byte	109
	.byte	98
	.byte	11
	.byte	-103
	.byte	-87
	.byte	-48
	.byte	71
	.byte	7
	.byte	-26
	.byte	62
	.byte	-124
	.byte	117
	.byte	34
	.byte	-84
	.byte	-64
	.byte	-29
	.byte	94
	.byte	26
	.byte	-3
	.byte	81
	.byte	-101
	.byte	-120
	.byte	57
	.ident	"GCC: (GNU) 5.4.0"
.global __do_copy_data
.global __do_clear_bss
