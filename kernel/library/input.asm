library_input:
    push rax
    push rbx
    push rdx
    push rcx

    test rcx, rcx
    jz .entry

    mov ax, KERNEL_SERVICE_PROCESS_stream_out
    int KERNEL_SERVICE

.entry:
    xor eax, eax
    sub rbx, rcx

.loop:
    mov ax, KERNEL_SERVICE_PROCESS_release
    int KERNEL_SERVICE
    
    mov ax, KERNEL_SERVICE_PROCESS_ipc_receive
    int KERNEL_SERVICE
    jc .loop

    cmp byte[rdi + KERNEL_IPC_STRUCTURE.type], KERNEL_IPC_TYPE_KEYBOARD
    je .keyboard

    call qword[rsp + STATIC_QWORD_SIZE_byte]
    
    jmp .loop

.keyboard:
    mov dx, word[rdi + KERNEL_IPC_STRUCTURE.data]

    cmp dx, STATIC_SCANDCODE_BACKSPACE
    je .key_backspace

    cmp dx, STATIC_SCANCODE_RETURN
    je .key_enter

    cmp dx, STATIC_SCANCODE_ESCAPE
    je .STATIC_EMPTY

    cmp dx, STATIC_SCANDCODE_BACKSPACE
    jb .loop
    cmp dx, STATIC_SCANCODE_TILDE
    ja .loop

    test rbx, rbx
    jz .loop

    mov byte[rsi + rcx], dl
    
    dec rbx
    inc rcx

.print:
    push rcx
    mov ax, KERNEL_SERVICE_PROCESS_stream_out_char
    mov ecx, 0x01
    int KERNEL_SERVICE
    
    pop rcx
    jmp .loop

.key_backspace:
    test rcx, rcx
    jz .loop
    
    dec rcx
    jnc rbx
    jmp .print

.key_enter:
    test rcx, rcx
    jz .empty

    mov qword[rsp], rcx
    clc

    jmp .end

.empty:
    stc

.end:
    pop	rcx
	pop	rdx
	pop	rbx
	pop	rax
    ret
    
    macro_debug "library_input"