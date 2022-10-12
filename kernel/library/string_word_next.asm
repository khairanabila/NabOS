; entry:
; al - ASII code of the separator
; rcx - string size in Bytes
; rsi - a pointer to a string
; Exit:
; CF flag - if no separator is found
; rbx - size of the string to the first delimiter
; or rbx = rcx if the CF flag
library_string_word_next:
    push rax
    push rcx
    push rsi

    xor ebx, ebx

.search:
    dec	rcx
	js	.not_found

    cmp byte[rsi], al
    je .end

    ; move the pointer to the next
    ; character in the command buffer
    inc rsi

    ; increase the number of characters
    ; per found word
    inc rbx
    jmp .search

.not_found:
    stc

.end:
    pop rsi
    pop rcx
    pop rax

    ; return from the procedure
    ret

    macro_debug	"library_string_word_next"