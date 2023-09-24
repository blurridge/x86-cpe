
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

    START:
        MOV AX,00H
        MOV CL,05H
        LEA SI,ARR
    BACK:
        ADD AL, [SI]
        INC SI
        DEC CL
        JNZ BACK
        MOV BL,05H
        DIV BL

ret

ARR DB 01H,02H,03H,04H,05H