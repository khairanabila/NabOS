kernel_gui_ipc_wm:
    cmp byte[rdi + KERNEL_IPC_STRUCTURE.type], KERNEL_IPC_TYPE_MOUSE
    jne .end

    mov	rax, qword [rdi + KERNEL_IPC_STRUCTURE.data + KERNEL_IPC_STRUCTURE_DATA_MOUSE.object_id]
	mov	r8w, word [rdi + KERNEL_IPC_STRUCTURE.data + KERNEL_IPC_STRUCTURE_DATA_MOUSE.x]
	mov	r9w,word [rdi + KERNEL_IPC_STRUCTURE.data + KERNEL_IPC_STRUCTURE_DATA_MOUSE.y]

    cmp	byte [rdi + KERNEL_IPC_STRUCTURE.data + KERNEL_IPC_STRUCTURE_DATA_MOUSE.event],	KERNEL_IPC_MOUSE_EVENT_right_press
    je .right_mouse_button

    cmp	rax,	qword [kernel_gui_window_menu + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.id]
    jne .left_mouse_button_no_menu

    test	word [kernel_gui_window_menu + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.flags],	LIBRARY_BOSU_WINDOW_FLAG_visible
    jz .end

    and	word [kernel_gui_window_menu + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.flags],	~LIBRARY_BOSU_WINDOW_FLAG_visible

    mov rsi, kernel_gui_window_menu
    macro_library LIBRARY_STRUCTURE_ENTRY.bosu_element
    jc .end

    cmp qword[rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.event], STATIC_EMPTY
    jc .end

    push .end
    push qword[rsi + LIBRARY_BOSU_STRUCTURE_TYPE.SIZE + LIBRARY_BOSU_STRUCTURE_ELEMENT.event]
    ret

.left_mouse_button_no_menu:
    cmp	rax, qword [kernel_gui_window_taskbar + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.id]
    je .end

    cmp	rax, qword [kernel_gui_window_workbench + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.id]
	jne	.end

    mov rbx, qword[kernel_gui_window_menu + LIBRARY_BOSU_STRUVTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_EXTRA.id]
    call kernel_wm_object_by_id

    mov ax, r8w
    add ax, word[rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
    cmp	ax,	word [kernel_gui_window_workbench + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]
    jl .y

    sub r8w, word[rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.width]

.y:
    mov	ax,	r9w
	add	ax,	word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.height]
	cmp	ax,	word [kernel_gui_window_taskbar + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.y]
	jl .visible

    jl	.LIBRARY_BOSU_WINDOW_FLAG_visible
    mov	r9w,	word [kernel_gui_window_taskbar + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.y]
	sub	r9w,	word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.height]
	dec	r9w

.visible:
    mov	word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.x], r8w
	mov	word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.field + LIBRARY_BOSU_STRUCTURE_FIELD.y], r9w

    or	word [rsi + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.flags],	LIBRARY_BOSU_WINDOW_FLAG_visible | LIBRARY_BOSU_WINDOW_FLAG_flush
    or	word [kernel_gui_window_menu + LIBRARY_BOSU_STRUCTURE_WINDOW.SIZE + LIBRARY_BOSU_STRUCTURE_WINDOW_EXTRA.flags],	LIBRARY_BOSU_WINDOW_FLAG_visible | LIBRARY_BOSU_WINDOW_FLAG_flush

.end:
    ret

    macro_debug "kernel_gui_ipc_wm"