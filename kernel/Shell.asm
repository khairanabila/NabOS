[bits 16]
%include "./Kernel/ShellCommands.asm"
CommandThingColor equ 0xa

%macro WaitForKeyPress 0
  xor ax, ax
  mov ah, 0
  int 0x16
%endmacro

InitShell:
  mov si, InitShellMessage
  xor ah, ah
  call VgaPrintString

  mov si, CommandThing
  mov ah, CommandThingColor
  call VgaPrintString
    xor si, si

    jmp GetCommand
GetCommand:
    WaitForKeyPress

    cmp al, byte 13
    je .Enter
    cmp al, byte 8
    je .Backspace

    ; Saves the character
    mov [CommandBuffer + si], al
    inc si

    jmp .Continue

    .Enter:
        cmp si, byte 0
        je .AddNewLine

        .ExecCommand:
            mov di, help
            call CompareCommand
            cmp ah, byte 0
            je Help

            mov di, clear
            call CompareCommand
            cmp ah, byte 0
            je Clear

            mov di, ls
            call CompareCommand
            cmp ah, byte 0
            je Ls

            mov di, edit
            call CompareCommand
            cmp ah, byte 0
            je Edit

            mov di, fetch
            call CompareCommand
            cmp ah, byte 0
            je Fetch

            mov di, reboot
            call CompareCommand
            cmp ah, byte 0
            je Reboot

            mov di, katanab
            call CompareCommand
            cmp ah, byte 0
            je Katanab

            call CommandNotFound
            call ClearCommandBuffer

        .AddNewLine:
            mov al, 1
            call VgaNewLine
            jmp .SkipNewLine

        .AddNewDoubleLine:
            mov al, 2
            call VgaNewLine
            
        .SkipNewLine:
            mov si, CommandThing
            mov ah, CommandThingColor
            call VgaPrintString

            mov si, 0 

            jmp GetCommand


    .Backspace:
        cmp si, byte 0
        je GetCommand

        dec si
        mov [CommandBuffer + si], byte 0

        mov ah, 3
        mov bh, 0 
        int 0x10

        dec dl 

        mov ah, 2
        mov bh, 0 
        int 0x10

        mov ah, 0xa
        mov al, 0
        mov bh, 0 ; Page
        int 0x10

        jmp GetCommand


    .Continue:
        VgaPrintChar al, 0

        jmp GetCommand
CompareCommand:
    push si 
    mov cx, 64 
    mov si, CommandBuffer
    repe cmpsb
    jne .Mismatch

    jmp .CheckForAttributes

    .Mismatch:
        cmp [si], byte 32
        je .CheckForAttributes
        cmp [si], byte 0
        jne .GoBack
        cmp [di], byte 0
        je .Exit
        .GoBack:
            pop si
            mov ah, 1
            xor al, al

            ret
    .CheckForAttributes:
        mov di, AttributesBuffer
        xor al, al

        .Loop:
            cmp [si], byte 32
            je .Continue

        .CheckForEnd:
            cmp [si], byte 0
            je .Exit

        .Attribute:
            cmp [si], byte 32
            jne .YetAnotherChar

            inc al
            inc di
            mov [di], byte 32 

            jmp .Continue

            .YetAnotherChar:
                mov bl, byte [si]
                mov byte [di], bl

                inc si
                inc di
                jmp .CheckForEnd

        .Continue:
            inc si
            jmp .Loop


    .Exit:
        pop si

        call ClearCommandBuffer
        xor ah, ah

        ret

ClearCommandBuffer:
    .Loop:
        cmp si, byte 0
        je .Exit

        mov [CommandBuffer + si], byte 0
        dec si

        jmp .Loop

    .Exit:
        ret


CommandNotFound:
    push si

    mov al, 1
    call VgaNewLine

    mov si, CommandNotFoundMessage
    xor ah, ah
    call VgaPrintString

    pop si
    ret
CommandBuffer: times 64 db 0
AttributesBuffer: times 64 db 0

CommandThing: db ">>", 0
InitShellMessage: db "Ketik 'help' untuk list command", 10, 13, 10, 13, 0
CommandNotFoundMessage: db "Command tidak ditemukan", 0

clear: db "clearr", 0
help: db "helpp", 0
ls: db "lss", 0
edit: db "editt", 0
fetch: db "fetchh", 0
katanab: db "katanabb", 0
reboot: db "reboott", 0
