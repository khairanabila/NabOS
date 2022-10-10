DRIVER_PS2_KEYBOARD_IRQ_number					equ	0x01	; 1
DRIVER_PS2_KEYBOARD_IO_APIC_register				equ	KERNEL_IO_APIC_iowin + (DRIVER_PS2_KEYBOARD_IRQ_number * 0x02)

DRIVER_PS2_MOUSE_IRQ_number					equ	0x0C	; 12
DRIVER_PS2_MOUSE_IO_APIC_register				equ	KERNEL_IO_APIC_iowin + (DRIVER_PS2_MOUSE_IRQ_number * 0x02)

DRIVER_PS2_PORT_DATA						equ	0x60
DRIVER_PS2_PORT_COMMAND_OR_STATUS				equ	0x64

DRIVER_PS2_DEVICE_ID_GET					equ	0xF2
DRIVER_PS2_DEVICE_SET_SAMPLE_RATE				equ	0xF3
DRIVER_PS2_DEVICE_PACKETS_ENABLE				equ	0xF4
DRIVER_PS2_DEVICE_PACKETS_DISABLE				equ	0xF5
DRIVER_PS2_DEVICE_SET_DEFAULT					equ	0xF6
DRIVER_PS2_DEVICE_RESET						equ	0xFF

DRIVER_PS2_DEVICE_MOUSE_TYPE_STANDARD				equ	0x00
DRIVER_PS2_DEVICE_MOUSE_TYPE_WHEEL				equ	0x03
DRIVER_PS2_DEVICE_MOUSE_TYPE_BUTTONS_ADDITIONAL			equ	0x04
DRIVER_PS2_DEVICE_MOUSE_PACKET_LMB_bit				equ	0
DRIVER_PS2_DEVICE_MOUSE_PACKET_RMB_bit				equ	1
DRIVER_PS2_DEVICE_MOUSE_PACKET_MMB_bit				equ	2
DRIVER_PS2_DEVICE_MOUSE_PACKET_ALWAYS_ONE_bit			equ	3
DRIVER_PS2_DEVICE_MOUSE_PACKET_X_SIGNED_bit			equ	4
DRIVER_PS2_DEVICE_MOUSE_PACKET_Y_SIGNED_bit			equ	5
DRIVER_PS2_DEVICE_MOUSE_PACKET_OVERFLOW_x			equ	6
DRIVER_PS2_DEVICE_MOUSE_PACKET_OVERFLOW_y			equ	7
DRIVER_PS2_DEVICE_MOUSE_mask					equ	0xFFFFFFFFFFFFFF00

DRIVER_PS2_STATUS_output					equ	00000001b
DRIVER_PS2_STATUS_input						equ	00000010b
DRIVER_PS2_STATUS_system_flag					equ	00000100b
DRIVER_PS2_STATUS_command_data					equ	00001000b
DRIVER_PS2_STATUS_output_second					equ	00100000b
DRIVER_PS2_STATUS_timeout					equ	01000000b
DRIVER_PS2_STATUS_parity					equ	10000000b

DRIVER_PS2_COMMAND_CONFIGURATION_GET				equ	0x20
DRIVER_PS2_COMMAND_CONFIGURATION_SET				equ	0x60
DRIVER_PS2_COMMAND_DISABLE_SECOND_PORT				equ	0xA7
DRIVER_PS2_COMMAND_ENABLE_SECOND_PORT				equ	0xA8
DRIVER_PS2_COMMAND_TEST_PORT_SECOND				equ	0xA9
DRIVER_PS2_COMMAND_TEST_CONTROLLER				equ	0xAA
DRIVER_PS2_COMMAND_TEST_PORT_FIRST				equ	0xAB
DRIVER_PS2_COMMAND_DISABLE_FIRST_PORT				equ	0xAD
DRIVER_PS2_COMMAND_ENABLE_FIRST_PORT				equ	0xAE
DRIVER_PS2_COMMAND_CONTROLLER_INPUT_READ			equ	0xC0
DRIVER_PS2_COMMAND_CONTROLLER_OUTPUT_READ			equ	0xD0
DRIVER_PS2_COMMAND_PORT_SECOND_BYTE_SEND			equ	0xD4

