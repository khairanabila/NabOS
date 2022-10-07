[org 0x0]
[bits 16]
[cpu 286]
cli 
jmp KernelMain
%include "./Kernel/IO.asm"
%include "./Kernel/Screen/VGA.asm"
; %include "./Kernel/Screen/VESA.asm"
%include "./Kernel/Shell.asm"
%include "./Kernel/Disk.asm"
LogoColor equ 0xe 
KernelMain:
  mov ax, 0x7e0 
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ax, 0x687b
  mov ss, ax
  mov sp, 0x7bff
  mov byte [BootDisk], dl
  mov word [TotalMemory], cx

  cld 
  sti 
  xor ax, ax
  mov al, 3
  int 0x10

  call VgaInit
  call VgaClearScreen    
  mov al, 1
  out 0x1a, al
  out 0x21, al
    
  call PrintLogo
  mov cx, 0x2d
  mov dx, 0x4240
  mov ah, 0x86
  int 0x15
  call GetBdaInfo
  call VgaClearScreen
  jmp InitShell
  cli
  hlt
GetBdaInfo:
  add byte [BdaMemAddress], 0x89
  mov bx, [BdaMemAddress]
  test bx, 4
  jz .ColorVga
  .ColorVga:
    mov byte [SystemInfoByte], 1
  ret

%macro PrintLogoLine 1
  mov si, NabLogoSpace
  xor ah, ah
  call VgaPrintString

  mov si, %1
  mov ah, LogoColor
  call VgaPrintString

  mov al, 1
  call VgaNewLine
%endmacro
PrintLogo:
  xor cx, cx
  mov al, 6
  call VgaNewLine
  .Logo:
    PrintLogoLine NabLogo
    PrintLogoLine NabLogo1
    PrintLogoLine NabLogo2
    PrintLogoLine NabLogo3
    PrintLogoLine NabLogo4
    PrintLogoLine NabLogo5

    mov si, WelcomeSpace
    xor ah, ah
    call VgaPrintString

    mov si, WelcomeMessage
    xor ah, ah
    call VgaPrintString

    ret
BdaMemAddress: db 0x400
SystemInfoByte: db 0
TotalMemory: dw 0


NabLogoSpace: db "                    ", 0
NabLogo: db "             _           ", 0
NabLogo1: db "            | |         ", 0
NabLogo2: db " _ __   __ _| |__     ___  ___", 0
NabLogo3: db "| '_ \ / _` | '_ \   / _ \/ __|", 0
NabLogo4: db "| | | | (_| | |_) | | (_) \__ \", 0
NabLogo5: db "|_| |_|\__,_|_.__/   \___/|___/", 0
WelcomeSpace: db 10, 13, "                ", 0
WelcomeMessage: db "Selamat datang di NabOS! Loading...", 0
