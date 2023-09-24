
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h


START:
    LEA SI, STRING
    CALL REVERSE
    ; LOAD ADDRESS OF THE STRING
    LEA DX,STRING
    MOV AH, 09H
    INT 21H
    MOV AH, 4CH
    INT 21H
    INT 20H
REVERSE:
    MOV CX, 0H
LOOP1:
    MOV AX, [SI]
    CMP AL, '$'
    JE LABEL1
    PUSH [SI]
    INC SI
    INC CX
    JMP LOOP1
LABEL1:
    MOV SI, OFFSET STRING
LOOP2:
    CMP CX,0
    JE EXIT
    POP DX
    XOR DH, DH
    MOV [SI], DX
    INC SI
    DEC CX
JMP LOOP2
EXIT:
    MOV [SI],'$ '
    RET

STRING DB 'THIS IS A SAMPLE STRING', '$'