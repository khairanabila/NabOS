library_string_cut:
    push rsi
    push rcx

.loop:
    cmp byte[rsi], STATIC_SCANCODE_TERMINATOR
    je .end

    cmp byte[rsi], al
    je .end

    inc rsi
    dec rcx

    jnz .loop

    stc

.end:
    sub dword[rsp], rcx
    pop rcx
    pop rsi

    ret
    macro_debug "library_string_cut"
    