DRIVER_PS2_ANSWER_SELF_TEST_SUCCESS				equ	0xAA
DRIVER_PS2_ANSWER_COMMAND_ACKNOWLEDGED				equ	0xFA
DRIVER_PS2_ANSWER_FAIL						equ	0xFC
DRIVER_PS2_ANSWER_COMMAND_RESEND				equ	0xFE

DRIVER_PS2_CONTROLLER_CONFIGURATION_BIT_FIRST_PORT_INTERRUPT	equ	0
DRIVER_PS2_CONTROLLER_CONFIGURATION_BIT_SECOND_PORT_INTERRUPT	equ	1
DRIVER_PS2_CONTROLLER_CONFIGURATION_BIT_SYSTEM_FLAG		equ	2
DRIVER_PS2_CONTROLLER_CONFIGURATION_BIT_FIRST_PORT_CLOCK	equ	4
DRIVER_PS2_CONTROLLER_CONFIGURATION_BIT_SECOND_PORT_CLOCK	equ	5
DRIVER_PS2_CONTROLLER_CONFIGURATION_BIT_FIRST_PORT_TRANSLATION	equ	6

DRIVER_PS2_KEYBOARD_sequence					equ	0xE0
DRIVER_PS2_KEYBOARD_sequence_alternative			equ	0xE1

DRIVER_PS2_KEYBOARD_key_release					equ	0x0080

DRIVER_PS2_KEYBOARD_PRESS_BACKSPACE				equ	0x0008
DRIVER_PS2_KEYBOARD_PRESS_TAB					equ	0x0009
DRIVER_PS2_KEYBOARD_PRESS_ENTER					equ	0x000D
DRIVER_PS2_KEYBOARD_PRESS_ESC					equ	0x001B
DRIVER_PS2_KEYBOARD_PRESS_CTRL_LEFT				equ	0x001D
DRIVER_PS2_KEYBOARD_PRESS_SHIFT_LEFT				equ	0xE02A
DRIVER_PS2_KEYBOARD_PRESS_SHIFT_RIGHT				equ	0xE036
DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_MULTIPLY			equ	0xE037
DRIVER_PS2_KEYBOARD_PRESS_ALT_LEFT				equ	0xE038
DRIVER_PS2_KEYBOARD_PRESS_CAPSLOCK				equ	0xE03A
DRIVER_PS2_KEYBOARD_PRESS_F1					equ	0xE03B
DRIVER_PS2_KEYBOARD_PRESS_F2					equ	0xE03C
DRIVER_PS2_KEYBOARD_PRESS_F3					equ	0xE03D
DRIVER_PS2_KEYBOARD_PRESS_F4					equ	0xE03E
DRIVER_PS2_KEYBOARD_PRESS_F5					equ	0xE03F
DRIVER_PS2_KEYBOARD_PRESS_F6					equ	0xE040
DRIVER_PS2_KEYBOARD_PRESS_F7					equ	0xE041
DRIVER_PS2_KEYBOARD_PRESS_F8					equ	0xE042
DRIVER_PS2_KEYBOARD_PRESS_F9					equ	0xE043
DRIVER_PS2_KEYBOARD_PRESS_F10					equ	0xE044
DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK				equ	0xE045
DRIVER_PS2_KEYBOARD_PRESS_SCROLL_LOCK				equ	0xE046
DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_MINUS				equ	0xE04A
DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_4				equ	0xE14B
DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_5				equ	0xE04C
DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_6				equ	0xE14D
DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_PLUS				equ	0xE04E
DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_7				equ	0xE047
DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_8				equ	0xE048
DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_9				equ	0xE049
DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_1				equ	0xE14F
DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_2				equ	0xE150
DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_3				equ	0xE151
DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_0				equ	0xE152
DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_DOT				equ	0xE153
DRIVER_PS2_KEYBOARD_PRESS_F11					equ	0xE057
DRIVER_PS2_KEYBOARD_PRESS_F12					equ	0xE158
DRIVER_PS2_KEYBOARD_PRESS_CTRL_RIGHT				equ	0xE01D
DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_DIVIDE			equ	0xE035
DRIVER_PS2_KEYBOARD_PRESS_ALT_RIGHT				equ	0xE038
DRIVER_PS2_KEYBOARD_PRESS_HOME					equ	0xE047
DRIVER_PS2_KEYBOARD_PRESS_ARROW_UP				equ	0xE048
DRIVER_PS2_KEYBOARD_PRESS_PAGE_UP				equ	0xE049
DRIVER_PS2_KEYBOARD_PRESS_ARROW_LEFT				equ	0xE04B
DRIVER_PS2_KEYBOARD_PRESS_ARROW_RIGHT				equ	0xE04D
DRIVER_PS2_KEYBOARD_PRESS_END					equ	0xE04F
DRIVER_PS2_KEYBOARD_PRESS_ARROW_DOWN				equ	0xE050
DRIVER_PS2_KEYBOARD_PRESS_PAGE_DOWN				equ	0xE051
DRIVER_PS2_KEYBOARD_PRESS_INSERT				equ	0xE052
DRIVER_PS2_KEYBOARD_PRESS_DELETE				equ	0xE053
DRIVER_PS2_KEYBOARD_PRESS_WIN_LEFT				equ	0xE058
DRIVER_PS2_KEYBOARD_PRESS_MOUSE_RIGHT				equ	0xE05D

