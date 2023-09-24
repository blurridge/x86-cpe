; MACHACON

org 100h

call PART_A
call NEW_LINE
call PART_B
call NEW_LINE
call PART_C
call NEW_LINE
call PART_D

ret  

PART_A:
    mov AL, CHAR_TO_USE
    not AL  
    mov DL, AL
    mov AH, 02h
    int 21h
    ret      

PART_B:
    mov BL, CHAR_TO_USE
    or BL, 20h          ; ORing characters equivalent binary with 20h in order to do bitwise subtraction.
    mov DL, BL
    mov AH, 02h
    int 21h
    ret

PART_C:
    mov AL, BIN_TO_USE
    aam                 ; Stores tens digit to AH, ones digit to AL 
    add AX, 3030h       ; Adds 30h to both digits for printing
    mov DL, AH          
    mov DH, AL
    
    mov AH, 02h
    int 21h
    
    mov DL, DH
    mov AH, 02h
    int 21h 
    ret

PART_D:
    mov BL, CHAR_TO_USE 
    CHECK_LOWER:  
        cmp BL, 'a'
        jl CHECK_UPPER
        cmp BL, 'z'
        jl TO_UPPER
    CHECK_UPPER: 
        cmp BL, 'A'
        jl EXIT
        cmp BL, 'Z'
        jl TO_LOWER
    TO_UPPER:  
        and BL, 0DFh        ; Difference between lowercase and uppercase is 6th bit from the right. Perform AND with (11011111) to 
        mov DL, BL          ; change lower to upper. Example: Lowercase a (01100001) Uppercase A (01000001). To forcefully change 6th bit
        mov AH, 02h         ; from 1 to 0 or 0 to 1, an AND with 11011111 would work. This effectively changes 01100001 to 01000001. 
        int 21h
        ret 
    TO_LOWER:
        or BL, 20h          ; ORing characters equivalent binary with 20h in order to do bitwise subtraction.
        mov DL, BL
        mov AH, 02h
        int 21h
        ret
 
NEW_LINE:
    mov DX, offset NL
    mov AH, 09h
    int 21h
    ret

EXIT:
    ret   
    
CHAR_TO_USE db 'A'
NL db 10, 13, '$' 
BIN_TO_USE db 101011b ; 43 in binary