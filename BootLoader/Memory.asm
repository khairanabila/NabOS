[bits 16]
[cpu 286]
MemoryAvailable: dw 0
GetMemoryAvailable:
  mov ax, 0
  int 0x12
  mov [MemoryAvailable], ax
  ret
