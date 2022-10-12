library_page_from_size:
    push rcx

    and cx, STATIC_PAGE_mask

    cmp rcx, qword[rsp]
    je .ready

    add rcx, STATIC_PAGE_SIZE_byte

.ready:
    shr rcx, STATIC_DIVIDE_BY_PAGE_shift
    add rsp, STATIC_QWORD_SIZE_byte
    ret
    macro_debug "library_page_from_size"