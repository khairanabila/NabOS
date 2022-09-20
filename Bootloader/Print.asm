[bits 16]
[cpu 286]
PrintString:
  push ax
  mov ah, 0x0e 

  .Loop:
    lodsb 

    cmp al, byte 0
    je .Exit

    int 0x10

    jmp .Loop

  .Exit:
    pop ax
    ret

PrintNewLine:
  push ax
  mov ah, 0x0e
  mov al, 10
  int 0x10

  mov al, 13
  int 0x10

  pop ax

  ret

