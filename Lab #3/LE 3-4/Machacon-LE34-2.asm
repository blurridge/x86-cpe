; MACHACON

org 100h

    mov DX, offset INPUT_PROMPT
    mov AH, 9
    int 21h 
     
    lea BX, USER_INPUT
    call ASK_PER_CHAR 
    call PRINT_LOOP 
    int 20h

CLEAR_SCREEN: 
    mov AL, 00h
    mov AH, 06h
    mov BH, 0000_0110b
    xor CX, CX
    mov DH, 24
    mov DL, 79
    int 10h 
    
    mov BH, 0
    mov DH, 0
    mov DL, 39
    mov AH, 2
    int 10h
    ret  

ASK_PER_CHAR:
    mov AH, 00H
    int 16H 
    mov [BX], AL   
    cmp AL, '$'
    je EXIT 
    mov AH, 02H
    mov DL, AL
    int 21H
    inc BX
    jmp ASK_PER_CHAR

PRINT_LOOP:
    call CLEAR_SCREEN
    mov BX, 24
    PRINT_TEXT:
        cmp BX, 0
        je EXIT
        push DX
        mov DX, offset USER_INPUT
        mov AH, 9
        int 21h
        pop DX
        dec BX
        inc DH
        mov AH, 2
        int 10h
        jmp PRINT_TEXT 

EXIT:
    ret

INPUT_PROMPT db 'Type "This will be displayed on the screen." ', '$'
USER_INPUT db 50 DUP(?)