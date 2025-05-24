; ===========================
; String Instructions Demo
; Author: Noor Fatima
; Description: Demonstration of MOVSx, CMPSx, SCASx, STOSx, LODSx
; ===========================

; Assuming 32-bit flat memory model (MASM/TASM syntax)
.model flat, stdcall
.stack 4096
.data

; Source and destination strings for MOVSB/CMPSB
srcStr      db 'hello', 0
srcStr2     db 'heppo', 0
dstStr      db 5 dup(?)

; String for SCASB
scanStr     db 'hello', 0

; Buffer for STOSB
buffer      db 10 dup(?)

; String for LODSB
lodStr      db 'cat', 0

; ============================================
.code
main proc

; -------------------------
; 1. MOVSB: Copy 5 bytes from srcStr to dstStr
; -------------------------
    cld                             ; Clear direction flag
    mov esi, offset srcStr          ; ESI points to source string
    mov edi, offset dstStr          ; EDI points to destination
    mov ecx, 5                      ; Number of bytes to move
    rep movsb                       ; Copy string byte-by-byte

; -------------------------
; 2. CMPSB: Compare srcStr with srcStr2
; -------------------------
    cld
    mov esi, offset srcStr          ; First string
    mov edi, offset srcStr2         ; Second string
    mov ecx, 5
    repe cmpsb                      ; Compare until mismatch or ECX=0
    ; After this, ZF=0 if mismatch found

; -------------------------
; 3. SCASB: Scan scanStr for character 'l'
; -------------------------
    cld
    mov edi, offset scanStr
    mov ecx, 5
    mov al, 'l'
    repne scasb                     ; Find 'l' in scanStr

; -------------------------
; 4. STOSB: Fill buffer with 0 (like memset)
; -------------------------
    cld
    mov edi, offset buffer
    mov al, 0                       ; Fill value
    mov ecx, 10                     ; Number of bytes
    rep stosb                       ; Store AL into [EDI]

; -------------------------
; 5. LODSB: Load bytes from lodStr into AL
; -------------------------
    cld
    mov esi, offset lodStr
    lodsb                           ; AL = 'c'
    lodsb                           ; AL = 'a'
    ; etc...

    ret
main endp
end main
