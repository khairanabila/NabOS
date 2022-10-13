library_integer_to_string:
    push	rax
	push	rdx
	push	rdi
	push	rbp
	push	r9
	push	rcx

    cmp rbx, 2
    jb .error
    cmp rbx, 36
    ja .error

    mov r9, rdx
    xor rdx, rdx

    mov rbx, rsp

.loop:
    div rbp
    add rdx, STATIC_SCANCODE_DIGIT_0
    push rdx

    dec rcx
    xor rdx, rdx
    
    test rax, rax
    jnz .loop

    cmp rcx, STATIC_EMPTY
    jle .init

.prefix:
    push r9
    dec rcx
    jnz .prefix

.init:
    xor ecx, ecx

.return:
    cmp rsp, rbp
    je .end

    pop rax

    cmp al, 0x3A
    jb .no

    add al, 0x07

.no:
    stosb

    inc rcx

    jmp .return

.error:
    stc

.end:
    mov qword[rsp], rcx

    pop	rcx
	pop	r9
	pop	rbp
	pop	rdi
	pop	rdx
	pop	rax

    ret

    macro_debug "library_integer_to_string"