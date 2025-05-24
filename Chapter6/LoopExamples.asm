; Author: Noor Fatima
; Description: Examples of LOOPZ/LOOPE and LOOPNZ/LOOPNE instructions
;              with comments to aid understanding.

include irvine32.inc

.data
  count DWORD ?
  msg1 BYTE "LOOPZ/LOOPE example completed.", 0
  msg2 BYTE "LOOPNZ/LOOPNE example completed.", 0

.code
main:

; ==============================================================
; 🧪 LOOPZ / LOOPE Example
; Description: Loop while ECX ≠ 0 AND ZF == 1
; ==============================================================
  mov ecx, 5         ; Set loop counter
  mov eax, 0         ; EAX will be compared
  mov ebx, 0         ; EBX is the comparison value (equal to EAX)
LoopZ_example:
  cmp eax, ebx       ; Compare EAX and EBX → ZF = 1 (equal)
  loope LoopZ_example ; Loop if ZF = 1 and ECX ≠ 0
                      ; Same as LOOPZ
  ; When loop ends, display message
  mov edx, OFFSET msg1
  call WriteString
  call Crlf

; ==============================================================
; 🧪 LOOPNZ / LOOPNE Example
; Description: Loop while ECX ≠ 0 AND ZF == 0
; ==============================================================
  mov ecx, 5         ; Set loop counter
  mov eax, 1         ; EAX will be compared
  mov ebx, 0         ; EBX is different → ZF = 0
LoopNZ_example:
  cmp eax, ebx       ; Compare EAX and EBX → ZF = 0 (not equal)
  loopne LoopNZ_example ; Loop if ZF = 0 and ECX ≠ 0
                        ; Same as LOOPNZ
  ; When loop ends, display message
  mov edx, OFFSET msg2
  call WriteString
  call Crlf

  exit
end main
