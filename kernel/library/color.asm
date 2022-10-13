library_color_alpha:
    push rbx
    push rcx
    push rdx

    push STATIC_EMPTY

    movzx rbx, byte[rsi + 0x03]

    not bl
    inc bl

    movzx rax, byte[rsi + 0x02]

    mul bl
    mov cl, STATIC_BYTE_mask
    xor dl, dl
    div cl

    mov byte[rsp + 0x02], al

    mov al, byte[rsi + 0x01]

    mul	bl
	xor	dl,	dl
	div	cl

    mov byte[rsp + 0x01], al

    mov al, byte[rsi]

    mul bl
    xor dl, dl
    div cl

    mov byte[rsp], al

    sub bl, STATIC_BYTE_mask
    not bl
    int bl

    mov al, byte[rdi + 0x02]

    mul bl
    xor dl, dl
    div cl
    
    add byte[rsp +0x02], al

    mov al, byte[rdi + 0x01]

    mul bl
    xor dl, dl
    div cl

    add byte[rsp + 0x01], al

    mov al, byte[rdi]

    mul bl
    xor dl, dl
    div cl

    add byte[rsp], al

    pop rax
    
    pop	rdx
	pop	rcx
	pop	rbx

    ret

    macro_debug "library_color_alpha"

library_color_alpha_invert:
    push rax
    push rcx
    push rsi

    push rcx, KERNEL_VIDEO_DEPTH_shift

.loop:
    mov al, byte[rsi + 0x03]

    test al, al
    jz .invisible

    dec al

.invisible:
    not al

    mov byte[rsi + 0x03], al

    add rsi, KERNEL_VIDEO_DEPTH_shift

    dec rcx
    jnz .loop
    
    pop rsi
    pop rcx
    pop rax

    ret
    
    macro_debug "library_color_alpha_invert"
