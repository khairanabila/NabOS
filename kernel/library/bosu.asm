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