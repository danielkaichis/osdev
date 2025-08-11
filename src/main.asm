%define ENDL 0x0D, 0x0A

org 0x7C00
bits 16

start:
  jmp main

; prints a string to the screen
; params:
;   ds:si points to a string
puts:
  ; save registers that are modified
  push si
  push ax

.loop:
  lodsb   ; load next value in al
  or al, al
  jz .done

  mov ah, 0x0E
  mov bh, 0
  int 0x10
  jmp .loop

.done:
  pop ax
  pop si
  ret


main:
  ; setup data segments
  mov ax, 0
  mov ds, ax
  mov es, ax

  ; setup stack
  mov ss, ax
  mov sp, 0x7C00

  mov si, hello_msg
  call puts

  hlt

.halt:
  jmp .halt

hello_msg: db "Hello World!", ENDL, 0

times 510-($-$$) db 0 
dw 0x0AA55
