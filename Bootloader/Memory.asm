[bits 16]
[cpu 286]
MemoryAvaiable: dw 0
GetMemoryAvaiable:
  mov ax, 0
  int 0x12
  mov [MemoryAvaiable], ax 
  ret