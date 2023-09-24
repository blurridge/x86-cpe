; MACHACON

org 100h
    
   lea DX, MSG1
   mov AH, 09H
   int 21H 
   lea BX, INP_STR  
   call ASK_PER_CHAR
   call NEW_LINE 
   lea BX, INP_STR
   call CHECK_STR 
   call NEW_LINE
   lea BX, INP_STR
   call IS_PAL

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

CHECK_STR:
    cmp [BX], '$'
    je NO_NUM
    cmp [BX], 30h
    jg IS_NUM

IS_NUM:
    cmp [BX], 3Ah
    jl FOUND_NUM
    inc BX
    jmp CHECK_STR 

NO_NUM:
    lea DX, NUM_FALSE
    mov AH, 09H
    int 21H
    ret  
    
FOUND_NUM:
    lea DX, NUM_TRUE
    mov AH, 09H
    int 21H
    mov DL, [BX]
    mov AH, 02H
    int 21H
    ret

IS_PAL:
    mov CX, 0h
    COUNT_LEN:
        push BX
        GET_LEN:
            cmp [BX], '$'
            je PAL_OR_NOT
            inc BX
            inc CX
            jmp GET_LEN
   PAL_OR_NOT:
        pop BX
        mov SI, BX
        push CX
        add CX, SI 
        dec CX
        lea DI, CX 
        pop CX
        CHECK_PAL:
            mov AL, [SI]
            mov BL, [DI]
            cmp AL, BL
            jne NOT_PAL
            
            inc SI
            dec DI
            
            cmp SI, DI
            jae FOUND_PAL
            
            jmp CHECK_PAL
    
NOT_PAL:
    lea DX, PAL_FALSE
    mov AH, 09H
    int 21H
    ret 

FOUND_PAL:
    lea DX, PAL_TRUE
    mov AH, 09H
    int 21H
    ret   
     
NEW_LINE:
    mov DX, offset NL
    mov AH, 09h
    int 21h
    ret

EXIT:
    ret

INP_STR DB 50 DUP(?)    
NL db 10, 13, '$'
MSG1 DB 'Input a string: ', '$'
NUM_FALSE DB 'There is no number in the inputted string.', '$'
NUM_TRUE DB 'The inputted string contains a number. The number is: ', '$'
PAL_FALSE DB 'The inputted string is not a palindrome.', '$' 
PAL_TRUE DB 'The inputted string is a palindrome.', '$'