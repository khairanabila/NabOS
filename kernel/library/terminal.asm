%include "kernel/library/terminal/header.asm"

library_terminal:
    push rax
    push rdx

    mov rax, LIBRARY_FONT_HEIGHT_pixel
    mul qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_byte]
    mov qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_char], rax

    ; compute terminal width in characters
    xor rax, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.width]
    xor edx, edx
    div qword[library_font_width_pixel]
    mov qword[r8 + LIBRARY_TERMINAL_STRUCTURE.width_char], rax

    mov rax, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.height]
    xor edx, edx
    div qword[library_font_height_pixel]
    mov qword[r8 + LIBRARY_TERMINAL_STRUCTURE.height_char], rax

    mov qword[r8 + LIBRARY_TERMINAL_STRUCTURE.lock], STATIC_FALSE

    call library_terminal_clear

    call library_terminal_cursor_enable

    pop rdx
    pop rax

    ret

    macro_debug "library_terminal"

library_terminal_clear:
    push rax
    push rcx
    push rdx
    push rdi

    call library_terminal_color_disable

    mov	eax,	dword [r8 + LIBRARY_TERMINAL_STRUCTURE.background_color]
	mov	rdx,	qword [r8 + LIBRARY_TERMINAL_STRUCTURE.height]
	mov	rdi,	qword [r8 + LIBRARY_TERMINAL_STRUCTURE.address]

.loop:
    push rdi
    mov rcx, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.width]
    rep stosd

    pop rdi

    add rdi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_byte]

    dec rdx
    jnz .loop

    mov qword[r8 + LIBRARY_TERMINAL_STRUCTURE.cursor], STATIC_EMPTY

    call library_terminal_cursor_set

    call library_terminal_cursor_enable

    pop rdi
    pop rdx
    pop rcx
    pop rax

    ret

    macro_debug "library_terminal_clear"

library_terminal_cursor_disable:
    ; put a block on the cursor
    inc qword[r8 + LIBRARY_TERMINAL_STRUCTURE.lock]

    cmp qword[r8 + LIBRARY_TERMINAL_STRUCTURE.lock], STATIC_FALSE
    jne .ready

    ; toggle cursor visibility
    call library_terminal_cursor_switch

.ready:
    ret

    macro_debug "library_terminal_cursor_disable"

library_terminal_cursor_enable:
    cmp qword[r8 + LIBRARY_TERMINAL_STRUCTURE.lock], STATIC_EMPTY
    je .ready

    ; release the lock on the cursor
    dec qword[r8 + LIBRARY_TERMINAL_STRUCTURE.lock]

    cmp qword[r8 + LIBRARY_TERMINAL_STRUCTURE.lock], STATIC_EMPTY
    jne .ready

    call library_terminal_cursor_switch

.ready:
    ret

    macro_debug "library_terminal_cursor_enable"

; pointer to a terminal structure
library_terminal_cursor_width:
    push rax
    push rcx
    push rdi

    mov rax, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_byte]
    
    mov rcx, LIBRARY_FONT_HEIGHT_pixel

    mov rdi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.pointer]

.loop:
    not word[rdi]
    not byte[rdi + STATIC_WORD_SIZE_byte]

    add rdi, rax
    dec rcx
    jnz .loop

.end:
    pop rdi
    pop rcx
    pop rax

    ret
    macro_debug "library_terminal_cursor_switch"


library_terminal_cursor_set:
    push rax
    push rcx
    push rdx

    ; disable cursor
    call library_terminal_cursor_disable
    
    ; calculate cursor position in characters
    mov eax, dword[r8 + LIBRARY_TERMINAL_STRUCTURE.cursor + LIBRARY_TERMINAL_STRUCTURE_CURSOR.y]
    mul qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_char]
    push rax
    mov rax, dword[r8 + LIBRARY_TERMINAL_STRUCTURE.cursor + LIBRARY_TERMINAL_STRUCTURE_CURSOR.x]
    mul qword[library_font_width_byte]
    add qword[rsp], rax
    pop rax

    ; save the new position of the pointer in the memory space of the graphics card
    add rax, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.address]
    mov qword[r8 + LIBRARY_TERMINAL_STRUCTURE.pointer], rax

    call library_terminal_cursor_enable

    pop rdx
    pop rcx
    pop rax

    ret
    macro_debug "library_terinal_cursor_set"

