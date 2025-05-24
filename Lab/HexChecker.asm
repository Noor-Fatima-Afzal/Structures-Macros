; Author: Noor Fatima
; Description: FSM for hex integer constant in MASM syntax
;              Takes input from keyboard, validates hex constant ending with 'h' or 'H'

include Irvine32.inc

.data
    prompt BYTE "Enter a hex constant ending with h (e.g. 1Ah): $"  ; prompt message
    validMsg BYTE "Valid hex constant!$"                           ; message if input is valid
    invalidMsg BYTE "Invalid hex constant!$"                       ; message if input is invalid
    buffer BYTE 20 DUP(0)                                          ; buffer to store input string
    len DWORD ?                                                   ; variable to store length of input

.code
main PROC
    ; Display prompt message to user
    mov edx, OFFSET prompt
    call WriteString

    ; Read string from keyboard into buffer, max 20 chars
    mov edx, OFFSET buffer
    mov ecx, 20
    call ReadString

    ; ESI points to start of input buffer for easy indexing
    lea esi, buffer

    ; Find actual length of input string (until null terminator)
    mov ecx, 0                ; counter/index for length
FindLen:
    mov al, [esi + ecx]       ; get character at buffer[ecx]
    cmp al, 0                 ; check for null terminator (end of string)
    je CheckInput             ; if zero, end of input found
    inc ecx                  ; else increment length counter
    jmp FindLen              ; repeat loop

CheckInput:
    mov len, ecx              ; store input length

    ; Minimum length check:
    ; At least 2 chars needed (e.g., '1' + 'h')
    cmp ecx, 2
    jb InvalidInput           ; if less than 2, invalid input

    ; FSM start state:
    ; Check first character must be digit '0'-'9'
    mov al, [esi]             ; load first character
    call isDigit              ; call helper to check if digit
    cmp al, 1                 ; if not digit
    jne InvalidInput          ; jump to invalid

    ; FSM digits state:
    ; Check all characters except last one must be valid hex digits
    mov ecx, len              ; total length
    dec ecx                  ; exclude last character (suffix 'h'/'H')
    mov ebx, 1                ; index starting from second char

DigitsLoop:
    cmp ebx, ecx              ; if index >= length-1, exit loop
    jge CheckSuffix           ; done checking digits

    mov al, [esi + ebx]       ; get character at current index
    call isHexDigit           ; check if valid hex digit (0-9, A-F, a-f)
    cmp al, 1
    jne InvalidInput          ; if not, invalid input

    inc ebx                   ; next character
    jmp DigitsLoop            ; repeat loop

CheckSuffix:
    ; FSM suffix state:
    ; Check last character must be 'h' or 'H'
    mov al, [esi + len - 1]   ; last character in input
    cmp al, 'h'
    je ValidInput             ; if 'h', input valid
    cmp al, 'H'
    je ValidInput             ; if 'H', input valid

InvalidInput:
    ; Print invalid input message
    mov edx, OFFSET invalidMsg
    call WriteString
    jmp Exit                 ; exit program

ValidInput:
    ; Print valid input message
    mov edx, OFFSET validMsg
    call WriteString

Exit:
    call Crlf                ; print newline
    exit                     ; exit program

; ---- Helper procedures ----

; isDigit: Checks if AL contains '0' - '9'
; Returns AL = 1 if digit, else 0
isDigit PROC
    cmp al, '0'
    jb NotDigit
    cmp al, '9'
    ja NotDigit
    mov al, 1
    ret
NotDigit:
    mov al, 0
    ret
isDigit ENDP

; isHexDigit: Checks if AL is a valid hex digit:
; '0'-'9', 'A'-'F', or 'a'-'f'
; Returns AL = 1 if valid, else 0
isHexDigit PROC
    push eax                ; save EAX (which contains AL)
    call isDigit            ; check if digit '0'-'9'
    cmp al, 1
    je HexOk                ; if digit, good

    pop eax                 ; restore EAX to check letters
    mov al, [esp]           ; reload AL from stack (AL before call)
    cmp al, 'A'
    jb NotHex               ; below 'A', not hex
    cmp al, 'F'
    jbe HexOk               ; between 'A' and 'F' inclusive, good
    cmp al, 'a'
    jb NotHex               ; below 'a', not hex
    cmp al, 'f'
    jbe HexOk               ; between 'a' and 'f' inclusive, good

NotHex:
    mov al, 0
    ret

HexOk:
    mov al, 1
    ret
isHexDigit ENDP

main ENDP
end main
