; MACHACON

org 100h

call PART_A
call PART_B    
ret

PART_A:
    mov AL, B
    mov BL, D
    mul BL
    mov BH, AL ; Transfers product to BH for storing
    
    mov AL, A
    mov BL, B
    div BL
    mov CH, AL ; Transfers quotient to CH for storing
    
    mov AL, A
    sub AL, B
    add AL, E ; Transfers 3rd expression's result to AL
    
    add BH, CH
    sub BH, AL
ret

PART_B:
    mov AL, Z
    mov BL, W
    mul BL
    add AL, Y
  
    mov BL, 100
    div BL
    mov X, AL    ; Stores value in var X

ret


A db 12
B db 4
C db ?
D db 3
E db 5
W db 11
X db ?
Y db 2
Z db 18      