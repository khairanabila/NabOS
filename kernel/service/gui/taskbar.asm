kernel_gui_taskbar_reload:
    push rax
    push rcx
    push rsi
    push rdi

    mov rax, qword[kernel_wm_object_list_modify_time]
    cmp qword[kernel-gui_window_taskbar_modify_time], rax
    je .end

    macro_lock kernel_wm_object_semaphore, 0

    mov rcx, qword[kernel_gui_pid]

    mov rsi, qword[kernel_wm_object_list_address]
    mov rdi, qword[kernel_gui_taskbar_list_addrss]

.loop:
    lodsq
    test rax, rax
    jz .registered

    cmp qword[rax + KERNEL_WM_STRUCTURE_OBJECT.SIZE + KERNEL_WM_STRUCTURE_OBJECT_EXTRA.pid], rcx
    je .loop

    call .insert

    jmp .loop

.insert:
    push rcx
    push rdi

    mov rax, qword[rax + KERNEL_WM_STRUCTURE_OBJECT.SIZE + KERNEL_WM_STRUCTURE_OBJECT_EXTRA.id]

    mov rcx, qword[kernel_gui_taskbar_list_count]
    test rcx, rcx
    jz .insert_new

.insert_loop:
    cmp rax, qword[rdi]
    je .insert_end

    add rdi, STATIC_QWORD_SIZE_byte
    
    dec rcx
    jnz .insert_loop

.insert_loop:
    stosq

    inc qword[kernel_gui_taskbar_list_count]

.insert_end:
    pop rdi
    pop rcx
    ret

.remove:
    push rbx
    mov rcx, qword[kernel_gui_taksbar_list_count]
    mov rdi, qword[kernel_gui_taskbar_list_address]

.remove_loop:
    test rcx, rcx
    jz .remove_end

    mov rbx, qword[rdi]
    call kernel_wm_object_by_id
    jnc .remove_next

    push rcx
    push rdi

    mov rsi, rdi
    add rsi, STATIC_QWORD_SIZE_byte
    rep movsq

    pop rdi
    pop rcx

    dec qword[kernel_gui_taskbar_list_count]

    jmp .remove_step_by

.remove_next:
    add rdi, STATIC_QWORD_SIZE_byte

.remove_step_by:
    dec rcx
    jnz .remove_loop

.remove_end:
    pop rbx
    ret

.registered:
    ; release all entries with nonexistent identifiers
    call .remove
    mov byte[kernel_wm_object_semaphore], STATIC_FALSE

.end:
    pop rdi
    pop rsi
    pop rcx
    pop rax

    ret

    macro_debug "kernel_gui_taksbar_reload"

kernel_gui_taskbar_event:
    push rbx
    push rsi

    cmp byte[rdi + KERNEL_IPC_STRUCTURE.data + KERNEL_IPC_STRUCTURE_DATA_MOUSE.event], KERNEL_IPC_MOUSE_EVENT_left_press
    jne .end

    mov  rsi, kernel_gui_window_taskbar
    macro_library LIBRARY_STRUCTURE_ENTRY.bosu_element
    
    mov rbx, qword[rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.event]
    call kernel_wm_object_by_id

    xor word[rsi + KERNEL_WM_STRUCTURE_OBJECT.SIZE + KERNEL_WM_STRUCTURE_OBJECT_EXTRA.flags], KERNEL_WM_FLAG_visible
    
    or word[rsi + KERNEL_WM_STRUCTURE_OBJECT.SIZE + KERNEL_WM_STRUCTURE_OBJECT_EXTRA.flags], KERNEL_WM_OBJECT_FLAG_undraw
    mov qword[kernel_gui_window_taskbar_modify_time], STATIC_EMPTY

.end:
    pop rsi
    pop rbx
    ret

    macro_debug "kernel_gui_taskbar_event"

kernel_gui_taskbar:
    push rax
    push rbx
    push rcx
	push rdx
	push rsi
	push rdi
	push r8

    call kernel_gui_taskbar_reload

    mov rax, qword[kernel_wm_object_list_modify_time]
    cmp qword[kernel_gui_window_taskbar_modify_time], rax
    je .end

    macro_lock kernel_wm_object_semaphore, 0

    mov eax, LIBRARY_BOSU_STRUCTURE_TASKBAR.SIZE + LIBRARY_BOSU_WINDOW_length
    mov rcx, qword[kernel_gui_taskbar_list_count]
    inc rcx
    mul rcx

    push rax
    mov rcx, qword[kernel_gui_window_taskbar.element_chain_0 + LIBRARY_BOSU_STRUCTURE_ELEMENT_CHAIN.size]

    shl rcx, STATIC_PAGE_SHIFT_shift
    cmp rax, rcx
    jbe .enough

    test rcx, rcx
    jz .new

    mov rdi, qword[kernel_gui_window_taskbar.element_chain_0 + LIBRARY_BOSU_STRUCTURE_ELEMENT_CHAIN.address]
    call kernel_memory_release

.new:
    mov rcx, rax
    call library_page_from_size
    call kernel_memory_alloc

    mov qword[kernel_gui_window_taskbar.element_chain_0 + LIBRARY_BOSU_STRUCTURE_ELEMENT_CHAIN.address], rdi

