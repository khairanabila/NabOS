struc	LIBRARY_TERMINAL_STRUCTURE
	.width				resb	8
	.height				resb	8
	.address			resb	8
	.size_byte			resb	8
	.scanline_byte			resb	8
	.pointer			resb	8
	.width_char			resb	8
	.height_char			resb	8
	.scanline_char			resb	8
    .cursor:			resb	4
                        resb 4
	.lock				resb	8
	.foreground_color		resb	4
	.background_color		resb	4
endstruc

struc LIBRARY_TERMINAL_STRUCTURE_CURSOR
    .x resb 4
    .y resb 4
endstruc