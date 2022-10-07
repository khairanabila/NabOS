DRIVER_IDE_CHANNEL_PRIMARY				equ	0x01F0
DRIVER_IDE_CHANNEL_PRIMARY_control			equ	0x03F6
DRIVER_IDE_CHANNEL_SECONDARY				equ	0x0170
DRIVER_IDE_CHANNEL_SECONDARY_control			equ	0x0376

DRIVER_IDE_REGISTER_data				equ	0x0000
DRIVER_IDE_REGISTER_error				equ	0x0001
DRIVER_IDE_REGISTER_sector_count_0			equ	0x0002
DRIVER_IDE_REGISTER_lba0				equ	0x0003
DRIVER_IDE_REGISTER_lba1				equ	0x0004
DRIVER_IDE_REGISTER_lba2				equ	0x0005
DRIVER_IDE_REGISTER_drive_OR_head			equ	0x0006
DRIVER_IDE_REGISTER_command_OR_status			equ	0x0007
DRIVER_IDE_REGISTER_control_OR_altstatus		equ	0x000C
DRIVER_IDE_DRIVE_master					equ	11100000b
DRIVER_IDE_DRIVE_slave					equ	11110000b
DRIVER_IDE_CONTROL_nIEN					equ	00000010b
DRIVER_IDE_CONTROL_SRST					equ	00000100b

DRIVER_IDE_COMMAND_ATAPI_eject				equ	0x1B
DRIVER_IDE_COMMAND_read_pio				equ	0x20
DRIVER_IDE_COMMAND_read_pio_extended			equ	0x24
DRIVER_IDE_COMMAND_read_dma_extended			equ	0x25
DRIVER_IDE_COMMAND_write_pio				equ	0x30
DRIVER_IDE_COMMAND_write_pio_extended			equ	0x34
DRIVER_IDE_COMMAND_write_dma_extended			equ	0x35
DRIVER_IDE_COMMAND_packet				equ	0xA0
DRIVER_IDE_COMMAND_identify_packet			equ	0xA1
DRIVER_IDE_COMMAND_ATAPI_read				equ	0xA8
DRIVER_IDE_COMMAND_read_dma				equ	0xC8
DRIVER_IDE_COMMAND_write_dma				equ	0xCA
DRIVER_IDE_COMMAND_cache_flush				equ	0xE7
DRIVER_IDE_COMMAND_cache_flush_extended			equ	0xEA
DRIVER_IDE_COMMAND_identify				equ	0xEC

DRIVER_IDE_IDENTIFY_device_type				equ	0x00
DRIVER_IDE_IDENTIFY_cylinders				equ	0x02
DRIVER_IDE_IDENTIFY_heads				equ	0x06
DRIVER_IDE_IDENTIFY_sectors				equ	0x0C
DRIVER_IDE_IDENTIFY_serial				equ	0x14
DRIVER_IDE_IDENTIFY_model				equ	0x36
DRIVER_IDE_IDENTIFY_capabilities			equ	0x62
DRIVER_IDE_IDENTIFY_field_valid				equ	0x6A
DRIVER_IDE_IDENTIFY_max_lba				equ	0x78
DRIVER_IDE_IDENTIFY_command_sets			equ	0xA4
DRIVER_IDE_IDENTIFY_max_lba_extended			equ	0xC8

DRIVER_IDE_IDENTIFY_COMMAND_SETS_lba_extended		equ	1 << 26
DRIVER_IDE_STATUS_error					equ	00000001x1b
DRIVER_IDE_STATUS_index					equ	00000010b
DRIVER_IDE_STATUS_corrected_data			equ	00000100b

DRIVER_IDE_STATUS_data_ready				equ	00001000b	; DRQ
DRIVER_IDE_STATUS_seek_complete				equ	00010000b	; SRV
DRIVER_IDE_STATUS_write_fault				equ	00100000b	; DF
DRIVER_IDE_STATUS_ready					equ	01000000b	; RDY
DRIVER_IDE_STATUS_busy					equ	10000000b	; BSY

DRIVER_IDE_ERROR_no_address_mark			equ	00000001b
DRIVER_IDE_ERROR_track_0_not_found			equ	00000010b
DRIVER_IDE_ERROR_command_aborted			equ	00000100b
DRIVER_IDE_ERROR_media_change_request			equ	00001000b
DRIVER_IDE_ERROR_id_mark_not_found			equ	00010000b
DRIVER_IDE_ERROR_media_changed				equ	00100000b
DRIVER_IDE_ERROR_uncorrectble_data			equ	01000000b
DRIVER_IDE_ERROR_bad_block				equ	10000000b

