; Author: Noor Fatima
; Description: Sum all elements greater than 50 in an array using Irvine32 library

include Irvine32.inc

.data
array   DWORD 10, 60, 25, 71, 48, 72, 18   ; Sample array of integers
sample  DWORD 50                          ; Threshold value
size    DWORD LENGTHOF array              ; Total number of elements (7)
index   DWORD 0                           ; Index for loop iteration
sum     DWORD 0                           ; To store the final result (sum)

.code
main:
    mov ecx, size             ; Load total size of array into ECX (loop limit)
    mov esi, 0                ; ESI = index = 0
    mov eax, 0                ; EAX will hold the sum

LoopStart:
    cmp esi, ecx              ; if (index >= size)?
    jge EndLoop               ; if index >= size, exit loop

    ; Load array[index] into EBX
    mov ebx, array[esi*4]     ; Multiply index by 4 (DWORD = 4 bytes)

    ; Compare with sample value (50)
    cmp ebx, sample
    jle SkipAdd               ; if array[index] <= 50, skip addition

    ; Add element to sum
    add eax, ebx              ; sum += array[index]

SkipAdd:
    inc esi                   ; index++
    jmp LoopStart             ; repeat the loop

EndLoop:
    mov sum, eax              ; Save result in sum variable

    ; Display the sum on console
    mov eax, sum              ; Load sum into EAX
    call WriteInt             ; Print the integer value
    call Crlf                 ; Move to next line

    exit                      ; Exit program

end main
