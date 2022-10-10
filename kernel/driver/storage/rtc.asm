DRIVER_RTC_IRQ_number					equ	0x08
DRIVER_RTC_IO_APIC_register				equ	KERNEL_IO_APIC_iowin + (DRIVER_RTC_IRQ_number * 0x02)

DRIVER_RTC_PORT_command					equ	0x0070
DRIVER_RTC_PORT_data					equ	0x0071

DRIVER_RTC_PORT_second					equ	0x00
DRIVER_RTC_PORT_minute					equ	0x02
DRIVER_RTC_PORT_hour					equ	0x04
DRIVER_RTC_PORT_weekday					equ	0x06
DRIVER_RTC_PORT_day_of_month				equ	0x07
DRIVER_RTC_PORT_month					equ	0x08
DRIVER_RTC_PORT_year					equ	0x09
DRIVER_RTC_PORT_STATUS_REGISTER_A			equ	0x0A
DRIVER_RTC_PORT_STATUS_REGISTER_B			equ	0x0B

DRIVER_RTC_PORT_STATUS_REGISTER_A_rate			equ	00000110b	; 1024 Hz
DRIVER_RTC_PORT_STATUS_REGISTER_A_divider		equ	00100000b	; 32768 kHz
DRIVER_RTC_PORT_STATUS_REGISTER_A_update_in_progress	equ	10000000b

DRIVER_RTC_PORT_STATUS_REGISTER_B_daylight_savings	equ	00000001b
DRIVER_RTC_PORT_STATUS_REGISTER_B_24_hour_mode		equ	00000010b
DRIVER_RTC_PORT_STATUS_REGISTER_B_binary_mode		equ	00000100b
DRIVER_RTC_PORT_STATUS_REGISTER_B_periodic_interrupt	equ	01000000b
DRIVER_RTC_PORT_STATUS_REGISTER_C			equ	0x0C

DRIVER_RTC_Hz						equ	1024

struc	DRIVER_RTC_STRUCTURE
	.second						resb	1
	.minute						resb	1
	.hour						resb	1
	.day						resb	1
	.month						resb	1
	.year						resb	1
	.day_of_week					resb	1
endstruc

driver_rtc_semaphore					db	STATIC_FALSE

driver_rtc_microtime					dq	STATIC_EMPTY

driver_rtc_date_and_time				dq	STATIC_EMPTY

driver_rtc:
  push rax
  inc qword[driver_rtc_microtime]

  mov al, DRIVER_RTC_PORT_STATUS_REGISTER_C
  out DRIVER_RTC_PORT_command, al
  in al, DRIVER_RTC_PORT_data

  mov rax, qword[kernel_apic_base_address]
  mov qword[rax + KERNEL_APIC_EOI_REGISTER], STATIC_EMPTY

  pop rax
  iretq

driver_rtc_get_date_and_time:
  push rax
  
  mov al, DRIVER_RTC_PORT_second
  out DRIVER_RTC_PORT_command, al
  in al, DRIVER_RTC_PORT_data

  mov bytes[driver_rtc_date_and_time + DRIVER_RTC_STRUCTURE.second], al

  mov al, DRIVER_RTC_PORT_minute
  out DRIVER_RTC_PORT_command, al
  in al, DRIVER_RTC_PORT_data

  mov byte[driver_rtc_date_and_time + DRIVER_RTC_STRUCTURE.minute], al

  mov al, DRIVER_RTC_PORT_hour
  out DRIVER_RTC_PORT_command, al
  in al, DRIVER_RTC_PORT_data

  mov byte[driver_rct_date_and_time + DRIVER_RTC_STRUCTURE.hour], al

  mov al, DRIVER_RTC_PORT_STATUS_REGISTER_C
  out DRIVER_RTC_PORT_command
  in al, DRIVER_RTC_PORT_data

  pop rax

  ret