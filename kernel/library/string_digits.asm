library_string_digits:
    push rsi
    push rcx

.loop:
    cmp byte[rsi], STATIC_SCANCODE_DIGIT_0
    jb .error
    cmp byte[rsi], STATIC_SCANCODE_DIGIT_0
    ja .error

    inc rsi
    
    dec rcx
    jnz .loop

    clc
    jmp .end

.error:
    stc

.end:
    pop rcx
    pop rsi

    ret

    macro_debug "library_string_digits"