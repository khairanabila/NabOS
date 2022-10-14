%include "kernel/library/bosu/header.asm"
%include "kernel/library/bosu/data.asm"

library_bosu_event:
    push	rax
	push	rsi
	push	rdi
	push	r8
	push	r9

    sub rsp, KERNEL_IPC_STRUCTURE.SIZE

    mov ax, KERNEL_SERVICE_PROCESS_ipc_receive
    mov rdi, rsp
    int KERNEL_SERVICE
    jc .error

    cmp byte[rdi + KERNEL_IPC_STRUCTURE.type], KERNEL_IPC_TYPE_KEYBOARD
    je  .keyboard

    cmp byte[rdi + KERNEL_IPC_STRUCTURE.type], KERNEL_IPC_TYPE_MOUSE
    je .mouse

.error:
    add rsp, KERNEL_IPC_STRUCTURE.SIZE

    stc

    jmp .end

.mouse:
    cmp	byte [rdi + KERNEL_IPC_STRUCTURE.data + KERNEL_IPC_STRUCTURE_DATA_MOUSE.event],	KERNEL_IPC_MOUSE_EVENT_left_press
	jne	.error

    movzx	r8d,	word [rdi + KERNEL_IPC_STRUCTURE.data + KERNEL_IPC_STRUCTURE_DATA_MOUSE.x]	; x
	movzx	r9d,	word [rdi + KERNEL_IPC_STRUCTURE.data + KERNEL_IPC_STRUCTURE_DATA_MOUSE.y]

    macro_library LIBRARY_STRUCTURE_ENTRY.bosu_element
    jc .error

    cmp	qword [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.event],	STATIC_EMPTY
	je	.error

    mov rax .error
    push rax
    push qword[rsi + LIBRARY_BOSU_STRUCTURE_BUTTON_CLOSE.event]
    ret

.keyboard:
    mov dx, word[rdi + KERNEL_IPC_STRUCTURE.data]
    add rsp, KERNEL_IPC_STRUCTURE.SIZE

.end:
    pop	r9
	pop	r8
	pop	rdi
	pop	rsi
	pop	rax
    ret

library_bosu:
    push rax
    push rbx
	push rdi
	push rsi
	push rcx

    test word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.flags],	LIBRARY_BOSU_WINDOW_FLAG_border
	jz	.no_border

    add	word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.width],	LIBRARY_BOSU_WINDOW_BORDER_THICKNESS_pixel << STATIC_MULTIPLE_BY_2_shift
	jc	.end

    add	word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.height],	LIBRARY_BOSU_WINDOW_BORDER_THICKNESS_pixel << STATIC_MULTIPLE_BY_2_shift
	jc	.end

    call library_bosu_border_correction

.no_border:
    movzx	r8d, word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
	movzx	r9d, word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.height]

    mov	r10, r8
	shl	r10, KERNEL_VIDEO_DEPTH_shift
	mov	dword [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.scanline_byte],	r10d

    mov	eax, r10d
	mul	r9d
	mov	dword [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.size],	eax

    test	word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.flags],	LIBRARY_BOSU_WINDOW_FLAG_unregistered
	jnz	.unregistered

    mov	al,	KERNEL_WM_WINDOW_create
	int	KERNEL_WM_IRQ
	jc	.end

    mov qword[rsp], rcx

.unregistered:
    mov	eax, dword [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.color_background]
	mov	ecx, dword [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.size]
	shr	rcx, KERNEL_VIDEO_DEPTH_shift
	mov	rdi, qword [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.address]
	rep	stosd

    test word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.flags],	LIBRARY_BOSU_WINDOW_FLAG_border
	jz	.no_draw_border
    push	r8
	push	r9

    mov	rax,	LIBRARY_BOSU_WINDOW_BORDER_color
    mov	rcx,	r8
	mov	rdi,	qword [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.address]
	rep	stosd

    sub	r8,	(LIBRARY_BOSU_WINDOW_BORDER_THICKNESS_pixel << STATIC_MULTIPLE_BY_2_shift)
	shl	r8,	KERNEL_VIDEO_DEPTH_shift
	sub	r9,	LIBRARY_BOSU_WINDOW_BORDER_THICKNESS_pixel << STATIC_MULTIPLE_BY_2_shift

