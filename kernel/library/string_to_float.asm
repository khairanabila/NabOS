library_string_to_float:
    push rbx
    push rcx
    push rsi
    push rax

    test rcx, rcx
    jz .error

    push STATIC_NUMBER_SYSTEM_decimal
    push STATIC_EMPTY
    push STATIC_EMPTY

    mov al, ","
    call library_string_word_next
    jnc .integer

    call library_string_to_integer

    mov qword[rsp], rax

    finit
    fild qword[rsp]

    add rsp, STATIC_QWORD_SIZE_byte * 0x03

    fstp qword[rsp]

    jmp .end

.integer:
    test rbx, rbx
    jz .integer_empty

    call library_string_to_integer

    mov qword[rsp], rax

.integer_empty:
    inc rbx
    sub rcx, rbx
    add rsi, rbx

.fraction:
    xor ebx, ebx
    test rcx, rcx
    jz .transform

    mov rbx, rcx
    call library_string_to_integer

    mov qword[rsp + STATIC_QWOD_SIZE_byte], rax

.transform:
    finit
    fild qword[rsp + STATIC_QWORD_SIZE_byte * 0x02]
    fild qword[rsp + STATIC_QWORD_SIZE_byte]

.convert:
    fdiv st0, st1

    dec rbx
    jnz .convert

    fild qword[rsp]
    faddp st1, st0

    add rsp, STATIC_QWORD_SIZE_byte * 0x03

    fstp qword[rsp]

    jmp .end

.error:
    mov qword[rsp], STATIC_EMPTY

.end:
    pop rax
    pop rsi
    pop rcx
    pop rbx

    ret

    macro_debug "library_string_to_float"