DRIVER_PS2_KEYBOARD_RELEASE_BACKSPACE				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_BACKSPACE
DRIVER_PS2_KEYBOARD_RELEASE_TAB					equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_TAB
DRIVER_PS2_KEYBOARD_RELEASE_ENTER				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_ENTER
DRIVER_PS2_KEYBOARD_RELEASE_ESC					equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_ESC
DRIVER_PS2_KEYBOARD_RELEASE_CTRL_LEFT				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_CTRL_LEFT
DRIVER_PS2_KEYBOARD_RELEASE_SHIFT_LEFT				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_SHIFT_LEFT
DRIVER_PS2_KEYBOARD_RELEASE_SHIFT_RIGHT				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_SHIFT_RIGHT
DRIVER_PS2_KEYBOARD_RELEASE_NUMLOCK_MULTIPLY			equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_MULTIPLY
DRIVER_PS2_KEYBOARD_RELEASE_ALT_LEFT				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_ALT_LEFT
DRIVER_PS2_KEYBOARD_RELEASE_CAPSLOCK				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_CAPSLOCK
DRIVER_PS2_KEYBOARD_RELEASE_F1					equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_F1
DRIVER_PS2_KEYBOARD_RELEASE_F2					equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_F2
DRIVER_PS2_KEYBOARD_RELEASE_F3					equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_F3
DRIVER_PS2_KEYBOARD_RELEASE_F4					equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_F4
DRIVER_PS2_KEYBOARD_RELEASE_F5					equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_F5
DRIVER_PS2_KEYBOARD_RELEASE_F6					equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_F6
DRIVER_PS2_KEYBOARD_RELEASE_F7					equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_F7
DRIVER_PS2_KEYBOARD_RELEASE_F8					equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_F8
DRIVER_PS2_KEYBOARD_RELEASE_F9					equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_F9
DRIVER_PS2_KEYBOARD_RELEASE_F10					equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_F10
DRIVER_PS2_KEYBOARD_RELEASE_NUMLOCK				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK
DRIVER_PS2_KEYBOARD_RELEASE_SCROLL_LOCK				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_SCROLL_LOCK
DRIVER_PS2_KEYBOARD_RELEASE_NUMLOCK_MINUS			equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_MINUS
DRIVER_PS2_KEYBOARD_RELEASE_NUMLOCK_4				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_4
DRIVER_PS2_KEYBOARD_RELEASE_NUMLOCK_5				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_5
DRIVER_PS2_KEYBOARD_RELEASE_NUMLOCK_6				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_6
DRIVER_PS2_KEYBOARD_RELEASE_NUMLOCK_PLUS			equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_PLUS
DRIVER_PS2_KEYBOARD_RELEASE_NUMLOCK_1				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_1
DRIVER_PS2_KEYBOARD_RELEASE_NUMLOCK_2				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_2
DRIVER_PS2_KEYBOARD_RELEASE_NUMLOCK_3				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_3
DRIVER_PS2_KEYBOARD_RELEASE_NUMLOCK_0				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_0
DRIVER_PS2_KEYBOARD_RELEASE_NUMLOCK_DOT				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_DOT
DRIVER_PS2_KEYBOARD_RELEASE_F11					equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_F11
DRIVER_PS2_KEYBOARD_RELEASE_F12					equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_F12
DRIVER_PS2_KEYBOARD_RELEASE_CTRL_RIGHT				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_CTRL_RIGHT
DRIVER_PS2_KEYBOARD_RELEASE_NUMLOCK_DIVIDE			equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_DIVIDE
DRIVER_PS2_KEYBOARD_RELEASE_ALT_RIGHT				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_ALT_RIGHT
DRIVER_PS2_KEYBOARD_RELEASE_HOME				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_HOME
DRIVER_PS2_KEYBOARD_RELEASE_ARROW_UP				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_ARROW_UP
DRIVER_PS2_KEYBOARD_RELEASE_PAGE_UP				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_PAGE_UP
DRIVER_PS2_KEYBOARD_RELEASE_ARROW_LEFT				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_ARROW_LEFT
DRIVER_PS2_KEYBOARD_RELEASE_ARROW_RIGHT				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_ARROW_RIGHT
DRIVER_PS2_KEYBOARD_RELEASE_END					equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_END
DRIVER_PS2_KEYBOARD_RELEASE_ARROW_DOWN				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_ARROW_DOWN
DRIVER_PS2_KEYBOARD_RELEASE_PAGE_DOWN				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_PAGE_DOWN
DRIVER_PS2_KEYBOARD_RELEASE_INSERT				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_INSERT
DRIVER_PS2_KEYBOARD_RELEASE_DELETE				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_DELETE
DRIVER_PS2_KEYBOARD_RELEASE_WIN_LEFT				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_WIN_LEFT
DRIVER_PS2_KEYBOARD_RELEASE_MOUSE_RIGHT				equ	DRIVER_PS2_KEYBOARD_key_release + DRIVER_PS2_KEYBOARD_PRESS_MOUSE_RIGHT