.draw_border:
    stosd
    
    rol rax, STATIC_REPLACE_EAX_WITH_HIGH_hift

    add rdi, r8

    stosd

	rol	rax,	STATIC_REPLACE_EAX_WITH_HIGH_shift

	dec	r9
	jnz	.draw_border

	rol	rax,	STATIC_REPLACE_EAX_WITH_HIGH_shift

	movzx	ecx,	word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
	rep	stosd

	pop	r9
	pop	r8

.no_draw_border:
	test	word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.flags],	LIBRARY_BOSU_WINDOW_FLAG_header
	jz	.no_header
	call	library_bosu_header_update

.no_header:
	call	library_bosu_elements

.end:
	pop	rcx
	pop	rsi
	pop	rdi
	pop	rbx
	pop	rax

	ret

	macro_debug	"library_bosu"

library_bosu_element_draw:
	push	rax
	push	rcx
	push	rdx

	movzx	eax,	word [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_DRAW.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.y]
	movzx	ecx,	word [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
	mul	rcx
	mov	cx,	word [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_DRAW.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.x]
	add	rax,	rcx
	shl	rax,	KERNEL_VIDEO_DEPTH_shift
	add	rax,	qword [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.address]

	mov	qword [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_DRAW.address],	rax

	pop	rdx
	pop	rcx
	pop	rax
	ret

	macro_debug	"library_bosu_element_draw"

library_bosu_header_set:
	push	rax
	push	rcx
	push	rsi
	push	r8
	push	r9
	push	r10
	push	rdi

	cmp	cl,	LIBRARY_BOSU_WINDOW_NAME_length
	jbe	.ok

	mov	cl,	LIBRARY_BOSU_WINDOW_NAME_length

.ok:
	push	qword [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.length]
	push	rcx

	mov	byte [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.length],	cl

	add	rdi,	LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.name
	rep	movsb

	pop	rcx
	pop	rax

	sub	cl,	al
	jns	.ready
	not	cl
	inc	cl

	mov	al,	STATIC_SCANCODE_SPACE
	rep	stosb

.ready:
	mov	rsi,	qword [rsp]
	movzx	r8d,	word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
	movzx	r9d,	word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.height]
	mov	r10d,	dword [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.scanline_byte]

	call	library_bosu_header_update

	mov	ax,	KERNEL_WM_WINDOW_update
	int	KERNEL_WM_IRQ
	pop	rdi
	pop	r10
	pop	r9
	pop	r8
	pop	rsi
	pop	rcx
	pop	rax
	ret

	macro_debug	"library_bosu_header_set"

library_bosu_clean:
	push	rsi

.loop:
	pop	rsi
	ret

	macro_debug	"library_bosu_clean"

library_bosu_border_correction:
	push	rax
	push	rsi

	add	rsi,	LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.SIZE

.loop:
	mov	al,	byte [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.set]
	cmp	al,	LIBRARY_BOSU_ELEMENT_TYPE_none
	je	.ready

	cmp	al,	LIBRARY_BOSU_ELEMENT_TYPE_button_close
	je	.next

	cmp	al,	LIBRARY_BOSU_ELEMENT_TYPE_button_minimize
	je	.next
	cmp	al,	LIBRARY_BOSU_ELEMENT_TYPE_button_maximize
	je	.next

	cmp	al,	LIBRARY_BOSU_ELEMENT_TYPE_chain
	je	.chain	
	add	word [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.x],	LIBRARY_BOSU_WINDOW_BORDER_THICKNESS_pixel
	add	word [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.y],	LIBRARY_BOSU_WINDOW_BORDER_THICKNESS_pixel

.next:
	movzx	eax,	word [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.size]
	add	rsi,	rax

	jmp	.loop

.chain:
	cmp	word [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_CHAIN.size],	STATIC_EMPTY
	je	.next
	push	rsi
	mov	rsi,	qword [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_CHAIN.address]
	call	library_bosu_border_correction
	pop	rsi
	movzx	eax,	word [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.size]
	add	rsi,	rax

	jmp	.loop

.ready:
	pop	rsi
	pop	rax
	ret

	macro_debug	"library_bosu_border_correction"

