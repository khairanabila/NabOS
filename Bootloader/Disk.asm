[bits 16]
[cpu 286]

FATMemLocation equ 0x500
RootDirMemLocation equ 0x1700

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

LoadFAT:
    mov ax, word [ReservedSectors]
    call LbaToChs
    mov bx, FATMemLocation
    mov al, [SectorsPerFAT] 
    call ReadDisk

LoadRootDir:
    call GetRootDirInfo

    mov ax, word [RootDirStartPoint]
    call LbaToChs

    mov bx, RootDirMemLocation
    mov al, [RootDirSize] 
    call ReadDisk

SearchKernel:
    mov di, RootDirMemLocation
    mov ax, word [RootDirEntries] 
    .NextEntry:
        push di
        dec ax

        mov si, KernelFileName 
        mov cx, 11
        repe cmpsb

        pop di 
        je LoadKernel

        add di, 32 
        cmp ax, word 0
        jne .NextEntry

        jmp ReadDiskError

LoadKernel:
    mov ax, word [di + 0x1a]
    mov word [CurrentCluster], ax 
    mov ax, 0x7e0
    mov es, ax
    mov bx, 0

    .LoadCluster:
        mov ax, word [CurrentCluster]
        add ax, 31

        call LbaToChs

        mov bx, word [KernelOffset]
        mov al, byte [SectorsPerCluster]
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
            jae .KernelLoaded

            add word [KernelOffset], 512
            jmp .LoadCluster


        .KernelLoaded:
            mov ah, 0
            mov al, 3
            int 0x10

            mov dl, byte [BootDisk]
            mov cx, word [MemoryAvaiable]

            jmp 0x7e0:0x0


ResetDisk:
    push ax

    mov ah, 0
    mov dl, [BootDisk]
    int 0x13

    pop ax

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

ClusterToLba:
    mov cx, 0
    mov dx, 0

    sub ax, 2
    mov cl, byte [SectorsPerCluster]
    mul cx

    ret

GetRootDirInfo:
    mov ax, 0
    mov dx, 0

    mov al, byte [NumberOfFATs]
    mul word [SectorsPerFAT]
    add ax, word [ReservedSectors]

    mov word [RootDirStartPoint], ax

    mov ax, 32 
    mul word [RootDirEntries]
    div word [BytesPerSector]

    mov word [RootDirSize], ax

    ret



ReadDiskError:
    mov si, ReadDiskErrorMessage
    call PrintString

    mov ah, 0
    int 0x16
    mov ah, 0
    int 0x19
BootDisk: db 0
RootDirSize: dw 0
RootDirStartPoint: dw 0
KernelFileName: db "KERNEL  BIN"
CurrentCluster: dw 0
KernelOffset: dw 0

ChsSector: db 0
ChsTrack: db 0
ChsHead: db 0

ReadAttempts: db 0
ReadDiskErrorMessage: db 10, 13, "Disk read error", 0