.enough:
    mov rdi, qword[kernel_gui_window_taskbar.element_chain_0 + LIBRARY_BOSU_STRUCTURE_ELEMENT_CHAIN.address]

    movzx, word[kernel_gui_window_taskbar + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
    sub	ax,	word [kernel_gui_window_taskbar.element_label_clock + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
    mov rcx, qword[kernel_gui_taskbar_list_count]
    xor edx, edx

    test  rcx, rcx
    jz .max

    div rcx

.max:
    mov bx, ax
    sub bx, KERNEL_GUI_WINDOW_TASKBAR_MARGIN_left

    xor edx, edx
    
    mov r8, qword[kernel_gui_taskbar_list_address]
    
    test rcx, rcx
    jz .STATIC_EMPTY

.loop:
    cmp qword[r8], STATIC_EMPTY
    je  .ready

    push rbx
    mov rbx, qword[r8]
    call kernel_wm_object_by_id
    pop rbx
    
    push rdi

    mov	byte [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.type + LIBRARY_BOSU_STRUCTURE_TYPE.set],	LIBRARY_BOSU_ELEMENT_TYPE_taskbar
	mov	word [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.size],	LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.SIZE
	mov	word [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.x],	dx
	mov	word [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.y],	STATIC_EMPTY
	mov	word [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.width],	bx
	mov	word [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.height],	KERNEL_GUI_WINDOW_TASKBAR_HEIGHT_pixel

    mov rax, qword[rsi + KERNEL_WM_STRUCTURE_OBJECT.SIZE + KERNEL_WM_STRUCTURE_OBJECT_EXTRA.id]
    mov qword[rsi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.event], raw

    movzx ecx, byte[rsi + KERNEL_WM_STRUCTURE_OBJECT.SIZE + KERNEL_WM_STRUCTURE_OBJECT_EXTRA.length]
    mov byte[rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.length], cl
    add word[rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.size], cx
    
    mov	dword [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.color_foreground],	LIBRARY_BOSU_ELEMENT_TASKBAR_FG_color
	mov	dword [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.color_background],	LIBRARY_BOSU_ELEMENT_TASKBAR_BG_color
    
    test word[rsi + KERNEL_WM_STRUCTURE_OBJECT.SIZE + KERNEL_WM_STRUCTURE_OBJECT_EXTRA.flags], KERNEL_WM_OBJECT_FLAG_visible
    jnz .visible

    mov	dword [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.color_background],	LIBRARY_BOSU_ELEMENT_TASKBAR_BG_HIDDEN_color

.visible:
    add rsi, KERNEL_WM_STRUCTURE_OBJECT.SIZE + KERNEL_WM_STRUCTURE_OBJECT_EXTRA.name
    add rdi, LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.string
    rep movsb

    pop rdi

    movzx eax, word[rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_TASKBAR.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.size]
    add rdi, rax

    add rdx, rbx
    push rbx

    mov rbx, KERNEL_GUI_WINDOW_TASKBAR_MARGIN_right
    call kernel_gui_taskbar_margin

    pop rbx

.next:
    add r8, STATIC_QWORD_SIZE_byte
    jmp .loop

.empty:
    add rbx, KERNEL_GUI_WINDOW_TASKBAR_MARGIN_right
    call kernel_gui_taskbar_margin

.ready:
    pop rax
    mov word[kernel_gui_window_taskbar.element_chain_0 + LIBRARY_BOSU_STRUCTURE_ELEMENT_CHAIN.size], ax

    mov byte[rdi + LIBRARY_BOSU_STRUCTURE_TPYE.set], LIBRARY_BOSU_ELEMENT_TYPE.none
    
    mov byte[kernel_wm_object_semaphore], STATIC_FALSE

    mov rsi, kernel_gui_window_taskbar.element_chain_0
    mov rdi, kernel_gui_window_taskbar
    macro_library LIBRARY_STRUCTURE_ETNRY

    mov al, KERNEL_WM_WINDOW_update
    mov rsi, kernel_gui_window_taskbar
    int KERNEL_WM_IRQ

    mov rax, qword[kernel_wm_object_list_modify_time]
    mov qword[kernel_gui_window_taskbar_modify_time], rax

.end:
    pop	r8
	pop	rdi
	pop	rsi
	pop	rdx
	pop	rcx
	pop	rbx
	pop	rax
    
    ret
    macro_debug "kernel_gui_taskbar"

kernel_gui_taskbar_margin:
    mov	byte [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.type + LIBRARY_BOSU_STRUCTURE_TYPE.set],	LIBRARY_BOSU_ELEMENT_TYPE_label
	mov	word [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.size],	LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.SIZE
	mov	word [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.x],	dx
	mov	word [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.y],	STATIC_EMPTY
	mov	word [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.width],	bx
	mov	word [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.field + LIBRARY_BOSU_STRUCTURE_FIELD.height],	KERNEL_GUI_WINDOW_TASKBAR_HEIGHT_pixel
	mov	qword [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.event],	STATIC_EMPTY

    mov	byte [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.length],	0x01
	mov	byte [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.string],	STATIC_SCANCODE_SPACE
	add	word [rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.element + LIBRARY_BOSU_STRUCTURE_ELEMENT.size], 0x01

    add dx, bx

    movzx eax, word[rdi + LIBRARY_BOSU_STRUCTURE_ELEMENT_LABEL.element + LIBRARY_STRUCTURE_ELEMENT.size]
    add rdi, rax

    ret
