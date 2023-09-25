; MACHACON

org 100h
   
   call SETUP_SCREEN 
ret

SETUP_SCREEN:
    call CLEAR_SCREEN
    call DISP_MESS
    call GET_USER_CHOICE
    ret

CLEAR_SCREEN:
    call INIT_MOUSE 
    mov AL, 00h
    mov AH, 06h
    mov BH, 1001_1111b
    xor CX, CX
    mov DH, 24
    mov DL, 79
    int 10h 
    ret   

CLEAR_KB_BUFFER:
    mov AH, 0Ch
    int 21h
    ret
    
DISP_MESS:
    mov AL, 0
    mov BH, 0
    mov BL, 09Eh
    
    mov DH, 02
    mov DL, 39
    mov CX, 4
    mov BP, offset MENU_TEXT 
    call PRINT_STR
    
    mov DH, 05
    xor DL, DL
    mov CX, 22
    mov BP, offset FIRST_CHOICE
    call PRINT_STR 
    
    mov DH, 06
    xor DL, DL
    mov CX, 20
    mov BP, offset SECOND_CHOICE
    call PRINT_STR
    
    mov DH, 07
    xor DL, DL
    mov CX, 22
    mov BP, offset THIRD_CHOICE
    call PRINT_STR 
    
    mov DH, 09
    xor DL, DL
    mov CX, 8
    mov BP, offset QUIT_TEXT
    call PRINT_STR
    
    mov DH, 11
    mov DL, 18
    mov CX, 13
    mov BP, offset CHOICE_TEXT
    call PRINT_STR
    ret
    
GET_USER_CHOICE:
    mov AX, 3 
    int 33h
    cmp BX, 1
    je CHECK_MOUSE
    mov AH, 1h
    int 16h
    jnz CHECK_KEYBOARD
    jmp GET_USER_CHOICE  

CHECK_KEYBOARD:
    cmp AL, 31h
    je SETUP_HORI
    cmp AL, 32h
    je SETUP_VERT
    cmp AL, 3Bh
    je SETUP_CHECK
    cmp AL, 71h
    je QUIT
    ret 

CHECK_MOUSE:
    cmp CX, 0B6h
    jl CHECK_FIRST 
    CHECK_FIRST: 
        cmp DX, 27h
        jg CHECK_FIRST_LOWER
        CHECK_FIRST_LOWER:
            cmp DX, 02Fh
            jl SETUP_HORI
            jmp CHECK_SECOND 
    CHECK_SECOND:
        cmp DX, 30h
        jg CHECK_SECOND_LOWER
        CHECK_SECOND_LOWER:
            cmp DX, 36h
            jl SETUP_VERT
            jmp CHECK_THIRD          
    CHECK_THIRD: 
        cmp DX, 38h
        jg CHECK_THIRD_LOWER
        CHECK_THIRD_LOWER:
            cmp DX, 3Fh
            jl SETUP_CHECK
            jmp CHECK_QUIT
    CHECK_QUIT:
        cmp DX, 48h
        jl GET_USER_CHOICE
        cmp CX, 4Dh
        jg GET_USER_CHOICE
        cmp DX, 4Fh
        jl QUIT
        jmp GET_USER_CHOICE

PROMPT_CONTINUE:  
    mov DH, 22
    mov DL, 30       
    mov AH, 2
    int 10h
    
    mov dx, offset KEY_PROMPT
    mov AH, 9
    int 21h
    
    mov AH, 0
    int 16h 
    ret
    

SETUP_HORI:
    call CLEAR_SCREEN  
    call CLEAR_KB_BUFFER
    
    mov AH, 06h
    xor AL, AL 
    
    mov BH, 0000_0000b
    xor CX, CX
    mov DH, 6
    mov DL, 79
    int 10h
    
    mov BH, 0100_0000b
    mov CH, 6
    mov DH, 12
    mov DL, 79
    int 10h
    
    mov BH, 1110_0000b
    mov CH, 12
    mov DH, 18
    mov DL, 79
    int 10h 
    
    mov BH, 1001_0000b
    mov CH, 18
    mov DH, 24
    mov DL, 79
    int 10h
    
    mov AL, 0
    mov BH, 0
    mov BL, 1001_0000b
    
    call PROMPT_CONTINUE
    call SETUP_SCREEN
    ret