align	STATIC_QWORD_SIZE_byte,					db	STATIC_EMPTY
driver_ps2_mouse_position:
driver_ps2_mouse_x						dw	STATIC_EMPTY
driver_ps2_mouse_y						dw	STATIC_EMPTY
driver_ps2_mouse_type						db	STATIC_EMPTY
driver_ps2_mouse_packet						db	STATIC_EMPTY
driver_ps2_mouse_state						dw	STATIC_EMPTY

driver_ps2_keyboard_sequence					db	STATIC_EMPTY

align	STATIC_QWORD_SIZE_byte,					db	STATIC_NOTHING
driver_ps2_keyboard_cache					dw	STATIC_EMPTY, STATIC_EMPTY, STATIC_EMPTY, STATIC_EMPTY

align	STATIC_QWORD_SIZE_byte,					db	STATIC_NOTHING
driver_ps2_keyboard_matrix					dq	driver_ps2_keyboard_matrix_low
driver_ps2_keyboard_matrix_low					dw	STATIC_EMPTY
								dw	DRIVER_PS2_KEYBOARD_PRESS_ESC
								db	"1",	0x00				; 0x02
								db	"2",	0x00				; 0x03
								db	"3",	0x00				; 0x04
								db	"4",	0x00				; 0x05
								db	"5",	0x00				; 0x06
								db	"6",	0x00				; 0x07
								db	"7",	0x00				; 0x08
								db	"8",	0x00				; 0x09
								db	"9",	0x00				; 0x0A
								db	"0",	0x00				; 0x0B
								db	"-",	0x00				; 0x0C
								db	"=",	0x00				; 0x0D
								dw	DRIVER_PS2_KEYBOARD_PRESS_BACKSPACE
								dw	DRIVER_PS2_KEYBOARD_PRESS_TAB
								db	"q",	0x00				; 0x10
								db	"w",	0x00				; 0x11
								db	"e",	0x00				; 0x12
								db	"r",	0x00				; 0x13
								db	"t",	0x00				; 0x14
								db	"y",	0x00				; 0x15
								db	"u",	0x00				; 0x16
								db	"i",	0x00				; 0x17
								db	"o",	0x00				; 0x18
								db	"p",	0x00				; 0x19
								db	"[",	0x00				; 0x1A
								db	"]",	0x00				; 0x1B
								dw	DRIVER_PS2_KEYBOARD_PRESS_ENTER
								dw	DRIVER_PS2_KEYBOARD_PRESS_CTRL_LEFT
								db	"a",	0x00				; 0x1E
								db	"s",	0x00				; 0x1F
								db	"d",	0x00				; 0x20
								db	"f",	0x00				; 0x21
								db	"g",	0x00				; 0x22
								db	"h",	0x00				; 0x23
								db	"j",	0x00				; 0x24
								db	"k",	0x00				; 0x25
								db	"l",	0x00				; 0x26
								db	";",	0x00				; 0x27
								db	"'",	0x00				; 0x28
								db	"`",	0x00				; 0x29
								dw	DRIVER_PS2_KEYBOARD_PRESS_SHIFT_LEFT
								db	"\",	0x00				; 0x2B
								db	"z",	0x00				; 0x2C
								db	"x",	0x00				; 0x2D
								db	"c",	0x00				; 0x2E
								db	"v",	0x00				; 0x2F
								db	"b",	0x00				; 0x30
								db	"n",	0x00				; 0x31
								db	"m",	0x00				; 0x32
								db	",",	0x00				; 0x33
								db	".",	0x00				; 0x34
								db	"/",	0x00				; 0x35
								dw	DRIVER_PS2_KEYBOARD_PRESS_SHIFT_RIGHT	; 0x36
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_MULTIPLY
								dw	DRIVER_PS2_KEYBOARD_PRESS_ALT_LEFT	; 0x38
								dw	" ",	0x00				; 0x39
								dw	DRIVER_PS2_KEYBOARD_PRESS_CAPSLOCK	; 0x3A
								dw	DRIVER_PS2_KEYBOARD_PRESS_F1
								dw	DRIVER_PS2_KEYBOARD_PRESS_F2
								dw	DRIVER_PS2_KEYBOARD_PRESS_F3
								dw	DRIVER_PS2_KEYBOARD_PRESS_F4
								dw	DRIVER_PS2_KEYBOARD_PRESS_F5
								dw	DRIVER_PS2_KEYBOARD_PRESS_F6		; 0x40
								dw	DRIVER_PS2_KEYBOARD_PRESS_F7
								dw	DRIVER_PS2_KEYBOARD_PRESS_F8
								dw	DRIVER_PS2_KEYBOARD_PRESS_F9
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK
								dw	STATIC_EMPTY
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_7	; 0x47
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_8	; 0x48
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_9	; 0x49
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_MINUS	; 0x4A
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_4	; 0x4B
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_5	; 0x4C
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_6	; 0x4D
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_PLUS	; 0x4E
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_1	; 0x4F
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_2	; 0x50
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_3	; 0x51
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_0	; 0x52
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_DOT	; 0x53
								dw	STATIC_EMPTY
								dw	STATIC_EMPTY
								dw	STATIC_EMPTY
								dw	STATIC_EMPTY
								dw	DRIVER_PS2_KEYBOARD_PRESS_F11
								dw	DRIVER_PS2_KEYBOARD_PRESS_F12
