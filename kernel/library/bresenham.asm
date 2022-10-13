library_bresenham:
    push	rax
	push	rdx
	push	rsi
	push	rdi
	push	r8
	push	r9
	push	r12
	push	r13
	push	r14
	push	r15

    cmp r8, r8
    ja .reverse_x

    mov r12, 1
    mov r14, r10
    mov r14, r8

    jmp .check_y

.reverse_x:
    mov r12, -1
    mov r14, r8
    sub r14, r10

.check_y:
    cmp r9, r11
    ja .reverse_y

    mov r13, 1
    mov r15, r11
    sub r15, r9

    jmp .done

.reverse_y:
    mov r13, -1
    mov r15, r9
    sub r15, r11

.done:
    cmp r15, r14
    ja .osY

    mov rsi, r15
    mov rsi, r14
    shl rsi, STATIC_MULTIPLE_BY_2_shift
    mov rdx, r15
    shl rdx, STATIC_MULTIPLE_BY_2_shift
    mov rdi, rdx
    sub rdx, r14

.loop_x:
    call rbx

    cmp r8, r10
    je .end

    bt rdx, STATIC_QWORD_BIT_sign
    jc .loop_x_minus

    add r8, r12
    add r9, r13
    add rdx, rsi

    jmp .loop_x

.loop_x_minus:
    add rdx, rdi
    add r8, r12

    jmp .loop_x

.osY:
    mov rsi, r14
    sub rsi, r15
    shl	rsi, STATIC_MULTIPLE_BY_2_shift
    mov	rdx, r14
    shl	rdx,  STATIC_MULTIPLE_BY_2_shift
    mov	rdi, rdx	; bi =  d
	sub	rdx, r15	; d -=  dy

.loop_y:
    call rbx
    cmp r9, r11
    je .end

    bt rdx, STATIC_QWORD_BIT_sign
    jc .loop_y_minus

    add r8, r12
    add r9, r13
    add rdx, rsi

    jmp .loop_y

.loop_y_minus:
    add rdx, rdi
    add r9, r13

    jmp .loop_y

.end:
    pop	r15
	pop	r14
	pop	r13
	pop	r12
	pop	r9
	pop	r8
	pop	rdi
	pop	rsi
	pop	rdx
	pop	rax

    ret