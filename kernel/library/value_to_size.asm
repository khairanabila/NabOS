library_value_to_size:
    push rcx
    push rax

    ; initialize size
    xor ebx, ebx

    ; basic size converter
    mov ecx, 1024

    ; default percentage of the rest
    xor edx, edx

    cmp rax, 1024
    jb .end

.loop:
    ; convert the original value 
    ; to the appropriate size
    mov rax, qword[rsp]
    div rcx

    ; next value size
    shl rcx, STATIC_MULTIPLE_BY_1024_shift

    ; converted to the next size
    inc bl

    cmp rax, 1024
    jae .loop

    mov qword[rsp], rax

    mov rax, rdx
    mov edx, 100
    shr ecx, STATIC_DIVIDE_BY_1024_shift
    mul rdx
    div rcx

    mov rdx, rax

.end:
    pop rax
    pop rcx

    ret
    
    macro_debug "library_value_to_size"