driver_ps2_keyboard_matrix_high					dw	STATIC_EMPTY
								dw	DRIVER_PS2_KEYBOARD_PRESS_ESC
								db	"!",	0x00				; 0x02
								db	"@",	0x00				; 0x03
								db	"#",	0x00				; 0x04
								db	"$",	0x00				; 0x05
								db	"%",	0x00				; 0x06
								db	"^",	0x00				; 0x07
								db	"&",	0x00				; 0x08
								db	"*",	0x00				; 0x09
								db	"(",	0x00				; 0x0A
								db	")",	0x00				; 0x0B
								db	"_",	0x00				; 0x0C
								db	"+",	0x00				; 0x0D
								dw	DRIVER_PS2_KEYBOARD_PRESS_BACKSPACE
								dw	DRIVER_PS2_KEYBOARD_PRESS_TAB
								db	"Q",	0x00				; 0x10
								db	"W",	0x00				; 0x11
								db	"E",	0x00				; 0x12
								db	"R",	0x00				; 0x13
								db	"T",	0x00				; 0x14
								db	"Y",	0x00				; 0x15
								db	"U",	0x00				; 0x16
								db	"I",	0x00				; 0x17
								db	"O",	0x00				; 0x18
								db	"P",	0x00				; 0x19
								db	"{",	0x00				; 0x1A
								db	"}",	0x00				; 0x1B
								dw	DRIVER_PS2_KEYBOARD_PRESS_ENTER
								dw	DRIVER_PS2_KEYBOARD_PRESS_CTRL_LEFT
								db	"A",	0x00				; 0x1E
								db	"S",	0x00				; 0x1F
								db	"D",	0x00				; 0x20
								db	"F",	0x00				; 0x21
								db	"G",	0x00				; 0x22
								db	"H",	0x00				; 0x23
								db	"J",	0x00				; 0x24
								db	"K",	0x00				; 0x25
								db	"L",	0x00				; 0x26
								db	":",	0x00				; 0x27
								db	'"',	0x00				; 0x28	"
								db	"~",	0x00				; 0x29
								dw	DRIVER_PS2_KEYBOARD_PRESS_SHIFT_LEFT
								db	"|",	0x00				; 0x2B
								db	"Z",	0x00				; 0x2C
								db	"X",	0x00				; 0x2D
								db	"C",	0x00				; 0x2E
								db	"V",	0x00				; 0x2F
								db	"B",	0x00				; 0x30
								db	"N",	0x00				; 0x31
								db	"M",	0x00				; 0x32
								db	"<",	0x00				; 0x33
								db	">",	0x00				; 0x34
								db	"?",	0x00				; 0x35
								dw	DRIVER_PS2_KEYBOARD_PRESS_SHIFT_RIGHT
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_MULTIPLY
								dw	DRIVER_PS2_KEYBOARD_PRESS_ALT_LEFT
								dw	STATIC_EMPTY
								dw	DRIVER_PS2_KEYBOARD_PRESS_CAPSLOCK
								dw	DRIVER_PS2_KEYBOARD_PRESS_F1
								dw	DRIVER_PS2_KEYBOARD_PRESS_F2
								dw	DRIVER_PS2_KEYBOARD_PRESS_F3
								dw	DRIVER_PS2_KEYBOARD_PRESS_F4
								dw	DRIVER_PS2_KEYBOARD_PRESS_F5
								dw	DRIVER_PS2_KEYBOARD_PRESS_F6
								dw	DRIVER_PS2_KEYBOARD_PRESS_F7
								dw	DRIVER_PS2_KEYBOARD_PRESS_F8
								dw	DRIVER_PS2_KEYBOARD_PRESS_F9
								dw	DRIVER_PS2_KEYBOARD_PRESS_F10
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK
								dw	DRIVER_PS2_KEYBOARD_PRESS_SCROLL_LOCK
								dw	STATIC_EMPTY
								dw	STATIC_EMPTY
								dw	STATIC_EMPTY
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_MINUS
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_4
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_5
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_6
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_PLUS
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_1
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_2
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_3
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_0
								dw	DRIVER_PS2_KEYBOARD_PRESS_NUMLOCK_DOT
								dw	STATIC_EMPTY
								dw	STATIC_EMPTY
								dw	STATIC_EMPTY
								dw	DRIVER_PS2_KEYBOARD_PRESS_F11
								dw	DRIVER_PS2_KEYBOARD_PRESS_F12

