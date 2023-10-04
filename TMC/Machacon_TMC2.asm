; MACHACON

org 100h
    
    lea DX, MSG1
    mov AH, 09h
    int 21h
    
    lea BX, USER_INP
    call ASK_PER_CHAR
    call NEW_LINE  
    xor CX, CX              ; Flush CX to zero to be used as a counter for number of vowels
    lea BX, USER_INP 
    call CHECK_VOWELS
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

CHECK_VOWELS:
    cmp [BX], '$'
    je PRINT_VOWELS
    cmp [BX], 'A'
    je ADD_VOWEL 
    cmp [BX], 'a'
    je ADD_VOWEL
    cmp [BX], 'E'
    je ADD_VOWEL
    cmp [BX], 'e'
    je ADD_VOWEL 
    cmp [BX], 'I'
    je ADD_VOWEL
    cmp [BX], 'i'
    je ADD_VOWEL
    cmp [BX], 'O'
    je ADD_VOWEL
    cmp [BX], 'o'
    je ADD_VOWEL
    cmp [BX], 'U'
    je ADD_VOWEL
    cmp [BX], 'u'
    je ADD_VOWEL
    inc BX              ; Increments current string index
    jmp CHECK_VOWELS

PRINT_VOWELS:
    pusha
    lea DX, MSG2
    mov AH, 09h
    int 21h
    popa
    
    pusha
    mov AL, CL
    aam                 ; Splits the hex value into BCD
    add AX, 3030h       ; Convert AX to ASCII
    mov DL, AH   
    mov DH, AL
    cmp DL, 30h
    je SECOND_DIGIT     ; Jumps to second digit if it is a single-digit value.
    mov AH, 02h
    int 21h             ; Prints number of vowels stored in CX previously. It is incremented by 30 in order to print in ASCII.
    SECOND_DIGIT:
    mov DL, DH
    mov AH, 02h
    int 21h
    popa
    
    pusha
    lea DX, MSG3
    mov AH, 09h
    int 21h
    popa
    ret    
    
ADD_VOWEL:
    inc CX              ; Increments count of vowels
    inc BX              ; Increments current string index
    jmp CHECK_VOWELS
    
NEW_LINE:
    push AX
    mov DX, offset NL
    mov AH, 09h
    int 21h  
    pop AX
    ret 

EXIT:
    ret


MSG1 db 'Input a string: ', '$'
MSG2 db 'The string contains ', '$'
MSG3 db ' vowels!', '$'
NL db 13, 10, '$' 
USER_INP db 50 DUP(?)