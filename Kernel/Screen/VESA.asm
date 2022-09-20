[bits 16]
[cpu 286]

GetVesaInfo:
    push es
    mov di, VesaInfo.Data
    mov ax, 0x4f00
    int 0x10
    pop es
    cmp al, 0x4f
    jne .Error

    cmp ah, 0
    je .Exit

    .Error:
        mov si, .VesaInfoError
        call PrintString

    .Exit:
        mov ax, 0xe
        mov gs, word [VesaInfo.Data + ax]
        add ax, 2
        mov bx, word [VesaInfo.Data + ax]

        ret
GetVesaModeInfo:
    ret


.VesaInfoError: db 10, 13, "VESA error", 0
VesaInfo:
    .Signature: db "VESA"
    .Data: resb 512 - 4

VesaModeInfo: resb 256
