
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h


MOV DX, OFFSET BUFFER
MOV AH, 0AH
INT 21H
CALL PRINT
MOV AH,04CH
INT 021H
INT 020H
PRINT:
    XOR BX, BX
    MOV BL, BUFFER[1]
    MOV BUFFER[BX+2], '$'
    MOV DX, OFFSET BUFFER + 2
    MOV AH, 9
    INT 21H

ret

BUFFER DB 10,?, 10 DUP(' ')
