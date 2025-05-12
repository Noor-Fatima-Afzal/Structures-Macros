; ----------------------------------------
; Conditional Processing Examples in Assembly
; Author: Noor Fatima
; Presented to: Dr. Asim Rehmat
; ----------------------------------------

; -------------------------------
; Finite-State Machine Transition
; -------------------------------
StateA:
    cmp al, 'a'         ; Compare input with 'a'
    je StateB           ; Jump to StateB if input matches

; -------------------------------
; CMP and Conditional Jump (JZ)
; -------------------------------
mov al, 5
cmp al, 5
jz EqualValue           ; Jump if values are equal

; -------------------------------
; Check Even/Odd using AND
; -------------------------------
and al, 1               ; AND with 1 to isolate LSB
jz EvenNumber           ; Jump if even (ZF set)

; --------------------------------------------
; Loop Until Condition Met (LOOPNZ instruction)
; --------------------------------------------
mov ecx, 10             ; Set loop counter
L1: test eax, eax
    loopnz L1           ; Continue loop if eax is not zero

; -------------------------------
; Another FSM Example (repeated)
; -------------------------------
StateA:
    cmp al, 'a'         ; Compare input with 'a'
    je StateB           ; Jump to StateB if input matches

; -------------------------------
; End of Examples
; -------------------------------