SETUP_VERT:
    call CLEAR_SCREEN
    call CLEAR_KB_BUFFER
    
    mov AH, 06h
    xor AL, AL 
    
    mov BH, 0000_0000b
    xor CX, CX
    mov DH, 24
    mov DL, 20
    int 10h
    
    mov BH, 0100_0000b
    mov CL, 20
    mov DL, 40
    int 10h
    
    mov BH, 1110_0000b
    mov CL, 40
    mov DL, 60
    int 10h 
    
    mov BH, 1001_0000b
    mov CL, 60
    mov DL, 79
    int 10h
    
    mov AL, 0
    mov BH, 0
    mov BL, 1001_0000b
    
    call PROMPT_CONTINUE
    call SETUP_SCREEN
    ret

SETUP_CHECK:
    call CLEAR_SCREEN
    call CLEAR_KB_BUFFER 
    
    mov AH, 06h
    xor AL, AL
    
    ; FIRST ROW
    mov BH, 0000_0000b
    xor CX, CX
    mov DH, 5
    mov DL, 20
    int 10h
    
    mov BH, 0100_0000b
    mov CL, 20
    mov DL, 40
    int 10h
    
    mov BH, 1110_0000b
    mov CL, 40
    mov DL, 60
    int 10h 
    
    mov BH, 0101_0000b
    mov CL, 60
    mov DL, 79
    int 10h
    
    ; SECOND ROW
    mov BH, 0101_0000b
    mov CH, 6
    xor CL, CL
    mov DH, 11
    mov DL, 20
    int 10h
    
    mov BH, 0000_0000b
    mov CL, 20
    mov DL, 40
    int 10h
    
    mov BH, 0100_0000b
    mov CL, 40
    mov DL, 60
    int 10h 
    
    mov BH, 1110_0000b
    mov CL, 60
    mov DL, 79
    int 10h  
    
    ; THIRD ROW
    mov BH, 1110_0000b
    mov CH, 12
    xor CL, CL
    mov DH, 17
    mov DL, 20
    int 10h
    
    mov BH, 0101_0000b
    mov CL, 20
    mov DL, 40
    int 10h
    
    mov BH, 0000_0000b
    mov CL, 40
    mov DL, 60
    int 10h 
    
    mov BH, 0100_0000b
    mov CL, 60
    mov DL, 79
    int 10h  
    
    ; FOURTH ROW
    mov BH, 0100_0000b
    mov CH, 18
    xor CL, CL
    mov DH, 24
    mov DL, 20
    int 10h
    
    mov BH, 1110_0000b
    mov CL, 20
    mov DL, 40
    int 10h
    
    mov BH, 0101_0000b
    mov CL, 40
    mov DL, 60
    int 10h 
    
    mov BH, 0000_0000b
    mov CL, 60
    mov DL, 79
    int 10h 
    
    call PROMPT_CONTINUE
    call SETUP_SCREEN
    ret 
    
PRINT_STR:
    push CS
    pop ES
    mov AH, 13h
    int 10H
    jmp msg1end  
    msg1end:
    ret

INIT_MOUSE:
    mov AX, 1
    int 33h
    ret    
    
QUIT:
    ret
    

MENU_TEXT db 'MENU', '$'
FIRST_CHOICE db '1 - HORIZONTAL STRIPES', '$'
SECOND_CHOICE db '2 - VERTICAL STRIPES', '$'
THIRD_CHOICE db 'F1 - CHECKERED PATTERN', '$'
QUIT_TEXT db 'Q - QUIT', '$' 
CHOICE_TEXT db 'ENTER CHOICE: ', '$'
KEY_PROMPT db 'Press an key to continue', '$'