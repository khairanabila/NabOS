[bits 16]
[cpu 286]
EditTopBar: db "                            Edit v0.0.1 by Khairanabilla", 0
EditNote: db "                  Masih dibuat belum tersedia", 0
EditNote1: db "                                             Tekan apapun untuk keluar :)", 0



EditProgram:
  call VgaClearScreen
  mov si, EditTopBar
  xor ah, ah
  call VgaPrintString

  mov al, 0x8f
  call VgaPaintLine

  mov al, 6
  call VgaNewLine

  mov si, EditNote
  xor ah, ah
  call VgaPrintString

  mov si, EditNote1
  mov ah, 0xe
  call VgaPrintString

  mov ah, 0
  int 0x16

  ret