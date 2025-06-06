1. mNewLine macro
mNewLine MACRO	; define the macro
	call Crlf
ENDM
.data

.code
mNewLine

2. mPutChar macro
mPutchar MACRO char
	push eax
	mov al,char
	call WriteChar
	pop eax
ENDM
.code
mPutchar 'A'

3. mWriteStr macro
mWriteStr MACRO buffer
	push edx
	mov  edx,OFFSET buffer
	call WriteString
	pop  edx
ENDM
.data
str1 BYTE "Welcome!",0
.code
mWriteStr str1

4. mReadStr macro
mReadStr MACRO varName
	push ecx
	push edx
	mov edx,OFFSET varName
	mov ecx,(SIZEOF varName) - 1
	call ReadString
	pop edx
	pop ecx
ENDM
.data
firstName BYTE 30 DUP(?)
.code
mReadStr firstName

5. mDumpMem macro
mDumpMem MACRO address, itemCount, componentSize
	push ebx
	push ecx
	push esi
	mov  esi,address
	mov  ecx,itemCount
	mov  ebx,componentSize
	call DumpMem
	pop  esi
	pop  ecx
	pop  ebx
ENDM
.data
	array DWORD 1,2,3,4,5,6,7,8 
.code
	mDumpMem OFFSET array,LENGTHOF array, TYPE array
	mov eax, 0aaaa1111h
	push eax
	mov eax, 0bbbb2222h
	push eax
	mov ebx, 1
	mov ecx, 2
	mov esi, 3
	mDumpMem esp, 8, TYPE DWORD


6. mWrite macromWrite MACRO text
	LOCAL string
	.data		;; data segment
	string BYTE text,0		;; define local string
	.code		;; code segment
	push edx
	mov  edx,OFFSET string
	call Writestring
	pop  edx
ENDM
; Example: Call mWrite
; Equivalent to:
;   mWrite "Line one"
;   mWriteLn "Line two"

.data
??0000 BYTE "Line one", 0
??0001 BYTE "Line two", 0

.code
; mWrite "Line one"
push edx
mov  edx, OFFSET ??0000
call Writestring
pop  edx

; mWriteLn "Line two"
push edx
mov  edx, OFFSET ??0001
call Writestring
pop  edx

7. Nested Macros
mWriteLn MACRO text
	mWrite text
	call Crlf
ENDM

mWriteLn "My Sample Macro Program"

2	.data
2	??0002 BYTE "My Sample Macro Program",0
2 	.code
2 	push edx
2 	mov  edx,OFFSET ??0002
2 	call Writestring
2 	pop  edx
1 	call Crlf
