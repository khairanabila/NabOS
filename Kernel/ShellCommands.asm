[bits 16]
[cpu 286]


FetchLogoColor equ 0x7

%macro PrintFetchLogo 1
  mov si, %1
  mov ah, FetchLogoColor
  call VgaPrintString

  mov si, FetchSpace
  xor ah, ah
  call VgaPrintString
%endmacro

%macro PrintFetchText 2
  mov si, %1
  call VgaPrintString

  mov si, %2
  xor ah, ah
  call VgaPrintString

  mov al, 1
  call VgaNewLine
%endmacro

Help:
  mov al, 1
  call VgaNewLine
  mov si, HelpText
  xor ah, ah
  call VgaPrintString
  jmp GetCommand.AddNewDoubleLine
Clear:
  call VgaClearScreen
  jmp GetCommand.SkipNewLine


Ls:
  mov al, 1
  call VgaNewLine

  mov si, KernelName
  call SearchFile
  cmp ah, byte 1
  je .Skip
  call .PrintName

  mov si, TestName
  call SearchFile
  cmp ah, byte 1
  je .Skip
  call .PrintName

  jmp .Finished

  .PrintName:
        mov si, dx
        xor ah, ah
        call VgaPrintString

        mov si, LsFileNameSpace
        xor ah, ah
        call VgaPrintString

        ret

    .Skip:
        mov si, LsNoFiles
        mov ah, 0xc
        call VgaPrintString

    .Finished:
        jmp GetCommand.AddNewDoubleLine
        

Reboot:
    mov ax, 0
    int 0x19

Katanab:
    mov al, 1
    call VgaNewLine
    mov si, KatanabText
    xor ah, ah
    call VgaPrintString

    jmp GetCommand.AddNewDoubleLine


Fetch:
    mov al, 1
    call VgaNewLine

    PrintFetchLogo FetchLogo0
    mov ah, 0xc 
    PrintFetchText FetchText0, FetchSpace

    PrintFetchLogo FetchLogo1
    mov ah, 0xc
    PrintFetchText FetchLabel1, FetchText1

    PrintFetchLogo FetchLogo2
    mov ah, 0xb
    PrintFetchText FetchLabel2, FetchText2

    PrintFetchLogo FetchLogo3
    mov ah, 0xa 
    PrintFetchText FetchLabel3, FetchText3

    mov si, FetchLogo4
    mov ah, FetchLogoColor
    call VgaPrintString

    mov al, 1
    call VgaNewLine

    mov si, FetchLogo5
    mov ah, FetchLogoColor
    call VgaPrintString

    jmp GetCommand.AddNewDoubleLine
Edit:
    mov si, EditProgramFileName
    call SearchFile

    cmp ah, byte 1
    je Edit.Error

    call EditProgram

    .Error:
        jmp GetCommand.AddNewDoubleLine

HelpText: db "  clear = bersihin terminal", 10, 13, "  ls = list semua file", 10, 13, "  edit = edit file txt", 10, 13, "  reboot = reboots sistem", 10, 13, "  fetch = info dari sistem", 10, 13, "  katanab = coba aja sendiri", 0
KatanabText: db "Kata Nabilla: gabut kali", 10, 13, "Mending jadi pacar aku aja :)", 0
EditProgramFileName: db "EDIT    BIN", 0

FetchSpace: db "      ", 0
FetchText0: db "root", 0
FetchLabel1: db "os    ", 0
FetchLabel2: db "ver   ", 0
FetchLabel3: db "ram   ", 0
FetchText1: db "NabOS", 0
FetchText2: db "0.0.1", 0
FetchText3: db "15.09KB / 639KB", 0
FetchLogo0: db "N", 0
FetchLogo1: db "A", 0
FetchLogo2: db "B", 0
FetchLogo3: db "N", 0
FetchLogo4: db "A", 0
FetchLogo5: db "B", 0

LsNoFiles: db "Tidak ada file dalam list", 0
LsFileNameSpace: db "    ", 0
KernelName: db "KERNEL  BIN", 0
TestName: db "TEST    TXT", 0

%include "./Programs/Edit.asm"
