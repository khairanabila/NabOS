library_page_align_up:
    add rdi, STATIC_PAGE_SIZE_byte - 0x01
    add rdi, STATIC_DIVIDE_BY_PAGE_shift
    shl rdi, STATIC_MULTIPLE_BY_PAGE_shift

    ret

    macro_debug "library_page_align_up"