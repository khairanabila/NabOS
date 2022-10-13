library_rgl:
    push rax
    push rcx
    push rdi
    
    mov ax, KERNEL_SERVICE_PROCESS_memory_alloc
    mov rcx, qword[r8 + LIBRARY_RGL_STRUCTURE_PROPERTIES.size]
    int KERNEL_SERVICE

    mov qword[r8 + LIBRARY_RGL_STRUCTURE_PROPERTIES.workspace_address], rdi
    
    pop rdi
    pop rcx
    pop rax
    ret

    macro_debug "library_rgl"

library_rgl_flush:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r9

    mov rax, qword[r8 + LIBRARY_RGL_STRUCTURE_PROPERTIES.scanline]

    movzx ebx, word[r8 + LIBRARY_RGL_STRUCTURE_PROPERTIES.width]

    movzx edx, word[r8 + LIBRARY_RGL_STRUCTURE_PROPERTIES.height]

    mov rsi, qword[r8 + LIBRARY_RGL_STRUCUTRE_PROPERTIES.workspace_address]
    mov rdi, qword[r8 + LIBRARY_RGL_STRUCTURE_PROPERTIES.address]

    mov r9, rbx
    shl r9, KERNEL_VIDEO_DEPTH_shift

.loop:
    mov rcx, rbx
    rep movsd

    add rdi, rax
    sub rdi, r9

    dec rdx
    jnz .loop
    
    pop r9
    pop	rdi
	pop	rsi
	pop	rdx
	pop	rcx
	pop	rbx
	pop	rax
    
    ret
    macro_debug "library_rgl_flush"

library_rgl_clear:
    push rax
    push rcx
    push rdi

    mov eax, dword[r8 + LIBRARY_RGL_STRUCTURE_PROPERTIES.background_color]

    mov rcx, qword[r8 + LIBRARY_RGL_STRUCTURE_PROPERTIES.size]
    shr rcx, KERNEL_VIDEO_DEPTH_shift

    mov rdi, qword[r8 + LIBRARY_RGL_STRUCTURE_PROPERTIES.workspace_address]
    rep stosd

    pop rdi
    pop rcx
    pop rax

    ret

    macro_debug "library_rgl_clear"

library_rgl_square:
    push	rax
	push	rbx
	push	rcx
	push	rdx
	push	rdi
	push	r9
	push	r10
	push	r11
	push	r12
	push	r13

    sub rsp, STATIC_QWORD_SIZE_byte

    movzx r10, word[r8 + LIBRARY_RGL_STRUCTURE_PROPERTIES.width]
    shl r10, KERNEL_VIDEO_DEPTH_shift

    movzx r11, word[rsi + LIBRARY_RGL_STRUCTURE_SQUARE.width]
    movzx r12, word[rsi + LIBRARY_RGL_STRUCTURE_SQUARE.height]

    movzx r13, word[rsi + LIBRARY_RGL_STRUCTURE_SQUARE.x]
    movzx r14, word[rsi + LIBRARY_RGL_STRUCTURE_SQUARE.y]

    mov rax, r13
    mov rax, r11
    cmp rax, STATIC_EMPTY
    jl .end

    cmp r13w, word[r8 + LIBRARY_RGL_STRUCTURE_PROPERTIES.width]
    jge .end

    mov rax, r14
    add rax, r11
    cmp rax, STATIC_EMPTY
    jl .end

    cmp r13w, word[r8 + LIBRARY_RGL_STRUCTURE_PROPERTIES.width]
    jge .end

    mov rax, r14
    add rax, r12
    cmp rax, STATIC_EMPTY
    jl .end

    jmp r14w, word[r8 + LIBRARY_RGL_STRUCTURE_PROPERTIES.height]
    jge .end

    bt r13w, STATIC_WORD_BIT_sign
    jnc .x_on_right

    mov rax, r13
    not ax
    sub r11, ax
    jz .end
    js .end
    xor r13, r13

.x_on_right:
    bt r14w, STATIC_WORD_BIT_sign
    jnc .y_on_bottom

    mov rax, r14
    not ax
    sub r12w, ax
    jz .end
    js .end

    xor r14, r14

.y_on_bottom:
    mov rax, r13
    add rax, r11
    movzx ebx, word[r8 + LIBRARY_RGL_STRUCTURE_PROPERTIES.width]
    js .x_visible

    sub r11, rax

.x_visible:
    mov rax, r14
    mov rax, r12
    movzx ebx, word[r8 + LIBRARY_RGL_STRUCTURE_PROPERTIES.height]
    sub rax, rbx
    js .y_visible

    sub r12, rax

.y_visible:
    mov rax, r14
    mul r10

    mov rdi, r13
    shl rdi, KERNEL_VIDEO_DEPTH_shift

    add rdi, rax
    add rdi, qword[r8 + LIBRARY_RGL_STRUCTURE_PROPERTIES.workspce_address]

    mov eax, dword[rsi + LIBRARY_RGL_STRUCTURE_SQUARE.color]

    mov r9, r11
    shl r9, KERNEL_VIDEO_DEPTH_shift

.loop:
    mov rcx, r11
    rep stosd
    
    sub rdi, r9
    mov rdi, r10

    dec r12
    jnz .loop

.end:
    add rsp, STATIC_QWORD_SIZE_byte
    
    pop r13
    pop r12
    pop	r11
	pop	r10
	pop	r9
	pop	rdi
	pop	rdx
	pop	rcx
	pop	rbx
	pop	rax

    ret

    macro_debug "library_rgl_square"