driver_ps2_keyboard_ctrl_semaphore				db	STATIC_FALSE
driver_ps2_keyboard_shift_left_semaphore			db	STATIC_FALSE
driver_ps2_keyboard_shift_right_semaphore			db	STATIC_FALSE
driver_ps2_keyboard_alt_semaphore				db	STATIC_FALSE
driver_ps2_keyboard_capslock_semaphore				db	STATIC_FALSE

driver_ps2_mouse:
  push rax
  push rbx
  push rdx

  in al, DRIVER_PS2_PORT_COMMAND_OR_STATUS
  test al, DRIVER_PS2_STATUS_output_second
  jz .end

  xor eax, eax
  in al, DRIVER_PS2_PORT_DATA

  mov bx, word[driver_ps2_mouse_x]
  mov dx, word[driver_ps2_mouse_y]

  cmp byte[driver_ps2_mouse_packet], STATIC_TRUE
  jne .no_status

  bt ax, DRIVER_PS2_DEVICE_MOUSE_PACKET_ALWAYS_ONE_bit
  jnc .end

  bt ax, DRIVER_PS2_DEVICE_MOUSE_PACKET_OVERFLOW_x
  jc .end

  bt ax, DRIVER_PS2_DEVICE_MOUSE_PACKET_OVERFLOW_y
  jc .end

  mov byte[driver_ps2_mouse_state], al

  inc byte[driver_ps2_mouse_packet]

  jmp .end

