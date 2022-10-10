; put back on the stack the address of the return procedure
%MACRO macro_library 1
    push rbp
    mov rbp, %%exit
    xchg rbp, qword[rsp]

    ; put the library address on the stack
    push rbp
    mov rbp, LIBRARY_BASE_address + %1
    mov rbp, qword[rbp]
    mov rbp, qword[rsp]

    ret
%%exit:
%ENDMACRO
    