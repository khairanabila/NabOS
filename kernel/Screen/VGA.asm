[bits 16]
[cpu 286]

VgaBuffer equ 0xb800 

VgaRows equ 25
VgaColumns equ 80
VgaDefaultColour equ 0xf 

CurrentColour: db VgaDefaultColour
CurrentRow: db 0
CurrentColumn: db 0
CursorPos: dw 0

%macro VgaPrintChar 2
    push bx

    mov bl, %2
    cmp bl, byte 0
    je %%Print

    mov byte [CurrentColour], %2

    %%Print:
        mov bx, VgaBuffer
        mov gs, bx

        mov bx, word [CursorPos]
        mov byte [gs:bx], %1

        inc bx
        mov ah, byte [CurrentColour]
        mov byte [gs:bx], ah

        add word [CursorPos], 2
        inc byte [CurrentColumn]
    VgaSetCursor

    pop bx

    mov byte [CurrentColour], VgaDefaultColour

%endmacro

%macro VgaPrintNewLine 1
    add byte [CurrentRow], %1
    mov byte [CurrentColumn], %1 

    cmp byte [CurrentRow], 25
    jl %%AddNewLine

    sub byte [CurrentRow], %1
    mov al, %1
    call VgaScroll

    %%AddNewLine:
        xor dx, dx
        mov ax, word [CursorPos]
        mov bx, VgaColumns
        div bx

        sub word [CursorPos], dx

        mov al, byte [CurrentColumn]
        mov bx, 160
        mul bx

        add word [CursorPos], ax
        mov byte [CurrentColumn], 0

%endmacro
%macro VgaCarriageReturn 0
    push ax

    mov bl, byte [CurrentColumn]
    mov bh, 0
    mov ax, word [CursorPos]
    sub ax, bx
    sub ax, bx

    mov word [CursorPos], ax
    mov byte [CurrentColumn], 0

    pop ax

%endmacro


%macro VgaSetCursor 0
    push ax
    push bx
    push dx

    mov ah, 0x2
    mov bh, 0
    mov dh, byte [CurrentRow]
    mov dl, byte [CurrentColumn]
    int 0x10

    pop dx
    pop bx
    pop ax

%endmacro

VgaInit:
    mov dx, 0x03da
    in al, dx
    mov dx, 0x03c0
    mov al, 0x30
    out dx, al
    mov dx, 0x03c1
    in al, dx
    and al, 0xf7
    mov dx, 0x03c0
    out dx, al
    ret
VgaPrintString:
    push bx
    push ax
    cmp ah, 0
    je .PrintLoop

    mov byte [CurrentColour], ah

    .PrintLoop:
        lodsb 
        cmp al, byte 0
        je .Exit

        cmp al, byte 10
        je .NewLine

        cmp al, byte 13
        je .CarriageReturn

        mov bx, VgaBuffer
        mov gs, bx
        mov bx, word [CursorPos]
        mov byte [gs:bx], al

        inc bx 
        mov cl, byte [CurrentColour]
        mov byte [gs:bx], cl

        add word [CursorPos], 2
        inc byte [CurrentColumn]
        cmp word [CursorPos], 4000
        jle .Skip

        mov al, 1
        call VgaScroll
        jmp .Skip

        .NewLine:
            VgaPrintNewLine 1
            VgaSetCursor

            jmp .Skip


        .CarriageReturn:
            VgaCarriageReturn

        .Skip:
            jmp .PrintLoop
    .Exit:
        pop ax
        pop bx

        VgaSetCursor
        mov byte [CurrentColour], VgaDefaultColour

        ret
VgaNewLine:
    push cx

    VgaCarriageReturn
    VgaPrintNewLine al
    VgaSetCursor

    pop cx

    ret
VgaPaintLine:
    mov bx, word [CursorPos]
    push bx
    mov bl, [CurrentColumn]
    xor bh, bh
    push bx

    VgaCarriageReturn
    mov cx, VgaColumns 
    add word [CursorPos], 1
    .Loop:
        cmp cx, 0
        je .Exit

        mov bx, VgaBuffer
        mov gs, bx

        mov bx, word [CursorPos]
        mov byte [gs:bx], al

        add word [CursorPos], 2

        dec cx
        jmp .Loop

    .Exit:
        pop bx
        mov byte [CurrentColumn], bl
        pop bx
        mov word [CursorPos], bx

        ret
VgaScroll:
    push ax
    push bx
    push cx
    push dx
    push ax

    mov ah, 0x6
    mov bh, 0     
    mov ch, 0
    mov cl, 0
    mov dh, VgaRows
    mov dl, VgaColumns

    int 0x10
    mov ax, word 160
    pop bx 
    xor bh, bh
    mul bx

    sub word [CursorPos], ax
    sub byte [CurrentRow], bl
    .Finished:
        pop dx
        pop cx
        pop bx
        pop ax

        VgaSetCursor

        ret
VgaClearScreen:
    mov ah, 0x0
    mov al, 0x3
    int 0x10

    mov word [CursorPos], 0
    mov byte [CurrentColumn], 0
    mov byte [CurrentRow], 0

    ret
