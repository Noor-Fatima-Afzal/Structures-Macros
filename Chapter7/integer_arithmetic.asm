; Chapter 7 - Integer Arithmetic in Assembly Language
; Author: Noor Fatima
; Description: Example codes demonstrating integer arithmetic instructions in x86 Assembly

; -------------------------------
; Example: Shift Operations
; -------------------------------

mov al, 5        ; Load 5 into AL
shl al, 1        ; Shift left (multiply by 2)
sar al, 1        ; Arithmetic shift right (preserves sign)

; -------------------------------
; Example: Multiplication
; -------------------------------

mov ax, 100h     ; Load AX with 0x100
mov bx, 200h     ; Load BX with 0x200 (note: added for completeness)
mul bx           ; Multiply AX by BX (unsigned), result in DX:AX

; -------------------------------
; Example: Division
; -------------------------------

mov ax, 8003h    ; Load AX with dividend
mov bx, 100h     ; Load BX with divisor
div bx           ; Unsigned divide AX by BX, quotient in AX, remainder in DX

; -------------------------------
; Example: Extended Arithmetic
; -------------------------------

mov eax, 0FFFFFFFFh  ; Load EAX with max unsigned value (all bits set)
add eax, 1           ; Add 1 to EAX (causes overflow)
adc edx, 0           ; Add carry to EDX
