
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

    ORG 100H
    MOV DX, 0145H
    MOV AX, DX
    INC AX
    DEC DX

ret




