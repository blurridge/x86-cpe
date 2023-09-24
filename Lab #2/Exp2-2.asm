
; MACHACON

org 100h

    MOV SI, 02h
    MOV DI, 04h
    MOV AX, 0004h
    MOV BX, [AX + SI + 08] 
    MOV CX, 0000h
    MOV DX, [AX + DI + 08]

ret

