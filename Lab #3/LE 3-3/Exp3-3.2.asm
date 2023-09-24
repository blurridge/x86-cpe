; MACHACON

org 100h

   lea DX, MSG1
   mov AH, 09H
   int 21H
   lea BX, BUFFER  
   call ASK_PER_CHAR
   call NEW_LINE
   lea DX, MSG2  
   mov AH, 09H
   int 21H
   lea BX, NUM_STR  
   call ASK_TIMES_TO_PRINT   
   call STRING_TO_NUMBER 
   mov CX, AX
   call PRINT_LOOP 
     
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

ASK_TIMES_TO_PRINT:
    mov AH, 00H
    int 16H 
    mov [BX], AL   
    cmp AL, '$'
    je EXIT 
    mov AH, 02H
    mov DL, AL
    int 21H
    inc BX
    jmp ASK_TIMES_TO_PRINT 

STRING_TO_NUMBER:
    xor BX, BX          
    lea SI, NUM_STR    
    xor AX, AX 
    mov CX, 10d        

CONVERT_LOOP:
    mov BL, [SI]        
    cmp BL, '$'         
    je EXIT             
    sub BL, 30h        
    imul CX             
    add AX, BX         
    inc SI              
    jmp CONVERT_LOOP    
    
PRINT_LOOP:  
    call NEW_LINE
    cmp CX, 0
    jz EXIT
    mov DX, offset BUFFER 
    mov AH, 09H
    int 21H
    dec CX 
    jmp PRINT_LOOP

NEW_LINE:
    mov DX, offset NL
    mov AH, 09h
    int 21h
    ret

EXIT:
    ret

MSG1 DB 'Input your name, program, and year level: ', '$'
MSG2 DB 'Times to print: ', '$'
BUFFER DB 50 DUP(?)   
NUM_STR DB 50 DUP(?) 
NL db 10, 13, '$'