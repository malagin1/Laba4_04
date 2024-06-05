; multi-segment executable file template.

data segment
     a db ?
     x db ?
     y1 db ?
     y2 db ?
     y db ?
     PERENOS db 13,10,"$"
     VVod_a db 13,10,"Vvedite a=$"
     VVOd_x dw 13,10, "Vvedite x=$". 13,10
     Vivod_y db "Y=$"
    ; add your data here!
    pkey db "press any key...$"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax 
    xor ax, ax
    mov dx, offset Vvod_a
    mov ah, 9
    int 21h
    
    Sled2:
    mov ah, 1
    int 21h
    cmp al, "-"
    jnz sled1
    mov bx, 1 
    jmp Sled2
    
    Sled1:
    sub al, 30h
    test bx, bx
    jz Sled3 
    neg al
    
    Sled3:
    mov a, al
    xor ax, ax
    xor bx, bx
    
    Mov dx, offset Vvod_x
    mov ah, 9
    int 21h
    
    Sled4:
    mov ah, 1
    int 21h
    cmp al, "-"
    jnz Sled5
    mov bx, 1
    jmp Sled4 
    
    Sled5:
    sub al, 30h
    test bx, bx
    jz Sled6
    neg al
    
    Sled6:
    mov x, al
    
    cmp al, 1
    jl @RIGHT                               
    jmp Short @LEFT
    @RIGHT:
    add al, 8
    jmp Short @VIXOD
    @LEFT:
    mov al, a
    add al, al 
    jmp Short @VIXOD
    @VIXOD:
    mov y1, al
    
    xor al, al
    mov al, x
    cmp al, a
    jz @RIGHT2
    jmp Short @LEFT2
    @RIGHT2:
    mov al, 3
    jmp Short @VIXODD 
    @LEFT2:
    mov al, a
    sub al, 1
    jmp Short @VIXODD  
    @VIXODD:
    mov y2, al
    
    mov al, y1
    div y2
    mov y, ah
    
    mov dx, offset perenos
    mov ah, 9
    int 21h
    
    mov dx, offset Vivod_y
    mov ah, 9
    int 21h
    
    mov al, y
    cmp y, 0
    jge SLED7
    
    neg al
    mov bl, al
    mov dl, "-"
    mov ah, 2
    int 21h
    mov dl, bl
    add dl,30h
    int 21h
    jmp SLED8
    
    SLED7:
    mov dl,y
    add dl, 30h
    mov ah,2
    int 21h
    
    SLED8:
    mov dx, offset perenos
    mov ah,9
    int 21h
    mov ah,11
    int 21h
    mov ax, 4c00h
    int 21h
        
ends

end start ; set entry point and stop the assembler.