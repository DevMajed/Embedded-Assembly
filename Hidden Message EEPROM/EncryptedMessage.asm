.nolist
.include "m328pbdef.inc"
.list

.def stringl = r21;
 ldi xl, 0x00
 ldi xh, 0x03 

 ldi yl, 0xE1
 ldi yh, 0x00

 ldi r22, 0xC3

 ldi stringl, 18 

readrom:
 sbic EECR, EEPE
 rjmp readrom

 out EEARL, YL
 OUT EEARH, YH
 SBI EECR, EERE
 IN R16, EEDR
 EOR R16, R22

 ST X+, R16
ADIW Y,1
dec stringl 
BRNE readrom

ldi r17, '0'
st x, r17

end:
rjmp end
