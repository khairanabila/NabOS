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
    call .remove
    mov byte[kernel_wm_object_semaphore], STATIC_FALSE

.end:
    pop rdi
    pop rsi
    pop rcx
    pop rax

    ret

    macro_debug "kernel_gui_taksbar_reload"
