[org 0x7c00]
[bits 16]
[cpu 286]
jmp short Start
nop

OEMidentifier: db "NabOS "
BytesPerSector: dw 512
SectorsPerCluster: db 1
ReservedSectors: dw 1 
NumberOfFATs: db 2 
RootDirEntries: dw 224 
LogicalSectors: dw 2880 
MediaDescriptor: db 0xF0
SectorsPerFAT: dw 9
SectorsPerTrack: dw 18
Heads: dw 2
HiddenSectors: dd 0
LargeSectors: dd 0 

DriveNumber: dw 0
Signature: db 0x29
VolumeId: dd 0
VolumeLabel: db "NabOS     "
FileSystem: db "FAT12   "

Start:
  cli
  jmp 0x0000:Main

Main:
  mov byte[BootDisk], dl
  xor ax, ax
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov ss, ax
  mov sp, 0x7c00
  sti
  call GetMemoryAvailable
  jmp LoadFAT
  call SearchKernel
  cli
  hlt

%include "./BootLoader/Print.asm"
%include "./BootLoader/Disk.asm"
%include "./BootLoader/Memory.asm"

times 510-($-$$) db 0
dw 0xaa55
