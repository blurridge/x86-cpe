; MACHACON  

org 100h

    lea DX, MSG_PROMPT
    mov AH, 09h
    int 21h
    call GET_USER_INPUT
    call PRINT_OUTPUT
       
ret

GET_USER_INPUT:
    lea DX, USER_INP
    mov AH, 0Ah
    int 21h   
    mov BH, 0
	mov BL, USER_INP[1]
	mov USER_INP[BX + 2],'$'	
	mov BH, USER_INP[1]
	ret

SET_CTR:
    mov BL, 8
    jmp INIT_LOOP

INIT_LOOP:
    mov CH, 0
    mov CL, USER_INP[1]
    mov SI, CX
    mov CH, USER_INP[SI + 1]
    mov SI, 0
    clc
    and CH, 1
    jz ROTATE
    stc

ROTATE:
    rcr USER_INP[SI + 2], 1   ; Rotates n amount of times where n is the length of the string.
    inc SI
    dec CL
    jnz ROTATE
    
    dec BL
    jnz INIT_LOOP
    jmp PRINT

PRINT_OUTPUT:  
    call NEW_LINE
    lea DX, OUTPUT_PROMPT
    mov AH, 09h
    int 21h  
    
    call NEW_LINE
    lea DX, USER_INP[2]
    mov AH, 09h
    int 21h
    
    jmp SET_CTR

PRINT:
    call SET_CURSOR_POS     ; Sets cursor back to starting position of row 2, col 0
	
    lea DX, USER_INP
    add DX, 2 
    mov AH, 09h
    int 21h
    
    dec BH
    jnz SET_CTR    
    jmp EXIT 

NEW_LINE:
    push AX
    mov DX, offset NL
    mov AH, 09h
    int 21h  
    pop AX
    ret

SET_CURSOR_POS:
    pusha
    mov DH, 2
	mov DL, 0
	mov BH, 0
	mov AH, 2
	int 10h
	popa
	ret

EXIT:
    ret


MSG_PROMPT db 'Input a string: ', '$'
OUTPUT_PROMPT db 'Output: ', '$' 
NL db 13, 10, '$' 
USER_INP db 50, ?, 50 dup(' ')