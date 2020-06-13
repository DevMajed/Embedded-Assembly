
.nolist
.include "m328pbdef.inc" 
.list

start:      ;setup a common node
ldi r16,1<<3   ; theird bit is high, ;
out ddrc, r16.  ; equavlent to DDRC = 0b00001000. Writing 0 to a bit in DDRx makes corresponding port pin as input, writing 1 makes it port output 
out portc, r16 ;  when port is configured as output, the comand portc will output data,when configures as input it works as pull up resestors
ldi r16, (1<<3 | 1<<1).    ;steup blue and green on ddrb
out ddrb, r16
ldi r16, 1<<6
out ddrd, r16

loop: ;spin forever

;blue, look at schematic if confused
ldi r16, (1<<6)
ldi r17, (1<<1|0<<3)
out portd, r16
out portb, r17
call delay500ms
;Cyan

ldi r18, (0<<1 | 0<<3)
ldi r19, (1<<6)
out portb, r18
out portd, r19

call delay500ms

;Green

ldi r16, (0<<1 | 1<<3)
ldi r17, (1<<6)
out portb, r16
out portd, r17

; Calling delay, otherways we won't be able to see the patren as the LED blink too fast
call delay500ms

ldi r16, (0<<1 | 1<<3)
ldi r17, (0<<6)
out portb, r16
out portd, r17
call delay500ms
;Red

ldi r16, (1<<1 | 1<<3)
ldi r17, (0<<6)
out portb, r16
out portd, r17

call delay500ms

ldi r16, (1<<1 | 0<<3)
ldi r17, (0<<6)
out portb, r16
out portd, r17

call delay500ms

ldi r16, (1<<6)
ldi r17, (1<<1|0<<3)
out portd, r16
out portb, r17

 JMP loop ; jump to the top and keep spining 

; delay routine
delay500ms:
ldi r25,40
delay500msA:
ldi r26,0
delay500msB:
ldi r27,0
delay500msC:
	dec r27
	brne delay500msC
	dec r26
	brne delay500msB
	dec r25
	brne delay500msA
	ret
