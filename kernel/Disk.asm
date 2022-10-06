[bits 16]
[cpu 286]
FATMemLocation equ 0x500
RootDirMemLocation equ 0x1700
KernelOffset equ 4096
RootDirEntries equ 224
SectorsPerTrack equ 18
SectorsPerCluster equ 1
Heads equ 2

ReadDisk:
  call ResetDisk

  mov ah, 0x02
  mov dl, byte [BootDisk]

  mov ch, byte [ChsTrack] 
  mov dh, byte [ChsHead] 
  mov cl, byte [ChsSector] 

  stc
  int 0x13
  jc .Check 
  jmp .Exit
    
  .Check:
    add [ReadAttempts], byte 1 
    cmp [ReadAttempts], byte 3
    je ReadDiskError

    jmp ReadDisk

  .Exit:
    mov [ReadAttempts], byte 0
    ret

SearchFile:
  push si
  xor ax, ax
  mov es, ax

  mov di, RootDirMemLocation
  mov ax, word [RootDirEntries]
  mov dx, si

  .NextEntry:
    push di
    dec ax
    mov si, dx 
    mov cx, 11 

    repe cmpsb

    pop di
    je .Exit
    add di, word 32 
    cmp ax, word 0
    jne .NextEntry
    mov ah, 1
    .Exit:
      mov dx, 0x7e0
      mov es, dx
      pop dx
      xor ah, ah
      mov cx, di
      ret

LoadFile:
  xor ax, ax
  mov es, ax
  add di, word 0x1a
  mov ax, word [es:di]

  mov word [CurrentCluster], ax 
  add word [FileOffset], bx

  mov ax, 0x7e0
  mov es, ax

  .LoadCluster:
    mov ax, word [CurrentCluster]
    add ax, 31
    call LbaToChs

    mov bx, word [FileOffset]
    mov al, byte SectorsPerCluster
    call ReadDisk

    mov ax, word [CurrentCluster]
    mov dx, ax
    mov cx, ax
    shr cx, 1 
    add ax, cx
    mov bx, FATMemLocation
    add bx, ax
    mov ax, word [bx]

    test dx, 1
    jz .EvenCluster

    .OddCluster:
      shr ax, 4
      jmp .Continue

    .EvenCluster:
      and ax, 0xfff

    .Continue:
      mov word [CurrentCluster], ax
      cmp ax, word 0xfff
      jae .FileLoaded
      add word [FileOffset], 512
      jmp .LoadCluster

    .FileLoaded:
      mov word [FileOffset], KernelOffset
      ret
LbaToChs:
  push ax
  mov dx, 0
  div word [SectorsPerTrack]
  inc dl   
  mov byte [ChsSector], dl
  pop ax
  mov dx, 0
  div word [SectorsPerTrack]
  mov dx, 0
  div word [Heads]
  mov byte [ChsTrack], al
  mov byte [ChsHead], dl
  ret

ResetDisk:
    push ax
    mov ah, 0
    mov dl, [BootDisk]
    int 0x13
    pop ax
    ret


ReadDiskError:
  call PrintNewLine
  mov si, ReadDiskErrorMessage
  call PrintString
  jmp ReadDisk.Exit

BootDisk: db 0
CurrentCluster: dw 0
FileOffset: dw KernelOffset

ChsSector: db 0
ChsTrack: db 0
ChsHead: db 0

ReadAttempts: db 0
ReadDiskErrorMessage: db "Disk Error", 0
