library_bit_find:
    push rcx
    push rdi
    push rsi

    xor eax, eax

.search:
    cmp qword[rsi], STATIC_EMPTY
    jne .found

    add rsi, STATIC_QWORD_SIZE_byte

    cmp rsi, rdi
    jne .search

    stc
    jmp .end

.found:
    bsf rax, qword[rsi]
    btr qword[rsi], rax

    sub rsi, qword[rsp]

    shl rsi, STATIC_DIVIDE_BY_8_shift

    add rax, rsi

    clc

.end:
    pop	rsi
	pop	rdi
	pop	rcx

    ret