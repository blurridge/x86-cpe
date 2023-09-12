
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h     
    
    mov DI, 0           ; Initializes offset of display to 0. This makes it appear on the top-left of the screen.
    lea SI, GREETING    ; Loads GREETING's memory address to SI. SI is used since GREETING will be the source of our data. Hence the name, SOURCE INDEX.
    call DISPLAY_MSG    

ret

GREETING db "Hello! My name is Zach.", 0 

DISPLAY_MSG:
    pusha                   ; Pushes all register values to the stack. This is just good practice but not required. We usually only push values we want their values saved.
    mov AX, 0B800h          ; Moves the address of the CGA display to AX. It has to go through AX since we cannot directly move it to ES. Only register -> segment MOVs are allowed.
    mov ES, AX              ; Moves the address from AX to ES. This is explained by the last comment.
    SHOW:
         cmp [SI], 0        ; Current character is compared to 0. This is because our null terminator is the 0.
         jz EXIT            ; If previous cmp returns TRUE or 1, then call EXIT
         movsb              ; Macro to do ES:[DI] = DS:[SI]. We are basically transferring the current character to the display.
         inc DI             ; Since MOVSB only increments DI by 1, we need to increment it one more time since characters take up 2 bytes each.
    LOOP SHOW
    EXIT:
        popa                ; Returns all former values of the registers to its old value. 
        ret

INVERT_MSG:
    