library_terminal_matrix:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r9

    ; compute the offset from the beginning of the font matrix for the character
    mov ebx, dword[library_font_height_pixel]
    mul rbx

    ; set the pointer to the character matrix
    mov rsi, library_font_matrix
    add rsi, rax

    mov r9d, dword[r8 + LIBRARY_TERMINAL_STRUCTURE.foreground_color]

.next:
    ; character matrix width from zero
    mov ecx, LIBRARY_FONT_WIDTH_pixel - 0x01

.loop:
    bt word[rsi], cx
    jnc .continue

    mov dword[rdi], r9d

.continue:
    add rdi, STATIC_DWORD_SIZE_byte

    dec cl
    jns .loop

    ; move the pointer to the next line of the matrix on the screen
    sub rdi, LIBRARY_FONT_WIDTH_pixel << KERNEL_VIDEO_DEPTH_shift
    add rdi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_byte]

    inc rsi

    dec bl
    jnz .next

    pop r9
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax

    ret

    macro_debug "library_terminal_matrix"

library_terminal_empty_char:
    push rax
    push rbx
    push rcx
    push rdx
    push rdi

    mov ebx, LIBRARY_FONT_HEIGHT_pixel

    mov eax, dword[r8 + LIBRARY_TERMINAL_STRUCTURE.background_color]

.next:
    mov cx, LIBRARY_FONT_WIDTH_pixel - 0x01

.loop:
    stosd

.continue:
    dec cl
    jns .loop

    sub rdi, LIBRARY_FONT_WIDTH_puxel << KERNEL_VIDEO_DEPTH_shift
    add rdi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scaanline_byte]
    
    dec bl
    jnz .next

    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rax

    ret
    macro_debug "library_terminal_empty_char"


library_terminal_char:
    pop rax
    pop rbx
    pop rcx
    pop rdx
    pop rdi

    call library_terminal_cursor_enable

    mov ebx, dword[r8 + LIBRARY_TERMINAL_STRUCTURE.cursor + LIBRARY_TERMINAL_STRUCTURE_CURSOR.x]
    mov edx, dword[r8 + LIBRARY_TERMINAL_STRUCTURE.cursor + LIBRARY_TERMINAL_STRUCTURE_CURSOR.y]

    mov rdi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.pointer]

.loop:
    cmp ax, STATIC_SCANCODE_RETURN
    je .return

    cmp ax, STATIC_SCANCODE_NEW_LINE
    je .new_line

    cmp ax, STATIC_SCANCODE_BACKSPACE
    je .backspace

    cmp ax, STATIC_SCANCODE_SPACE
    jb .omit
    cmp ax, STATIC_SCANCODE_TILDE
    ja .omit

    call library_terminal_empty_char

    sub ax, STATIC_SCANCODE_SPACE
    call library_terminal_matrix

    inc ebx

    add rdi, qword[library_font_width_byte]

    cmp ebx, dword[r8 + LIBRARY_TERMINAL_STRUCTURE.width_char]
    jb .continue

    push rax
    push rdx

    mov rax, qword[library_font_width_byte]
    mul rbx
    sub rdi, rax
    add rdi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_char]

    pop rdx
    pop rax

    ; move the cursor to the next line
    xor ebx, ebx
    inc edx

