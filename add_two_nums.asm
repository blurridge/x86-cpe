org 100h
    
    MOV DI, 0                   ; Loads offset for display to 0
    MOV DX, 0                   ; Loads sum container - DX to  0
    LEA SI, MSG1                ; Loads memory address of MSG1 to source index
    CALL SHOW_MSG
    CALL ADD_NUM
    ADD DI, 80H                 ; DI is moved by an offset of 80 to go to next line
      
    LEA SI, MSG2
    CALL SHOW_MSG 
    CALL ADD_NUM 
    ADD DI, 80H
       
    LEA SI, MSG3
    CALL SHOW_MSG 
    
    ADD DL, 30h                 ; DL is added by 30h to get the ASCII value of the sum so that it could be printed
    MOV ES:[DI], DL             ; Prints on current offset
ret

MSG1 DB 'INPUT 1ST VAL: 2', 0        
MSG2 DB 'INPUT 2ND VAL: 7', 0 
MSG3 DB 'SUM IS: ', 0

SHOW_MSG:
    PUSH AX                     ; Stores AX to the stack 
    PUSH SI                     ; Stores SI to the stack
    MOV AX, 0B800H              ; Stores to AX the address of video display
    MOV ES, AX                  ; Stores to ES the address of video display                
    MOV AX, CS  
    MOV DS, AX                  ; Stores CS to DS
        SHOW:
            CMP [SI], 0         ; Compares current character to 0
            JZ EXIT             ; If 0, exit 
            MOV BL, CS:[SI]     ; Store current ASCII to BL for summing 
            MOVSB               ; Copy byte at DS:[SI] to ES:[DI]. Increment SI and DI.
            INC DI              ; DI is incremented one more time since each character is 2 bytes
        LOOP SHOW 
    EXIT:   
        POP SI                  ; Restores values of SI and AX
        POP AX      
    RET

ADD_NUM:
    SUB BL, 30h                 ; Gets actual integer value from BL by subtracting 30 hex
    ADD DL, BL                  ; DL stores sum
    RET                             