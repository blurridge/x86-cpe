
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

    LEA SI, MSG1
    CALL SHOW_MSG
    
    LEA SI, CRLF
    CALL SHOW_MSG
    
    LEA SI, MSG2
    CALL SHOW_MSG
ret

MSG1 DB 'INPUT 1ST VAL: 1', 0        
MSG2 DB 'INPUT 2ND VAL: 2', 0 
MSG3 DB 'SUM IS: ', 0      
CRLF DB 0DH,0AH,0
VAR1 DB ?
VAR2 DB ?
SUM DB ?  

SHOW_MSG:
    PUSHA
        CLD
        
        MOV AX, 0B800H
        MOV ES, AX                 
        MOV AX, CS
        MOV DS, AX
        MOV DI, 0
        SHOW:
            CMP [SI], 0
            JZ EXIT
            MOV AL, DS:[SI]
            MOV ES:[DI], AL
            INC SI
            INC DI
            INC DI
        LOOP SHOW
        EXIT:
        
    POPA
    RET                          