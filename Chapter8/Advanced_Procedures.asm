; Creating Stack Frame
push ebp         ; Save the base pointer
mov ebp, esp     ; Set base pointer
sub esp, 8       ; Reserve space for local vars

; Pass by Value Example
push 5
push 6
call AddTwo

; Pass by Reference Example
push offset val1
push offset val2
call Swap

; Local Variables in Procedures
sub esp, 8         ; Allocate space
mov [ebp-4], 10    ; Assign value
mov [ebp-8], 20

; Recursive Example: Factorial
factorial PROC
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]
    cmp eax, 0
    je L1
    dec eax
    push eax
    call factorial
L1:
    pop ebp
    ret 4
factorial ENDP

; INVOKE and ADDR Examples
INVOKE procedureName, argument1, argument2
INVOKE procedureName, ADDR var1

; PROC and PROTO Example
MySub PROTO
MySub PROC
    ; Code
    ret
MySub ENDP

; Java Bytecode Example (for reference/documentation)
; The following is not valid x86 Assembly but included for completeness
; iload_1
; iload_2
; iadd
; istore_3
