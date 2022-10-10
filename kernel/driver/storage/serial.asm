DRIVER_SERIAL_PORT_COM1				equ	0x03F8
DRIVER_SERIAL_PORT_COM2				equ	0x02F8

struc	DRIVER_SERIAL_STRUCTURE_REGISTERS
	.data_or_divisor_low			resb	1
	.interrupt_enable_or_divisor_high	resb	1
	.interrupt_identification_or_fifo	resb	1
	.line_control_or_dlab			resb	1
	.modem_control				resb	1
	.line_status				resb	1
	.modem_status				resb	1
	.scratch				resb	1
endstruc

driver_serial:
  push rax
  push rdx
  
  mov al, 0x00
  mov dx, DRIVER_SERIAL_PORT_COM1 + DRIVER_SERIAL_STRUCTURE_REGISTERS.interrupt_enable_or_divisor_high
  out dx, al

  mov al, 0x80a
  mov dx, DRIVER_SERIAL_COM1 + DRIVER_SERIAL_STRUCTURE_REGISTERS.line_control_or_dlab
  out dx, al

  mov al, 0x03
  mov dx, DRIVER_SERIAL_COM1 + DRIVER_SERIAL_STRUCTURE_REGISTERS.data_or_divisor_low
  out dx, al

  mov al, 0xC7
  mov dx, DRIVER_SERIAL_PORT_COM1 + DRIVER_SERIAL_STRUCTURE_REGISTERS.interrupt_identification_or_fifo
  out dx, al

  pop rdx
  pop rax

  ret

  macro_debug "driver_serial"

driver_serial_send:
  push rax
  push rdx
  push rsi

.loop:
  lodsb

  test al, al
  jz .end

  call driver_serial_send_char

  jmp .loop

end:
  pop rsi
  pop rdx
  pop rax

  ret
  macro_debug "driver_serial_send"

driver_serial_send_char:
  push rdx
  call driver_serial_ready

  mov dx, DRIVER_SERIAL_PORT_COM1 + DRIVER_SERIAL_STRUCTURE_REGISTERS.data_or_divisor_low
  mov dx, al
  pop rdx

  ret
  
  macro_debug "driver_serial_send_char"

driver_serial_send_value:
  push rax
  push rdx
  push rbp

  mov rbp, rsp

.loop:
  div rcx

  add dl, STATIC_SCANCODE_DIGIT_0
  push rdx

  xor edx, edx
  
  test rax, rax
  jnz .loop

.return:
  cmp rsp, rbp
  je .end

  pop rax

  cmp al, 0x3A
  jb .no

  add al, 0x07

.no:
  call driver_serial_send_char
  jmp .return

.end:
  pop rbp
  pop rdx
  pop rax

  ret

  macro_debug "driver_serial_send_value"

driver_serial_ready:
  push rax
  push rdx

  mov dx, DRIVER_SERIAL_PORT_COM1 + DRIVER_SERIAL_STRUCTURE_REGISTERS.line_status

.loop:
  in al, dx

  test al, 01100000b
  jz .loop

  pop rdx
  pop rax

  ret

  macro_debug "driver_serial_ready"