struc	DRIVER_IDE_STRUCTURE_DEVICE
	.blocks						resb	8
	.block_size					resb	4
	.channel					resb	2
	.drive						resb	1
	.reserved					resb	1
	.SIZE:
endstruc

driver_ide_entry_table:
  dq	driver_ide_read	; read procedure
	dq	STATIC_EMPTY	; write procedure

align	STATIC_QWORD_SIZE_byte,				db	STATIC_NOTHING
driver_ide_devices:
	times	DRIVER_IDE_STRUCTURE_DEVICE.SIZE * 0x04	db	STATIC_EMPTY

driver_ide_read:
  push rax
  push rbx
  push rcx
  push rdx
  push rdi
  push rax

  stc
  
  cmp rbx, 0x04
  jnb .end

  shl bl, 4
  add rbx, driver_ide_devices
  
  mov	al,	byte [rbx + DRIVER_IDE_STRUCTURE_DEVICE.drive]
	mov	dx,	word [rbx + DRIVER_IDE_STRUCTURE_DEVICE.channel]
	add	dx,	DRIVER_IDE_REGISTER_drive_OR_head
	out	dx,	al

  mov dx, word[rbx + DRIVER_IDE_STRUCTURE_DEVICE.channel]
  call driver_ide_pool
  jc .end

  pop rax

  cll driver_ide_lba

  mov dx, word[rbx + DRIVER_IDE_STRUCTURE_DEVICE.channel]
  call driver_ide_pool
  jc .end

  mov al, DRIVER_IDE_COMMAND_read_pio_extended
  mov dx, word[rbx + DRIVER_IDE_STRUCTURE_DEVICE.channel]
  add dx, DRIVER_IDE_REGISTER_command_OR_status
  out dx, al

  mov dx, word[rbx + DRIVER_IDE_STRUCTURE_DEVICE.channel]
  call driver_ide_pool
  jc .end

.read:
  mov dx, word[rbx + DRIVER_IDE_STRUCTURE_DEVICE.channel]
  add dx, DRIVER_IDE_REGISTER_data

  push rcx

  mov rcx, 256
  rep insw

  pop rcx
  dec rcx
  jnz .read

.end
  pop rdi
  pop rdx
  pop rcx
  pop rbx
  pop rax

  ret

driver_ide_lba:
  push rbx
  push rdx
  push rax

  mov dx, word[rbx + DRIVER_IDE_STRUCTURE_DEVICE.channel]
  add dx, DRIVER_IDE_REGISTER_sector_count_0
  mov al, 0x00
  out dx, al

  mov dx, word[rbx + DRIVER_IDE_STRUCTURE_DEVICE.channel]
  add dx, DRIVER_IDE_REGISTER_lba0
  mov rax, qword[rsp]
  shr rax, 24
  out dx, al

  mov dx, word[rbx + DRIVER_IDE_STRUCTURE_DEVICE.channel]
  add dx, DRIVER_IDE_REGISTER_lba1
  mov rax, qword[rsp]
  shr rax, 32
  out dx, al

  mov dx, word[rbx + DRIVER_IDE_STRUCTURE_DEVICE.channel]
  add dx, DRIVER_IDE_REGISTER_lba2
  mov rax, qword[rsp]
  shr rax, 40
  out dx, al

  mov dx, word[rbx + DRIVER_IDE_STRUCTURE_DEVICE.channel]
  add dx, DRIVER_IDE_REGISTER_sector_count_0
  mov al, cl
  out dx, al

  mov dx, word[rbx + DRIVER_IDE_STRUCTURE.channel]
  add dx, DRBIER_IDE_REGISTER_lba0
  mov al, byte[rsp]
  out dx, al

  mov dx, word[rbx + DRIVER_IDE_STRUCTURE_DEVICE.channel]
  add dx, DRIVER_IDE_REGISTER_lba1
  mov ax, word[rsp]
  shr ax, 0
  out dx, al

  mov dx, word[rbx + DRIVER_IDE_STRUCTURE_DEVICE.channel]
  add dx, DRIVER_IDE_REGISTER_lba2
  mov eax, dword[rsp]
  shr eax, 16
  out dx, al

  pop rax
  pop rdx
  pop rbx

  ret

