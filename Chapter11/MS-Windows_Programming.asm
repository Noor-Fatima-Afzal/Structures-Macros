; MS-Windows Programming in Assembly Language
; Presented by: Noor Fatima
; To: Dr. Asim Rehmat

INCLUDE Irvine32.inc  ; Include Irvine Library for easy access to standard input/output functions

.data
    message BYTE "Hello, World!", 0
    buffer BYTE 128 DUP(0)
    filename BYTE "sample.txt", 0
    errorMsg BYTE 128 DUP(0)
    errorTitle BYTE "Error", 0
    bytesRead DWORD ?
    consoleHandle DWORD ?
    consoleInHandle DWORD ?
    saveFlags DWORD ?
    hWnd DWORD ?
    msg MSG
    className BYTE "WindowClass", 0
    windowName BYTE "Sample Window", 0

.code

; Console Output Example
ConsoleOutput:
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    MOV consoleHandle, EAX
    INVOKE WriteConsole, consoleHandle, ADDR message, 20, ADDR bytesRead, 0

; Single Character Input Example
SingleCharInput:
    INVOKE GetConsoleMode, consoleInHandle, ADDR saveFlags
    INVOKE SetConsoleMode, consoleInHandle, 0
    INVOKE ReadConsole, consoleInHandle, ADDR buffer, 1, ADDR bytesRead, 0
    INVOKE SetConsoleMode, consoleInHandle, saveFlags

; Creating a Window Example
CreateWindowExample:
    WinMain PROC
        INVOKE CreateWindowEx, 0, ADDR className, ADDR windowName, 0, 0, 0, 640, 480, 0, 0, 0, 0
        MOV hWnd, EAX
        INVOKE ShowWindow, hWnd, SW_SHOWNORMAL
        INVOKE UpdateWindow, hWnd
        INVOKE GetMessage, ADDR msg, NULL, 0, 0
        INVOKE DispatchMessage, ADDR msg
    WinMain ENDP

; Dynamic Memory Allocation Example
DynamicMemoryAllocation:
    INVOKE HeapCreate, 0, HEAP_START, HEAP_MAX
    MOV hHeap, EAX
    INVOKE HeapAlloc, hHeap, HEAP_ZERO_MEMORY, 1000
    MOV pArray, EAX
    INVOKE HeapFree, hHeap, 0, pArray

; File Reading Example
FileReadingExample:
    INVOKE CreateFile, ADDR filename, GENERIC_READ, 0, NULL, OPEN_EXISTING, 0, NULL
    MOV hFile, EAX
    INVOKE ReadFile, hFile, ADDR buffer, 1024, ADDR bytesRead, NULL

; Error Handling Example
ErrorHandling:
    INVOKE GetLastError
    MOV messageID, EAX
    INVOKE FormatMessage, FORMAT_MESSAGE_FROM_SYSTEM, messageID, ADDR errorMsg
    INVOKE MessageBox, NULL, ADDR errorMsg, ADDR errorTitle, MB_ICONERROR
    INVOKE LocalFree, errorMsg

; End of the Program
exit:
    INVOKE ExitProcess, 0
end
