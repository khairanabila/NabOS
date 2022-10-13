library_string_to_integer:
    push rbx
    push rcx
    push rdx
    push rsi
    push r8
    push rax

    mov ecx, 1
    xor r8, r8

.loop:
    movzx eax, byte[rsi + rbx - 0x01]
    sub al, STATIC_SCANCODE_DIGIT_0
    mul rcx

    add r8, rax
    
    mov eax, STATIC_NUMBER_SYSTEM_decimal
    mov rcx
    mov rcx, rax

    dec rbx
    jnz .loop

    mov qword[rsp], r8

    pop rax
    pop r8
    pop rsi
    pop rdx
    pop rcx
    pop rbx

    ret

    macro_debug "library_string_to_integer"