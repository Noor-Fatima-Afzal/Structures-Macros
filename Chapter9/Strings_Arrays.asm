; Example of Strings and Arrays in x86 Assembly
INCLUDE Irvine32.inc

.data
    msg1 BYTE "Hello, World!", 0  ; Null-terminated string
    msg2 BYTE "Welcome to Assembly Programming!", 0
    array DWORD 10, 20, 30, 40, 50  ; Array of DWORDs
    arraySize DWORD 5

.code
main:
    ; Print msg1
    MOV EDX, OFFSET msg1
    CALL WriteString

    ; Print a new line
    CALL Crlf

    ; Print msg2
    MOV EDX, OFFSET msg2
    CALL WriteString

    ; Print a new line
    CALL Crlf

    ; Access elements of the array and print them
    MOV ECX, 0             ; Initialize index to 0
    MOV EDX, OFFSET array  ; Point to the array
    MOV EBX, arraySize     ; Store the size of the array

printArray:
    ; Check if ECX is less than arraySize
    CMP ECX, EBX
    JGE done

    ; Load the array element into EAX
    MOV EAX, [EDX + ECX * 4]  ; Access array[ECX] (each element is 4 bytes)

    ; Print the array element
    CALL WriteDec

    ; Print a space after the number
    CALL WriteString, OFFSET space

    ; Increment index
    INC ECX
    JMP printArray

done:
    ; Exit the program
    EXIT
