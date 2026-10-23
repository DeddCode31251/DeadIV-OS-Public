; Welcome to DeadIV OS
; Made by deadcode
; Using NASM
; Architecture: x86
; Boot method: Legacy BIOS

[BITS 16]

[ORG 0x7C00]


start:
  jmp 0x0000: main
main:
  cli
  xor ax,ax
  mov ds,ax
  mov es,ax
  mov ss,ax

  mov sp, 0x7C00

  cld
  sti

  mov si,message

.print:
  lodsb
  test al,al
  jz .halt

  mov ah, 0x0E
  mov bh, 0x00

  int 0x10

  jmp .print

.halt:
  cli

.wait:
  hlt
  jmp .wait

message db 'DeadIV OS: BootLoader started!', 13,10,0
times 510 - ($ - $$) db 0
dw 0xAA55
