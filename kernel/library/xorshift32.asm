library_xorshift32:
    push rdx

    mov edx, eax
    shl eax, 13
    xor eax, edx
    mov edx, eax
    shr eax, 17
    xor eax, edx
    mov edx, eax
    shl eax, 5
    xor eax, edx

    pop rdx
    ret

    macro_debug "library_xorshift32"