.row:
    ; cursor position outside text mode memory space?
    cmp edx, dword[r8 + LIBRARY_TERMINAL_STRUCTURE.height_char]
    jb .continue

    ; correct the cursor position on the Y axis
    dec edx

    ; correct the indicator
    sub rdi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_char]

    ; scroll the contents of the text mode memory space up one line of text
    call library_terminal_scroll

.continue:
    ; all copies displayed?
    dec rcx
    jnz .loop

    ; save the current cursor position in the text mode memory space
    mov dword[r8 + LIBRARY_TERMINAL_STRUCTURE.cursor + LIBRARY_TERMINAL_STRUCTURE.x], ebx
    mov dword[r8 + LIBRARY_TERMINAL_STRUCTURE.cursor + LIBRARY_TERMINAL_STRUCTURE.x], edx

    mov qword[r8 + LIBRARY_TERMINAL_STRUCTURE.pointer], rdi

.omit:
    call library_terminal_cursor_enable

    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rax

    ret

    macro_debug "library_terminal_char"

.return:
    ; move the pointer and the virtual cursor to the beginning of the current line
    mov dword[r8 + LIBRARY_TERMINAL_STRUCTURE.cursor + LIBRARY_TERMINAL_STRUCTURE_CURSOR.x], STATIC_EMPTY
    call library_terminal_cursor_set

    xor ebx, ebx
    mov rdi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.pointer]

    jmp .continue

    macro_debug "library_terminal_char.return"

.new_line:
    ; keep original records
    push rax
    push rdx

    mov eax, ebx
    mul qword[library_font_width_pixel]
    shl rax, KERNEL_VIDEO_DEPTH_shift
    sub rdi, rax

    ; move the virtual cursor back to the beginning of the line
    xor ebx, ebx

    add rdi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_char]

    pop rdx
    pop rdx

    pop rax

    jmp .row

    macro_debug "library_terminal_char.new_line"

.backspace:
    test ebx, ebx
    jz .begin

    dec ebx
    jmp .clear

.begin:
    test edx, edx
    jz .continue

    ; place the cursor at the end of the current line
    mov ebx, dword[r8 + LIBRARY_TERMINAL_STRUCTURE.width_char]
    dec ebx
    
    dec edx

    push rax
    push rdx

    sub rdi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_char]
    mov rax, qword[library_font_width_byte]
    mul qword[r8 + LIBRARY_TERMINAL_STRUCTURE.width_char]
    add rdi, rax

    pop rdx
    pop rax

.clear:
    sub rdi, LIBRARY_FONT_WIDTH_pixel << KERNEL_VIDEO_DEPTH_shift
    call library_terminal_empty_char

    jmp .continue

    macro_debug "library_terminal_char.backspace"

library_terminal_scroll:
    ; keep original records
    push rbx
    push rcx

    mov ecx, 1

    mov rbx, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.height_char]
    dec rbx

    call library_terminal_scroll_up
    call library_terminal_empty_line

    pop rcx
    pop rbx

    ret

    macro_debug "library_terminal_scroll"

library_terminal_scroll_down:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r9
    
    call library_terminal_color_disable

    mov rdi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.address]
    mov rax, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_char]
    add rcx, rbx
    mul rcx
    add rdi, rax

    ; towards the previous line
    mov rdi, rsi
    sub rsi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_char]

    ; terminal space line size in Bytes
    mov rax, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.width]
    shl rax, KERNEL_VIDEO_DEPTH_shift

    mov r9, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_byte]

.row:
    ; keep pointers of currently processed rows
    push rsi
    push rdi
    
    mov edx, LIBRARY_FONT_HEIGHT_pixel

.line:
    ; move the first line of the current line
    mov rcx, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.width]
    rep movsd

    sub rdi, rax
    add rdi, r9
    sub rsi, rax
    add rsi, r9

    dec edx
    jnz .line

    pop rdi
    pop rsi

    sub rsi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_char]
    sub rdi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_char]

    dec rbx
    jnz .row

    call library_terminal_cursor_enable

    pop r9
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax

    ret
    
    macro_debug "library_terminal_scroll_up"