.no_status:
  cmp bytes[driver_ps2_mouse_packet], STATIC_FALSE
  jne .no_x

  inc byte[driver_ps2_mouse_packet]

  bt word[driver_ps2_mouse_state], DRIVER_PS2_MOUSE_PACKET_X_SIGNED_bit
  jnc .x_unsigned

  neg al

  sub bx, ax
  jns .ready

  xor bx, bx

  jmp .ready

.x_unsigned:
  add bx, ax

  cmp bx, word[kernel_video_width_pixel]
  jb .ready

  mov bx, word[kernel_video_width_pixel]
  dec bx

  jmp .ready

.no_x:
  mov byte[driver_ps2_mouse_packet], STATIC_TRUE
  
  bt word[driver_ps2_mouse_state], DRIVER_PS2_DEVICE_MOUSE_PACKET_Y_SIGNED_bit
  jnc .y_unsigned

  neg al

  add dx, al

  cmp dx, word[kernel_video_height_pixel]
  jb .ready

  mov dx, word[kernel_video_height_pixel]
  dec dx

  jmp .ready

.y_unsigned:
  sub dx, ax
  jns .ready

  xor dx, dx

.ready:
  mov word[diver_ps2_mouse_x], bx
  mov word[driver_ps2_mouse_y], dx

.end:
  mov rax, qword[kernel_apic_base_address]
  mov dword[rax + KERNEL_APIC_EOI_register], STATIC_EMPTY

  pop rdx
  pop rbx
  pop rax

  iretq

driver_ps2_keybord_pull:
  push rsi

  in al, DRIVER_PS2_PORT_COMMAND_OR_STATUS

  test al, DRIVER_PS2_STATUS_output
  jz .end

  xor eax, eax
  in al, DRIVER_PS2_PORT_DATA

  cmp al, DRIVER_PS2_KEYBOARD_sequence
  je .sequence

  cmp	al,	DRIVER_PS2_KEYBOARD_sequence_alternative
	je	.sequence

  cmp	byte [driver_ps2_keyboard_sequence],	STATIC_EMPTY
	je	.no_sequence

  xor ah, ah
  xchg ah, byte[driver_ps2_keyboard_sequence]

  jmp .save

.sequence:
  mov byte[driver_ps2_keyboard_sequence], al

  jmp .end

.no_sequence:
  mov rsi, qword[driver_ps2_keyboard_matrix]

  cmp al, DRIVER_PS2_KEYBOARD_key_release
  jb .inside

  sub al, DRIVER_PS2_KEYBOARD_key_release

  mov ax, word[rsi + rax * STATIC_WORD_SIZE_byte]

  add al, DRIVER_PS2_KEYBOARD_key_release
  
  jmp .save

.inside:
  mov ax, word[rsi + rax * STATIC_WORD_SIZE_byte]

.save:
  call driver_ps2_keyboard_shift

.end:
  pop rsi

  ret


driver_ps2_keyboard:
  push rax

  call driver_ps2_keyboard_pull
  jz .end

  call driver_ps2_keyboard_save

.end:
  mov rax, qword[kernel_apic_base_address]
  mov dword[rax + KERNEL_APIC_EOI_register], STATIC_EMPTY

  pop rax

  iretq

