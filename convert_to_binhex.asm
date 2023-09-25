org 100h   
    
    MOV DI, 0                   ; Loads offset for display to 0
    MOV DX, 0                   ; Loads sum container - DX to  0
    LEA SI, MSG1                ; Loads memory address of MSG1 to source index
    CALL SHOW_MSG
     
    MOV BL, MSB
    MOV ES:[DI], BL
    SUB BL, 30h
    MOV AL, 10h
    MUL BL
    MOV DX, AX 
    ADD DI, 2
    
    MOV AL, 0
    MOV BL, LSB 
    MOV ES:[DI], BL
    SUB BL, 30h
    ADD DL, BL      
    
    ADD DI, 128
       
    LEA SI, MSG2
    CALL SHOW_MSG 
    ADD DI, 2
    CALL DEC_TO_BIN
     
    ADD DI, 136
    
    LEA SI, MSG3
    CALL SHOW_MSG 
    ADD DI, 2
    CALL DEC_TO_HEX
ret

MSG1 DB 'INPUT DECIMAL: ', 0        
MSG2 DB 'BINARY IS: ', 0   
MSG3 DB 'HEX IS: ', 0
MSB DB 30h
LSB DB 35h

SHOW_MSG:
    PUSH AX                     
    PUSH SI                    
    MOV AX, 0B800H              
    MOV ES, AX                   
    MOV AX, CS
    MOV DS, AX              
    SHOW:
        CMP [SI], 0             
        JZ EXIT                 
        MOVSB                   
        INC DI                  
    LOOP SHOW 
    EXIT:   
        POP SI                  
        POP AX     
    RET 
    
DEC_TO_BIN:
    PUSHA
    MOV CX, 9 
    ADD DI, 12
    GET_BIN:
        DEC CX 
        CMP CX, 0
        JZ EXIT_BIN
        MOV BX, 0
        SHR DL, 1
        JMP CURRENT_REM 
    LOOP GET_BIN
    CURRENT_REM: 
        ADC BX, 0  
        ADD BL, 30h
        MOV ES:[DI], BL  
        SUB DI, 2 
        JMP GET_BIN
    EXIT_BIN:
        POPA
        RET 

DEC_TO_HEX:
    PUSHA
    MOV AH, 0
    MOV AL, DL
    GET_HEX: 
        CMP AL, 0
        JZ EXIT_HEX
        MOV BL, 16h
        DIV BL
        CMP AH, 10h
        JNG NUM_HEX
        JMP LETTER_HEX
    LOOP GET_HEX
    NUM_HEX: 
        ADD AH, 30h
        MOV ES:[DI], AH 
        MOV AH, 0
        JMP GET_HEX
    LETTER_HEX:
        ADD BL, 55h
        MOV ES:[DI], BL 
        MOV AH, 0
        JMP GET_HEX
    EXIT_HEX:
        POPA
        RET                           