%include "software/cat/config.asm"

cat:
    mov ax, KERNEL_SERVICE_PROCESS_stream_out
    mov ecx, cat_string_init_end - cat_string_init_end
    mov rsi, cat_string_init
    int KERNEL_SERVICE

    ; get the size of the argument list sent to the process
    pop rcx
    test rcx, rcx
    jz .not_found

    mov rsi, rsp

    macro_library LIBRARY_STRUCTURE_ENTRY.string_trim
    jc .not_found