driver_ps2_keyboard_shift:
  cmp ax, DRIVER_PS2_KEYBOARD_PRESS_SHIFT_LEFT
  je .press_left

  cmp ax, DRIVER_PS2_KEYBOARD_PRESS_SHIFT_RIGHT
  je .press_right

  cmp ax, DRIVER_PS2_KEYBOARD_RELEASE_SHIFT_LEFT
  je .release_left

  cmp ax, DRIVER_PS2_KEYBOARD_RELEASE_SHIFT_RIGHT
  je .release_right

  cmp ax, DRIVER_PS2_KEYBOARD_PRESS_CAPSLOCK
  je .capslock

  cmp ax, DRIVER_PS2_KEYBOARD_RELEASE_CAPSLOCK
  jne .end

  mov byte[driver_ps2_keyboard_capslock_semaphore], STATIC_FALSE

.end:
  ret

.press_left:
  cmp btye[driver_ps2_keyboard_shift_left_semaphore], STATIC_TRUE
  je .end

  mov byte[driver_ps2_keyboard_shift_left_semaphore], STATIC_TRUE

  jmp .change

.press_right:
  cmp byte[driver_ps2_keyboard_shift_right_semaphore], STATIC_TRUE
  je .end

  mov byte[driver_ps2_keyboard_shift_right_semaphore], STATIC_TRUE

  jmp .change

.release_left:
  mov byte[driver_ps2_keyboard_shift_left_semaphore], STATIC_FALSE

  jmp .change

.release_right:
  mov byte[driver_ps2_keyboard_capslock_semaphore], STATIC_TRUE
  je .end

.capslock:
  cmp byte[driver_ps2_keyboard_capslock_semaphore], STATIC_TRUE
  je .end

  mov byte[driver_ps2_keyboard_capslock_semaphore], STATIC_TRUE

.change:
  call driver_ps2_keyboard_matrix_change

  ret


driver_ps2_keyboard_save:
  shl qword[driver_ps2_keyboard_cache], STATIC_MOVE_AX_TO_HIGH_shift
  mov word[driver_ps2_keyboard_cache], ax
  ret

driver_ps2_keyboard_matrix_change:
  push rax
  
  mov rax, driver_ps2_keyboard_matrix_high
  xchg qword[driver_ps2_keyboard_matrix], rax

  cmp rax, driver_ps2_keyboard_matrix_low
  je .end

  mov qword[driver_ps2_keyboard_matrix], driver_ps2_keyboard_matrix_low

.end:
  pop rax

  ret


driver_ps2_keyboard_read:
  mov ax, word[driver_ps2_keyboard_cache + STATIC_DWORD_SIZE_byte + STATIC_WORD_SIZE_byte]
  shl qword[driver_ps2_keyboard_cache], STATIC_MOVE_AX_TO_HIGH_shift

  test ax, ax

  ret

driver_ps2_check_dummy_answer_or_dump:
  pop rax

.again:
  in al, DRIVER_PS2_PORT_COMMAND_OR_STATUS
  bt ax, 0
  jnc .nothing

  in al, DRIVER_PS2_PORT_DATA
  jmp .again

.nothing:
  pop rax
  ret

driver_ps2_send_command_receive_answer:
  call driver_ps2_check_write

  out DRIVER_PS2_PORT_COMMAND_OR_STATUS, al

  call driver_ps2_receive_answer

  ret

driver_ps2_check_write:
  push rax

.loop:
  in al, DRIVER_PS2_PORT_COMMAND_OR_STATUS
  test al, 2
  jnz .loop

  pop rax

  ret

driver_ps2_receive_answer:
  call driver_ps2_check_read

  in al, DRIVER_PS2_PORT_DATA

  ret

driver_ps2_receive_answer:
  call driver_ps2_check_read

  in al, DRIVER_PS2_PORT_DATA

  ret


driver_ps2_check_read:
  push rax

.loop:
  in al, DRIVER_PS2_PORT_COMMAND_OR_STATUS
  test al, 1
  jz .loop
  
  pop rax
  ret

driver_ps2_send_command:
  call driver_ps2_check_write

  out DRIVER_PS2_PORT_COMMAND_OR_STATUS, al
  ret

driver_ps2_send_answer_or_ask_device:
  call driver_ps2_check_write

  out DRIVER_PS2_PORT_DATA, al
  ret