align	STATIC_QWORD_SIZE_byte,	db	STATIC_NOTHING

library_font_width_pixel	dq	LIBRARY_FONT_WIDTH_pixel
library_font_height_pixel	dq	LIBRARY_FONT_HEIGHT_pixel
library_font_width_byte		dq	LIBRARY_FONT_WIDTH_pixel << KERNEL_VIDEO_DEPTH_shift

library_font_matrix:		db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x08, 0x08, 0x08, 0x08, 0x08, 0x00, 0x08, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x14, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x14, 0x3E, 0x14, 0x3E, 0x14, 0x00, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x08, 0x1E, 0x20, 0x1C, 0x02, 0x3C, 0x08, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x30, 0x32, 0x04, 0x08, 0x10, 0x26, 0x06, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x18, 0x24, 0x24, 0x18, 0x26, 0x24, 0x1A, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x08, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
				db	0x00, 0x00, 0x04, 0x08, 0x08, 0x10, 0x10, 0x10, 0x08, 0x08, 0x04, 0x00
				db	0x00, 0x00, 0x10, 0x08, 0x08, 0x04, 0x04, 0x04, 0x08, 0x08, 0x10, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x08, 0x2A, 0x1C, 0x2A, 0x08, 0x00, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x08, 0x08, 0x3E, 0x08, 0x08, 0x00, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x10, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1E, 0x00, 0x00, 0x00, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x04, 0x04, 0x08, 0x08, 0x10, 0x10, 0x20, 0x20, 0x00
				db	0x00, 0x00, 0x00, 0x1C, 0x22, 0x26, 0x2A, 0x32, 0x22, 0x1C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x04, 0x0C, 0x14, 0x04, 0x04, 0x04, 0x04, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x1C, 0x22, 0x02, 0x0C, 0x10, 0x20, 0x3E, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x3E, 0x04, 0x08, 0x1C, 0x02, 0x22, 0x1C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x04, 0x0C, 0x14, 0x24, 0x3E, 0x04, 0x04, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x3C, 0x20, 0x3C, 0x02, 0x02, 0x22, 0x1C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x1C, 0x20, 0x3C, 0x22, 0x22, 0x22, 0x1C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x3E, 0x02, 0x04, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x1C, 0x22, 0x22, 0x1C, 0x22, 0x22, 0x1C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x1C, 0x22, 0x22, 0x22, 0x1E, 0x02, 0x1C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x08, 0x10, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x02, 0x04, 0x08, 0x10, 0x08, 0x04, 0x02, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x1E, 0x00, 0x1E, 0x00, 0x00, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x10, 0x08, 0x04, 0x02, 0x04, 0x08, 0x10, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x1C, 0x22, 0x02, 0x04, 0x08, 0x00, 0x08, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x1C, 0x22, 0x2E, 0x2A, 0x2E, 0x20, 0x1C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x08, 0x14, 0x22, 0x22, 0x3E, 0x22, 0x22, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x3C, 0x22, 0x22, 0x3C, 0x22, 0x22, 0x3C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x1C, 0x22, 0x20, 0x20, 0x20, 0x22, 0x1C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x3C, 0x22, 0x22, 0x22, 0x22, 0x22, 0x3C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x3E, 0x20, 0x20, 0x3C, 0x20, 0x20, 0x3E, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x3E, 0x20, 0x20, 0x3C, 0x20, 0x20, 0x20, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x1C, 0x22, 0x20, 0x2E, 0x22, 0x22, 0x1E, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x3E, 0x22, 0x22, 0x22, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x1C, 0x08, 0x08, 0x08, 0x08, 0x08, 0x1C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x02, 0x02, 0x02, 0x02, 0x22, 0x22, 0x1C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x22, 0x24, 0x28, 0x30, 0x28, 0x24, 0x22, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x3E, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x22, 0x36, 0x2A, 0x22, 0x22, 0x22, 0x22, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x22, 0x32, 0x2A, 0x26, 0x22, 0x22, 0x22, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x1C, 0x22, 0x22, 0x22, 0x22, 0x22, 0x1C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x3C, 0x22, 0x22, 0x22, 0x3C, 0x20, 0x20, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x1C, 0x22, 0x22, 0x22, 0x22, 0x22, 0x1C, 0x06, 0x00
				db	0x00, 0x00, 0x00, 0x3C, 0x22, 0x22, 0x3C, 0x22, 0x22, 0x22, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x1C, 0x22, 0x20, 0x1C, 0x02, 0x22, 0x1C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x3E, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x1C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x22, 0x22, 0x14, 0x08, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x22, 0x2A, 0x2A, 0x14, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x22, 0x22, 0x14, 0x08, 0x14, 0x22, 0x22, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x14, 0x08, 0x08, 0x08, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x3E, 0x02, 0x04, 0x08, 0x10, 0x20, 0x3E, 0x00, 0x00
				db	0x00, 0x00, 0x1C, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x1C, 0x00
				db	0x00, 0x00, 0x00, 0x20, 0x20, 0x10, 0x10, 0x08, 0x08, 0x04, 0x04, 0x00
				db	0x00, 0x00, 0x1C, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x1C, 0x00
				db	0x00, 0x00, 0x00, 0x08, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1E, 0x00
				db	0x00, 0x00, 0x00, 0x10, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x02, 0x1E, 0x22, 0x1E, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x20, 0x20, 0x3C, 0x22, 0x22, 0x22, 0x3C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x22, 0x20, 0x20, 0x1E, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x02, 0x02, 0x1E, 0x22, 0x22, 0x22, 0x1E, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x22, 0x3E, 0x20, 0x1E, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x06, 0x08, 0x3E, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x1E, 0x22, 0x22, 0x22, 0x1E, 0x02, 0x1C
				db	0x00, 0x00, 0x00, 0x20, 0x20, 0x3C, 0x22, 0x22, 0x22, 0x22, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x08, 0x00, 0x18, 0x08, 0x08, 0x08, 0x0C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x04, 0x00, 0x0C, 0x04, 0x04, 0x04, 0x04, 0x04, 0x18
				db	0x00, 0x00, 0x00, 0x30, 0x10, 0x12, 0x14, 0x18, 0x14, 0x12, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x18, 0x08, 0x08, 0x08, 0x08, 0x08, 0x06, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x2A, 0x2A, 0x2A, 0x2A, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x22, 0x22, 0x22, 0x22, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x22, 0x22, 0x22, 0x1C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x22, 0x22, 0x22, 0x3C, 0x20, 0x20
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x1E, 0x22, 0x22, 0x22, 0x1E, 0x02, 0x02
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x22, 0x20, 0x20, 0x20, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x20, 0x1C, 0x02, 0x3C, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x10, 0x10, 0x3C, 0x10, 0x10, 0x10, 0x0E, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x22, 0x1E, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x14, 0x08, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x2A, 0x2A, 0x14, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x14, 0x08, 0x14, 0x22, 0x00, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x22, 0x1E, 0x02, 0x1C
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x1E, 0x04, 0x08, 0x10, 0x3E, 0x00, 0x00
				db	0x00, 0x00, 0x04, 0x08, 0x08, 0x08, 0x10, 0x08, 0x08, 0x08, 0x04, 0x00
				db	0x00, 0x00, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x00
				db	0x00, 0x00, 0x10, 0x08, 0x08, 0x08, 0x04, 0x08, 0x08, 0x08, 0x10, 0x00
				db	0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00