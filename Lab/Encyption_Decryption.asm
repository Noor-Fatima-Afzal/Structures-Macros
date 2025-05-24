; Author: Noor Fatima
include irvine32.inc       ; Include the Irvine32 library for input/output functions

.data
  KEY BYTE 239             ; XOR encryption key (used to encrypt/decrypt characters)
  buffer BYTE 128 DUP(0)   ; Buffer to store the user's input (128 bytes, initialized to 0)
  prompt BYTE "Enter your message: $", 0          ; Prompt for user input
  encrypted_prompt BYTE "Encrypted message: $", 0 ; Message to show before displaying encrypted text
  decrypted_prompt BYTE "Decrypted message: $", 0 ; Message to show before displaying decrypted text

.code
main:
    mov edx, OFFSET prompt ; Load address of prompt into EDX
    call WriteString       ; Display the prompt: "Enter your message: "

    ; --------( Input message from user )--------
    lea edx, buffer        ; Load address of buffer into EDX
    call ReadString        ; Read user input and store it in buffer

    ; --------( Encrypt the message )--------
    lea esi, buffer + 1    ; Load address of first character in input (skip length byte) into ESI
    mov ecx, 128           ; Set loop counter to maximum buffer size

EncryptLoop:
    mov al, [esi]          ; Load a byte from buffer into AL
    cmp al, 0              ; Check if the byte is the null terminator
    je EncryptDone         ; If yes, jump to the end of encryption loop
    xor al, KEY            ; XOR the byte with the encryption key (simple encryption)
    mov [esi], al          ; Store the encrypted byte back into buffer
    inc esi                ; Move to the next byte in the buffer
    loop EncryptLoop       ; Decrement ECX and repeat loop if not zero

EncryptDone:
    ; --------( Display encrypted message )--------
    mov edx, OFFSET encrypted_prompt ; Load address of "Encrypted message:" into EDX
    call WriteString                 ; Display the encrypted prompt
    lea edx, buffer + 1              ; Load address of encrypted message (skip length byte)
    call WriteString                 ; Display the encrypted message

    ; --------( Decrypt the message )--------
    lea esi, buffer + 1    ; Load address of encrypted message (skip length byte)
    mov ecx, 128           ; Set loop counter again to 128

DecryptLoop:
    mov al, [esi]          ; Load a byte from buffer into AL
    cmp al, 0              ; Check if the byte is the null terminator
    je DecryptDone         ; If yes, jump to end of decryption loop
    xor al, KEY            ; XOR the byte with the key again (to decrypt)
    mov [esi], al          ; Store the decrypted byte back into buffer
    inc esi                ; Move to the next byte
    loop DecryptLoop       ; Decrement ECX and loop if not zero

DecryptDone:
    ; --------( Display decrypted message )--------
    mov edx, OFFSET decrypted_prompt ; Load address of "Decrypted message:" into EDX
    call WriteString                 ; Display the decrypted prompt
    lea edx, buffer + 1              ; Load address of decrypted message
    call WriteString                 ; Display the decrypted message

    ; --------( Exit program )--------
    exit                  ; Terminate the program

end main                 ; Mark the end of the main procedure