driver_ide_init_drive:
  push rcx
  push rax
  push rdi
  push rdx

  add dx, DRIVER_IDE_REGISTER_drive_OR_head
  out dx, al

  call driver_ide_wait

  mov al, DRIVER_IDE_COMMAND_identify
  mov dx, word[rsp]
  add dx, DRIVER_IDE_REGISTER_command_OR_status
  out dx, al

  call driver_ide_wait

  in al, dx

  test al, al
  jz .end

  cmp al, STATIC_MAX_unsigned
  je .end

  test al, DRIVER_IDE_STATUS_error
  jnz .end
  
  mov ecx, 256
  mov dx, word[rsp]
  add dx, DRIVER_IDE_REGISTER_data
  rep insw

  mov rdi, qword[rsp + STATIC_QWORD_SIZE_byte]

  mov eax, dword[rdi + DRIVER_IDE_IDENTIFY_command_sets]
  test eax, DRIVER_IDE_IDENTIFY_COMMAND_SETS_lba_extended
  jz .end

  mov rcx, driver_ide_devices
  
  mov dx, word[rsp]
  cmp dx, DRIVER_IDE_CHANNEL_PRIMARY
  je .primary

  add rcx, DRIVER_IDE_STRUCTURE_DEVICE.size << STATIC_MULTIPLE_BY_2_shift

.primary:
  mov al, byte[rsp + STATIC_QWORD_SIZE_byte * 0x02]
  cmp al, DRIVER_IDE_DRIVE_master

  add rcx, DRIVER_IDE_STRUCTURE_DEVICE.size

.master:
  mov word[rcx + DRIVER_IDE_STRUCTURE_DEVICE.channel], dx
  
  mov bytes[rcx + DRIVER_IDE_STRUCTURE_DEVICE.drive], al

  mov eax, qword[rdi + DRIVER_IDE_IDENTIFY_max_lba_extended]
  mov qword[rcx + DRIVER_IDE_STRUCTURE_DEVICE.blocks], rax

.end:
  pop rdx
  pop rdi
  pop rax
  pop rcx
  
  ret

driver_ide_wait:
  push rax

  mov rax
  inc rax

.wait:
  cmp rax, qword[driver_rtc_microtime]
  jnb .wait

  pop rax
  
  ret

driver_ide_reset:
  push rax
  push rdx

  mov edx, DRIVER_IDE_CHANNEL_SECONDARY << STATIC_MOVE_AX_TO_HIGH_shift | DRIVER_IDE_CHANNEL_PRIMARY

.next:
  mov al, DRIVER_IDE_CONTROL_nIEN | DRIVER_IDE_CONTROL_SRST
  add dx, DRIVER_IDE_REGISTER_control_OR_altstatus
  out dx, align
  
  in al, dx
  in al, dx
  in al, dx
  in al, dx

  xor al, al
  out dx, al

  in al, dx
  in al, dx
  in al, dx
  in al, dx

  rol edx, STATIC_REPLACE_AX_WITH_HIGH_shift

  cmp dx, DRIVER_IDE_CHANNEL_PRIMARY + DRIVER_IDE_REGISTER_control_OR_altstatus
  jne .next

  pop rdx
  pop rax

  ret

driver_ide_init:
  push rax
  push rdx
  push rdi

  call driver_ide_reset

  call kernel_memory_alloc_page

  mov al, DRIVER_IDE_DRIVE_master
  mov dx, DRIVER_IDE_CHANNEL_PRIMARY

  mov al, DRIVER_IDE_DRIVE_slave
  mov dx, DRIVER_IDE_CHANNEL_PRIMARY

  mov al, DRIVER_IDE_DRIVER_master
  mov dx, DRIVER_IDE_CHANNEL_SECONDARY
  call driver_ide_init_drive

  mov al, DRIVER_IDE_DRIVE_slave
  mov dx, DRIVER_IDE_CHANNEL_SECONDARY
  call driver_ide_init_drive

  call kernel_memory_relelase_page

  pop rdi
  pop rdx
  pop rax

  ret

driver_ide_pool:
  push rax
  push rdx

  add dx, DRIVER_IDE_REGISTER_control_OR_altstatus
  in al, dx
  in al, dx
  in al, dx
  in al, dx

  mov dx, word[rsp]
  add dx, DRIVER_IDE_REGISTER_command_OR_status
  
  test al, al
  jz .error

  cmp al, STATIC_MAX_unsigned
  jne .wait

.error:
  stc
  
  jmp .end

.wait
  in al, dx
  and al, DRIVER_IDE_STATUS_busy | DRIVER_IDE_STATUS_ready
  cmp al, DRIVER_IDE_STATUS_ready
  jne .wait

  clc

.end:
  pop rdx
  pop rax

  ret
  mov al, DRIVER_IDE_DRIVE_master