library_bosu_close:
	push	rax
	mov	ax,	KERNEL_WM_WINDOW_close
	int	KERNEL_WM_IRQ
	pop	rax
	ret

	macro_debug	"library_bosu_close"

library_bosu_element_button_close:
	push	rax
	push	rcx
	push	rsi
	push	rdi

	mov	rsi,	rdi

	xor	rdi,	rdi

	mov	rax,	r8
	sub	rax,	LIBRARY_BOSU_ELEMENT_BUTTON_CLOSE_width

	test	word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.flags],	LIBRARY_BOSU_WINDOW_FLAG_border
	jz	.no_border	
	sub	rax,	LIBRARY_BOSU_WINDOW_BORDER_THICKNESS_pixel

	add	rdi,	r10

.no_border:
	add	rax,	0x05
	shl	rax,	KERNEL_VIDEO_DEPTH_shift
	add	rdi,	rax
	mov	rax,	r10
	shl	rax,	STATIC_MULTIPLE_BY_4_shift	
	add	rax,	r10	
	add	rdi,	rax	
	add	rdi,	qword [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.address]

	mov	rax,	LIBRARY_BOSU_ELEMENT_BUTTON_FOREGROUND_color
	mov	ecx,	0x08

.left:
	stosd
	add	rdi,	r10
	dec	rcx
	jnz	.left
	sub	rdi,	0x08 << KERNEL_VIDEO_DEPTH_shift
	mov	ecx,	0x08

.right:
	sub	rdi,	r10

	stosd

	dec	rcx
	jnz	.right

	pop	rdi
	pop	rsi
	pop	rcx
	pop	rax

	ret

	macro_debug	"library_bosu_element_button_close"

library_bosu_element_button_minimize:
	xchg	bx,bx

	ret

	macro_debug	"library_bosu_element_button_minimize"

library_bosu_element_button_maximize:
	xchg	bx,bx
	ret

	macro_debug	"library_bosu_element_button_maximize"

library_bosu_elements_specification:
	push	rax
	push	rbx
	push	rsi
	xor	r8,	r8
	xor	r9,	r9
	add	rsi,	LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.SIZE

