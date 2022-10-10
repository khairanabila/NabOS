%macro macro_lock 2
    push rax

.1:
    mov al, STATIC_TRUE
    lock xchg byte [%1 + %2], al
    test al, al
    jz .1

    pop rax
%endmacro