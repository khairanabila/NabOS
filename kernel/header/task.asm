KERNEL_TASK_FLAG_active			equ	0000000000000001b	
KERNEL_TASK_FLAG_closed			equ	0000000000000010b	
KERNEL_TASK_FLAG_service		equ	0000000000000100b
KERNEL_TASK_FLAG_processing		equ	0000000000001000b	
KERNEL_TASK_FLAG_secured		equ	0000000000010000b	
KERNEL_TASK_FLAG_thread			equ	0000000000100000b
KERNEL_TASK_FLAG_stream_in		equ	0000000001000000b	
KERNEL_TASK_FLAG_stream_out		equ	0000000010000000b	
KERNEL_TASK_FLAG_sleep			equ	0000000100000000b	

KERNEL_TASK_FLAG_active_bit		equ	0
KERNEL_TASK_FLAG_closed_bit		equ	1
KERNEL_TASK_FLAG_service_bit		equ	2
KERNEL_TASK_FLAG_processing_bit		equ	3
KERNEL_TASK_FLAG_secured_bit		equ	4
KERNEL_TASK_FLAG_thread_bit		equ	5
KERNEL_TASK_FLAG_stream_in_bit		equ	6
KERNEL_TASK_FLAG_stream_out_bit		equ	7
KERNEL_TASK_FLAG_sleep_bit		equ	8

struc	KERNEL_TASK_STRUCTURE_ENTRY
	.pid				resb	8	
	.parent				resb	8	
	.cpu				resb	8	
	.time				resb	8	
	.apic				resb	4	
	.memory				resb	8	
	.knot				resb	8	
	.flags				resb	2	
	.length				resb	1	
	.SIZE:
endstruc