library_terminal_scroll_up:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r9
    
    call library_terminal_cursor_disable

    mov rsi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.address]
    mov rax, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_char]
    mul rcx
    add rsi, rax

    mov rdi, rsi
    sub rdi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_char]

    ; terminal space line size in Bytes
    mov rax, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.width]
    shl rax, KERNEL_VIDEO_DEPTH_shift

    mov r9, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_byte]

.row:
    mov edx, LIBRARY_FONT_HEIGHT_pixel

.line:
    mov rcx, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.width]
    rep movsd

    sub	rdi,	rax
	add	rdi,	r9
	sub	rsi,	rax
	add	rsi,	r9

    dec	edx
	jnz	.line

    dec	rbx
	jnz	.row

    call	library_terminal_cursor_enable

    pop	r9
	pop	rdi
	pop	rsi
	pop	rdx
	pop	rcx
	pop	rbx
	pop	rax

    ret

    macro_debug "library_terminal_scroll_up"

library_terminal_empty_line:
    push rax
	push rbx
	push rcx
	push rdx
	push rdi

    call	library_terminal_cursor_disable

    mov	rax, qword [r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_char]
	mul	rbx

    mov	rbx, qword [r8 + LIBRARY_TERMINAL_STRUCTURE.width]
	shl	rbx, KERNEL_VIDEO_DEPTH_shift

    mov	edx, LIBRARY_FONT_HEIGHT_pixel

    mov rdi, qword[r8 + LIBRARY_TERMINAL_STRUCTURE.address]
    add rdi, rax

.line:
    mov	eax, dword [r8 + LIBRARY_TERMINAL_STRUCTURE.background_color]
	mov	rcx, qword [r8 + LIBRARY_TERMINAL_STRUCTURE.width]
	rep	stosd

    sub	rdi, rbx
	add	rdi, qword [r8 + LIBRARY_TERMINAL_STRUCTURE.scanline_byte]

    dec	edx
	jnz	.line

    call library_terminal_cursor_enable

    pop	rdi
	pop	rdx
	pop	rcx
	pop	rbx
	pop	rax

    ret

	macro_debug	"library_terminal_empty_line"

library_terminal_string:
    push rax
	push rbx
	push rcx
	push rdx
	push rsi

    call library_terminal_cursor_disable

    test rcx, rcx
	jz .end

    xor eax, eax

.loop:
    lodsb

    test al, al
    jz .end

    push rcx
    mov ecx, 1

    call library_terminal_char

    pop rcx

.continue:
    dec rcx
    jnz .loop

.end:
    call library_terminal_cursor_enable

    pop	rsi
	pop	rdx
	pop	rcx
	pop	rbx
	pop	rax

    ret
    
    macro_debug "library_terminal_string"

library_terminal_number:
    push	rax
	push	rdx
	push	rbp
	push	r9

    call library_terminal_cursor_disable

    and ebx, STATIC_BYTE_mask

    cmp bl, 2
    jb .error
    cmp bl, 36
    ja .error

    movzx r9, dl
    sub r9, 0x30

    xor rdx, rdx

    mov rbp, rsp

.loop:
    div rbx
    push rdx
    dec rcx

    xor rdx, rdx

    test rax, rax
    jnz .loop

    cmp rcx, STATIC_EMPTY
    jle .print

.prefix:
    push r9
    dec rcx
    jnz .prefix

.print:
    ; display each digit
    mov ecx, 0x01
    cmp rsp, rbp
    je .end

    pop rax
    add rax, 0x30

    cmp al, 0x3A
    jb .not
    
    add al, 0x07

.no:
    call	library_terminal_char
    jmp .print

.error:
    stc

.end:
    call library_terminal_cursor_enable
    pop	r9
	pop	rbp
	pop	rdx
	pop	rax
    ret

    macro_debug "library_terminal_number"



