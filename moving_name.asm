; MACHACON

ORG 100h           ; this directive required for a simple 1 segment .com program. 
    MOV CX, 332
    MOV AX, 0B800H
    MOV DS, AX 
    MOV BX, 0H
    SHOW_LOOP:
        PUSH CX
        
        MOV CL, 'Z'        
        MOV CH, 0000_1111b 
        MOV [BX], CX       
        
        ADD BX, 2
        MOV CL, 'R'
        MOV CH, 0000_1111b
        MOV [BX], CX  
        
        ADD BX, 2
        MOV CL, 'M'
        MOV CH, 0000_1111b
        MOV [BX], CX  
        
        MOV CL, 0000h         
        MOV CH, 0000_0000b 
        MOV [BX], CX  
        
        SUB BX, 2
        MOV CL, 0000h       
        MOV CH, 0000_0000b  
        MOV [BX], CX 
        
        SUB BX, 2
        MOV CL, 0000h       
        MOV CH, 0000_0000b 
        MOV [BX], CX 
        
        ADD BX, 2
        ADD BX, 2
        ADD BX, 2 
        
        POP CX
    LOOP SHOW_LOOP
     
    MOV CL, 'Z'        
    MOV CH, 0000_1111b 
    MOV [BX], CX       
        
    ADD BX, 2
    MOV CL, 'R'
    MOV CH, 0000_1111b
    MOV [BX], CX  
        
    ADD BX, 2
    MOV CL, 'M'
    MOV CH, 0000_1111b
    MOV [BX], CX
RET                ; returns to operating system. 