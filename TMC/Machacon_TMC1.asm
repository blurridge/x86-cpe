; MACHACON

org 100h

    lea DX, MSG1
    mov AH, 09h
    int 21h
    
    lea BX, NUM_STR
    call ASK_FOR_VALUE
    call STRING_TO_NUMBER
    call NEW_LINE        
    call CHECK_EVEN
ret

ASK_FOR_VALUE:
    mov AH, 00H
    int 16H 
    mov [BX], AL   
    cmp AL, '$'
    je EXIT 
    mov AH, 02H
    mov DL, AL
    int 21H
    inc BX
    jmp ASK_FOR_VALUE 
    
STRING_TO_NUMBER:
    xor BX, BX          
    lea SI, NUM_STR    
    xor AX, AX 
    mov CX, 10d        

CONVERT_LOOP:
    mov BL, [SI]        ; Gets current char
    cmp BL, '$'         
    je EXIT             
    sub BL, 30h         ; Gets actual value of char 
    imul CX             ; CX contains 10d. This is done in order to move the current answer's decimal point one place to the right.
    add AX, BX          ; The moving is done in order to accommodate space for the new one's place which is the current digit stored in BX
    inc SI              
    jmp CONVERT_LOOP

CHECK_EVEN:
    pusha
    xor AH, AH
    mov DL, 2h          
    div DL              ; AX is divided by DL in order to see if a remainder is stored in AH. 
    cmp AH, 1           ; If AH is 1, that means there is a remainder and that makes it odd.
    je PRINT_ODD
    cmp AH, 0           ; Otherwise, even.
    je PRINT_EVEN
    popa
    ret

PRINT_ODD:
    lea DX, ODD_MSG
    mov AH, 09h
    int 21h
    ret

PRINT_EVEN:
    lea DX, EVEN_MSG
    mov AH, 09h
    int 21h
    ret

NEW_LINE:
    push AX
    mov DX, offset NL
    mov AH, 09h
    int 21h  
    pop AX
    ret

EXIT:
    ret 

MSG1 db 'Input a value: ', '$' 
ODD_MSG db 'The value is an odd number!', '$'
EVEN_MSG db 'The value is an even number!', '$'
NUM_STR DB 50 DUP(?)
NL db 10, 13, '$'