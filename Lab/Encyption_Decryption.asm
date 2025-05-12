; Author: Noor Fatima
include irvine32.inc

.data
  KEY BYTE 239  ;XOR encryption key
  buffer BYTE 128 DUP(0)  ;Buffer to store user input
  prompt BYTE "Enter your message: $", 0
  encrypted_prompt BYTE "Encrypted message: $", 0
  decrypted_prompt BYTE "Decrypted message: $", 0

.code
main:
    mov edx, OFFSET prompt
    call WriteString
  
    ; Input message from user
    lea edx, buffer   ; Load address of buffer
    call ReadString

    ; ----------( Encrypt the message )----------
    lea esi, buffer + 1
    mov ecx, 128
EncryptLoop:
    mov al, [esi]
    cmp al, 0            ; Check for null terminator
    je EncryptDone       ; If null terminator, end loop
    xor al, KEY          ; XOR byte with key
    mov [esi], al        ; Store encrypted byte
    inc esi
    loop EncryptLoop
EncryptDone:
    ; Display encrypted message
    mov edx, OFFSET encrypted_prompt
    call WriteString
    lea edx, buffer + 1   ; Start of encrypted message
    call WriteString

    ; ----------( Decrypt the message )----------
    lea esi, buffer + 1   ; Skip first byte
    mov ecx, 128
DecryptLoop:
    mov al, [esi]
    cmp al, 0            ; Check for null terminator
    je DecryptDone       ; If null terminator, end loop
    xor al, KEY          ; XOR byte with key to decrypt
    mov [esi], al        ; Store decrypted byte
    inc esi
    loop DecryptLoop
DecryptDone:
    ; Display decrypted message
    mov edx, OFFSET decrypted_prompt
    call WriteString
    lea edx, buffer + 1   ; Start of decrypted message
    call WriteString

    ; Exit program
    exit
end main
