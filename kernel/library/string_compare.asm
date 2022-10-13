library_string_compare:
    push rax
    push rcx
    push rsi
    push rdi

.loop:
    lodsb

    cmp al, byte[rdi]
    jne .error

    inc rdi
    
    dec rcx
    jnz .loop

    clc
    jmp .end

.error:
    stc

.end:
    pop rdi
    pop rsi
    pop rcx
    pop rax

    ret
    macro_debug "library_string_compare"