.loop:
	cmp	byte [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.set],	LIBRARY_BOSU_ELEMENT_TYPE_none
	je	.end
	cmp	byte [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.set],	LIBRARY_BOSU_ELEMENT_TYPE_chain
	je	.next
	movzx	eax,	word [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.x]
	movzx	ebx,	word [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
	add	eax,	ebx
	cmp	rax,	r8
	jbe	.y
	mov	r8,	rax

.y:
	movzx	eax,	word [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.y]
	movzx	ebx,	word [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.height]
	add	eax,	ebx
	cmp	rax,	r9
	jbe	.next
	mov	r9,	rax

.next:
	movzx	eax,	word [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.size]
	add	rsi,	rax
	jmp	.loop

.end:
	pop	rsi
	pop	rbx
	pop	rax
	ret

	macro_debug	"library_bosu_elements_specification"

library_bosu_elements:
	push	rax
	push	rbx
	push	rcx
	push	rsi
	mov	rbx,	library_bosu_element_entry
	mov	rdi,	rsi

	add	rsi,	LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.SIZE

.loop:
	movzx	eax,	byte [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.set]
	cmp	al,	LIBRARY_BOSU_ELEMENT_TYPE_none
	je	.ready
	cmp	al,	LIBRARY_BOSU_ELEMENT_TYPE_chain
	jne	.other
	cmp	word [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_CHAIN.size],	STATIC_EMPTY
	je	.empty
	push	rsi

	mov	rsi,	qword [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_CHAIN.address]
	call	library_bosu_elements

	pop	rsi

.empty:
	add	rsi,	LIBRARY_BOSU_STRUCTURE_ELEMENT_CHAIN.SIZE

	jmp	.loop

.other:
	call	qword [rbx + rax * STATIC_QWORD_SIZE_byte]

.leave:
	movzx	eax,	word [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.size]
	add	rsi,	rax
	jmp	.loop

.ready:
	pop	rsi
	pop	rcx
	pop	rbx
	pop	rax

	ret

	macro_debug	"library_bosu_elements"

library_bosu_element_taskbar:
	push	rax
	push	rbx
	push	rcx
	push	rdx
	push	rsi
	push	rdi
	push	r8
	push	r9
	push	r10
	push	r11
	push	r12
	push	r13

	movzx	r8d,	word [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
	movzx	r9d,	word [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.height]
	mov	r10d,	dword [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.scanline_byte]

	movzx	r11d,	word [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
	movzx	r12d,	word [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.height]
	mov	r13,	r11
	shl	r13,	KERNEL_VIDEO_DEPTH_shift

	mov	rbx,	rdi

	movzx	eax,	word [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.y]
	mul	r13	
	movzx	edi,	word [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.x]
	shl	rdi,	KERNEL_VIDEO_DEPTH_shift
	add	rdi,	rax
	add	rdi,	qword [rbx + LIBRARY_BOSU_STRUCTURE_WINDOW.address]

	mov	eax,	dword [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.color_background]
	call	library_bosu_element_drain

	movzx	rcx,	byte [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.length]

	mov	rax,	r12
	sub	rax,	LIBRARY_FONT_HEIGHT_pixel
	shr	rax,	STATIC_DIVIDE_BY_2_shift
	mul	r10
	add	rdi,	rax

	mov	ebx,	LIBRARY_BOSU_ELEMENT_TASKBAR_FG_color
	movzx	ecx,	byte [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.length]
	add	rsi,	LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.string
	add	rdi,	LIBRARY_BOSU_ELEMENT_TASKBAR_PADDING_LEFT_pixel << KERNEL_VIDEO_DEPTH_shift
	call	library_bosu_string

	pop	r13
	pop	r12
	pop	r11
	pop	r10
	pop	r9
	pop	r8
	pop	rdi
	pop	rsi
	pop	rdx
	pop	rcx
	pop	rbx
	pop	rax

	ret

	macro_debug	"library_bosu_element_taskbar"

library_bosu_element_chain:
	push	rax
	push	rbx
	push	rsi
	push	r8
	push	r9
	push	r10

	movzx	r8d,	word [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
	movzx	r9d,	word [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.height]
	mov	r10d,	dword [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.scanline_byte]

	mov	rbx,	library_bosu_element_entry

	mov	rsi,	qword [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_CHAIN.address]

.loop:
	movzx	eax,	byte [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.set]
	cmp	al,	LIBRARY_BOSU_ELEMENT_TYPE_none
	je	.ready
	call	qword [rbx + rax * STATIC_QWORD_SIZE_byte]

.leave:
	movzx	eax,	word [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.size]
	add	rsi,	rax
	jmp	.loop

.ready:
	pop	r10
	pop	r9
	pop	r8
	pop	rsi
	pop	rbx
	pop	rax

	ret

	macro_debug	"library_bosu_element_chain"

library_bosu_header_update:
	push	rax
	push	rbx
	push	rcx
	push	rdx
	push	r11
	push	r12
	push	r13
	push	r15
	push	rdi
	push	rsi

	mov	r11,	r8

	test	word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.flags],	LIBRARY_BOSU_WINDOW_FLAG_border
	jz	.no_border

	sub	r11,	LIBRARY_BOSU_WINDOW_BORDER_THICKNESS_pixel << STATIC_MULTIPLE_BY_2_shift

.no_border:
	test	word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.flags],	LIBRARY_BOSU_WINDOW_FLAG_BUTTON_close
	jz	.no_close

	sub	r11,	LIBRARY_BOSU_ELEMENT_BUTTON_CLOSE_width

.no_close:
	mov	r12,	LIBRARY_BOSU_HEADER_HEIGHT_pixel
	mov	r13,	r11
	shl	r13,	KERNEL_VIDEO_DEPTH_shift

	mov	rdi,	qword [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.address]

	mov	rax,	LIBRARY_BOSU_WINDOW_BORDER_THICKNESS_pixel
	mul	r10	
	add	rdi,	rax

	mov	rax,	LIBRARY_BOSU_WINDOW_BORDER_THICKNESS_pixel
	shl	rax,	KERNEL_VIDEO_DEPTH_shift
	add	rdi,	rax

	mov	eax,	LIBRARY_BOSU_HEADER_BACKGROUND_color
	call	library_bosu_element_drain

	mov	rax,	r12
	sub	rax,	LIBRARY_FONT_HEIGHT_pixel
	shr	rax,	STATIC_DIVIDE_BY_2_shift
	mul	r10
	add	rdi,	rax

	mov	ebx,	LIBRARY_BOSU_HEADER_FOREGROUND_color
	movzx	rcx,	byte [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.length]
	add	rsi,	LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.name
	add	rdi,	LIBRARY_BOSU_HEADER_PADDING_LEFT_pixel << KERNEL_VIDEO_DEPTH_shift
	call	library_bosu_string
	pop	rsi
	pop	rdi
	pop	r15
	pop	r13
	pop	r12
	pop	r11
	pop	rdx
	pop	rcx
	pop	rbx
	pop	rax

	ret

	macro_debug	"library_bosu_header_update"

ibrary_bosu_string:
	; zachowaj oryginalne rejestry
	push	rax
	push	rdi
	push	r9
	push	r13

	; ciąg pusty?
	test	rcx,	rcx
	jz	.end	; tak

	; wyczyść akumulator
	xor	rax,	rax

.loop:
	; pobierz znak z ciągu
	lodsb

	; wyświetl znak
	call	library_bosu_char

	; przesuń wskaźnik na następną pozycję w przestrzeni elementu
	add	rdi,	LIBRARY_FONT_WIDTH_pixel << KERNEL_VIDEO_DEPTH_shift

	; koniec ciągu?
	dec	rcx
	jz	.end	; nie, wyświetl następny

	; koniec przestrzeni elementu?
	sub	r11,	LIBRARY_FONT_WIDTH_pixel
	jns	.loop	; nie, zmieścimy jeszcze jeden znak

.end:
	; przywróć oryginalne rejestry
	pop	r13
	pop	r9
	pop	rdi
	pop	rax

	; powrót z procedury
	ret

	macro_debug	"library_bosu_string"

;===============================================================================
; wejście:
;	rax - kod ASCII znaku do wyświetlenia
;	rbx - kolor czcionki
;	rdi - wskaźnik do początku przestrzeni elementu
;	r8 - szerokość przestrzeni okna w pikselach
;	r9 - wysokość przestrzeni okna w pikselach
;	r10 - scanline okna w Bajtach
;	r11 - szerokość przestrzeni elementu w pikselach
;	r12 - wysokość przestrzeni elementu w pikselach
;	r13 - scanline elementu w Bajtach
library_bosu_char:
	; zachowaj oryginalne rejestry
	push	rax
	push	rcx
	push	rdx
	push	rsi
	push	rdi
	push	r12
	push	r11
	mov	rsi,	library_font_matrix
	sub	al,	LIBRARY_FONT_MATRIX_offset
	js	.end
	
	mul	qword [library_font_height_pixel]
	add	rsi,	rax

	mov	eax,	ebx
	mov	rdx,	qword [library_font_height_pixel]

.next:
	mov	r11,	qword [rsp]
	mov	rcx,	qword [library_font_width_pixel]
	dec	rcx

.loop:
	bt	word [rsi],	cx
	jnc	.omit
	stosd

	jmp	.continue

.omit:
	add	rdi,	KERNEL_VIDEO_DEPTH_byte

.continue:
	dec	r11
	jnz	.continue_pixels
	shl	rcx,	KERNEL_VIDEO_DEPTH_shift
	add	rdi,	rcx
	jmp	.end_of_line

.continue_pixels:
	dec	rcx
	jns	.loop

.end_of_line:
	sub	rdi,	LIBRARY_FONT_WIDTH_pixel << KERNEL_VIDEO_DEPTH_shift
	add	rdi,	r10
	inc	rsi
	dec	r12
	jz	.end

.line_invisible:
	dec	rdx
	jnz	.next

.end:
	pop	r11
	pop	r12
	pop	rdi
	pop	rsi
	pop	rdx
	pop	rcx
	pop	rax

	ret

	macro_debug	"library_bosu_char"

library_bosu_element_button:
	push	rax
	push	rbx
	push	rcx
	push	rdx
	push	rsi
	push	rdi
	push	r8
	push	r9
	push	r10
	push	r11
	push	r12
	push	r13
	movzx	r8d,	word [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
	movzx	r9d,	word [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.height]
	mov	r10d,	dword [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.scanline_byte]

	movzx	r11d,	word [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_BUTTON.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
	movzx	r12d,	word [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_BUTTON.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.height]
	mov	r13,	r11
	shl	r13,	KERNEL_VIDEO_DEPTH_shift
	mov	rbx,	rdi
	movzx	eax,	word [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_BUTTON.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.y]
	mul	r10	; * scanline
	movzx	edi,	word [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_BUTTON.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.x]
	shl	rdi,	KERNEL_VIDEO_DEPTH_shift
	add	rdi,	rax
	add	rdi,	qword [rbx + LIBRARY_BOSU_STRUCTURE_WINDOW.address]
	mov	eax,	LIBRARY_BOSU_ELEMENT_BUTTON_BACKGROUND_color
	call	library_bosu_element_drain
	movzx	rcx,	byte [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.length]

	mov	rax,	r12
	sub	rax,	LIBRARY_FONT_HEIGHT_pixel
	shr	rax,	STATIC_DIVIDE_BY_2_shift
	mul	r10
	add	rdi,	rax
	movzx	eax,	byte [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_BUTTON.length]
	mul	qword [library_font_width_pixel]
	cmp	rax,	r11
	ja	.aligned
	shr	rax,	STATIC_DIVIDE_BY_2_shift

	mov	rdx,	r11
	shr	rdx,	STATIC_DIVIDE_BY_2_shift
	sub	rdx,	rax

	shl	rdx,	KERNEL_VIDEO_DEPTH_shift
	add	rdi,	rdx

.aligned:
	mov	ebx,	LIBRARY_BOSU_ELEMENT_BUTTON_FOREGROUND_color
	movzx	ecx,	byte [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_BUTTON.length]
	add	rsi,	LIBRARY_BOSU_STRUCTURE_ELEMENT_BUTTON.string
	call	library_bosu_string

	pop	r13
	pop	r12
	pop	r11
	pop	r10
	pop	r9
	pop	r8
	pop	rdi
	pop	rsi
	pop	rdx
	pop	rcx
	pop	rbx
	pop	rax
	ret

	macro_debug	"library_bosu_element_button"

library_bosu_element_drain:
	push	rcx
	push	rdx
	push	rdi
	push	r12

.loop:
	mov	rcx,	r11
	rep	stosd
	sub	rdi,	r13	
	add	rdi,	r10	

	dec	r12
	jnz	.loop
	pop	r12
	pop	rdi
	pop	rdx
	pop	rcx
	ret

	macro_debug	"library_bosu_element_drain"

library_bosu_element_label:
	push	rax
	push	rbx
	push	rcx
	push	rdx
	push	rsi
	push	rdi
	push	r8
	push	r9
	push	r10
	push	r11
	push	r12
	push	r13
	movzx	r8d,	word [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
	movzx	r9d,	word [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.height]
	mov	r10d,	dword [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.scanline_byte]
	movzx	r11d,	word [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
	movzx	r12d,	word [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.height]
	mov	r13,	r11
	shl	r13,	KERNEL_VIDEO_DEPTH_shift

	mov	rbx,	rdi
	movzx	eax,	word [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.y]
	mul	r10
	movzx	edi,	word [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.x]
	shl	rdi,	KERNEL_VIDEO_DEPTH_shift
	add	rdi,	rax
	add	rdi,	qword [rbx + LIBRARY_BOSU_STRUCTURE_WINDOW.address]
	mov	eax,	dword [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.color_background]
	call	library_bosu_element_drain
	movzx	rcx,	byte [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.length]
	mov	rax,	r12
	sub	rax,	LIBRARY_FONT_HEIGHT_pixel
	shr	rax,	STATIC_DIVIDE_BY_2_shift
	mul	r10
	add	rdi,	rax
	test	byte [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.flags],	LIBRARY_BOSU_ELEMENT_LABEL_FLAG_ALIGN_center
	jz	.no_center
	movzx	eax,	byte [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_BUTTON.length]
	mul	qword [library_font_width_pixel]
	cmp	rax,	r11
	ja	.aligned
	shr	rax,	STATIC_DIVIDE_BY_2_shift

	mov	rdx,	r11
	shr	rdx,	STATIC_DIVIDE_BY_2_shift
	sub	rdx,	rax

	shl	rdx,	KERNEL_VIDEO_DEPTH_shift
	add	rdi,	rdx

.no_center:
	test	byte [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.flags],	LIBRARY_BOSU_ELEMENT_LABEL_FLAG_ALIGN_right
	jz	.aligned
	movzx	eax,	byte [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_BUTTON.length]
	mul	qword [library_font_width_pixel]
	cmp	rax,	r11
	ja	.aligned
	mov	rdx,	r11
	sub	rdx,	rax
	shl	rdx,	KERNEL_VIDEO_DEPTH_shift
	add	rdi,	rdx

.aligned:
	mov	ebx,	dword [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.color_foreground]
	movzx	ecx,	byte [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.length]
	add	rsi,	LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.string
	call	library_bosu_string
	pop	r13
	pop	r12
	pop	r11
	pop	r10
	pop	r9
	pop	r8
	pop	rdi
	pop	rsi
	pop	rdx
	pop	rcx
	pop	rbx
	pop	rax
	ret

	macro_debug	"library_bosu_element_label"

library_bosu_element:
	push	rdi
	push	rsi

	mov	rdi,	rsi
	add	rsi,	LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.SIZE
	call	library_bosu_element_subroutine
	jc	.end
	mov	qword [rsp],	rsi

.end:
	pop	rsi
	pop	rdi

	ret

	macro_debug	"library_bosu_element"
library_bosu_element_subroutine:
	push	rax
	push	rbx
	push	rcx
	push	r8
	push	r9
	push	rsi

.loop:
	cmp	byte [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.set],	LIBRARY_BOSU_ELEMENT_TYPE_none
	je	.error
	movzx	ecx,	word [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.size]

	cmp	byte [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.set],	LIBRARY_BOSU_ELEMENT_TYPE_chain
	jne	.no_chain

	push	rsi


	mov	rsi,	qword [rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_CHAIN.address]
	call	library_bosu_element_subroutine
	jnc	.found
	pop	rsi
	jmp	.next_from_chain

.found:
	mov	qword [rsp + STATIC_QWORD_SIZE_byte],	rsi

	pop	rsi
	jmp	.end

.no_chain:
	push	rcx
	cmp	byte [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.set],	LIBRARY_BOSU_ELEMENT_TYPE_button_close
	jne	.no_button_close
	movzx	eax,	word [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
	sub	rax,	LIBRARY_BOSU_ELEMENT_BUTTON_CLOSE_width

	xor	ecx,	ecx
	test	word [rdi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.flags],	LIBRARY_BOSU_WINDOW_FLAG_border
	jz	.no_button_close_border	
	add	rax,	LIBRARY_BOSU_WINDOW_BORDER_THICKNESS_pixel
	add	rcx,	LIBRARY_BOSU_WINDOW_BORDER_THICKNESS_pixel

.no_button_close_border:
	cmp	r8,	rax
	jl	.next
	add	rax,	LIBRARY_BOSU_ELEMENT_BUTTON_CLOSE_width
	cmp	r8,	rax
	jge	.next

	cmp	r9,	rcx
	jl	.next
	add	rcx,	LIBRARY_BOSU_ELEMENT_BUTTON_CLOSE_width
	cmp	r9,	rcx
	jge	.next
	jmp	.element_recognized

.no_button_close:
	movzx	eax,	word [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.x]
	cmp	r8,	rax
	jl	.next
	movzx	ebx,	word [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
	add	rax,	rbx
	cmp	r8,	rax
	jge	.next
	movzx	rax,	word [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.y]
	cmp	r9,	rax
	jl	.next
	movzx	ebx,	word [rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.height]
	add	rax,	rbx
	cmp	r9,	rax
	jge	.next

.element_recognized:
	add	rsp,	STATIC_QWORD_SIZE_byte
	clc
	mov	qword [rsp],	rsi
	jmp	.end

.next:
	pop	rcx

.next_from_chain:
	add	rsi,	rcx
	jmp	.loop

.error:
	stc

.end:
	pop	rsi
	pop	r9
	pop	r8
	pop	rcx
	pop	rbx
	pop	rax

	ret

	macro_debug	"library_bosu_element_subroutine"