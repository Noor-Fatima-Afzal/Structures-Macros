; MS-Windows Programming in Assembly Language
; Presented by: Noor Fatima
; To: Dr. Asim Rehmat

INCLUDE Irvine32.inc           ; Include Irvine32 library for simplified I/O and Windows functions

.data
    message BYTE "Hello, World!", 0        ; Message to display on the console
    buffer BYTE 128 DUP(0)                 ; Input/output buffer of 128 bytes initialized to 0
    filename BYTE "sample.txt", 0          ; Filename to read from
    errorMsg BYTE 128 DUP(0)               ; Buffer to store error message
    errorTitle BYTE "Error", 0             ; Title of the error message box
    bytesRead DWORD ?                      ; Variable to store number of bytes read or written
    consoleHandle DWORD ?                  ; Handle to console output
    consoleInHandle DWORD ?                ; Handle to console input
    saveFlags DWORD ?                      ; Variable to save original console input mode flags
    hWnd DWORD ?                           ; Handle to the window created
    msg MSG                                ; Message structure for the message loop
    className BYTE "WindowClass", 0        ; Name of the window class
    windowName BYTE "Sample Window", 0     ; Title of the window

.code

; ---------------------------------------------------------
; Console Output Example
; ---------------------------------------------------------
ConsoleOutput:
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE         ; Get handle to standard output (console screen)
    MOV consoleHandle, EAX                         ; Store the returned handle in consoleHandle
    INVOKE WriteConsole, consoleHandle, ADDR message, 20, ADDR bytesRead, 0 
        ; Write "Hello, World!" (20 bytes) to the console

; ---------------------------------------------------------
; Single Character Input Example (without echo)
; ---------------------------------------------------------
SingleCharInput:
    INVOKE GetConsoleMode, consoleInHandle, ADDR saveFlags  ; Save current console input mode
    INVOKE SetConsoleMode, consoleInHandle, 0               ; Disable echo and line input
    INVOKE ReadConsole, consoleInHandle, ADDR buffer, 1, ADDR bytesRead, 0 
        ; Read 1 character from console without requiring Enter
    INVOKE SetConsoleMode, consoleInHandle, saveFlags       ; Restore original console mode

; ---------------------------------------------------------
; Creating a Simple Window Example
; ---------------------------------------------------------
CreateWindowExample:
    WinMain PROC
        INVOKE CreateWindowEx, 0, ADDR className, ADDR windowName, 0, 0, 0, 640, 480, 0, 0, 0, 0
            ; Create a window with given class name, title, and size (640x480)
        MOV hWnd, EAX                                ; Store the window handle
        INVOKE ShowWindow, hWnd, SW_SHOWNORMAL       ; Show the window
        INVOKE UpdateWindow, hWnd                    ; Refresh the window to trigger paint message
        INVOKE GetMessage, ADDR msg, NULL, 0, 0      ; Start the message loop: get next message
        INVOKE DispatchMessage, ADDR msg             ; Send the message to the window procedure
    WinMain ENDP

; ---------------------------------------------------------
; Dynamic Memory Allocation Example using Heap
; ---------------------------------------------------------
DynamicMemoryAllocation:
    INVOKE HeapCreate, 0, HEAP_START, HEAP_MAX       ; Create a heap with initial and max size
    MOV hHeap, EAX                                   ; Store the handle to the new heap
    INVOKE HeapAlloc, hHeap, HEAP_ZERO_MEMORY, 1000  ; Allocate 1000 bytes and zero them out
    MOV pArray, EAX                                  ; Store pointer to allocated memory
    INVOKE HeapFree, hHeap, 0, pArray                ; Free the allocated memory

; ---------------------------------------------------------
; File Reading Example
; ---------------------------------------------------------
FileReadingExample:
    INVOKE CreateFile, ADDR filename, GENERIC_READ, 0, NULL, OPEN_EXISTING, 0, NULL
        ; Open file "sample.txt" for reading
    MOV hFile, EAX                                   ; Store the file handle
    INVOKE ReadFile, hFile, ADDR buffer, 1024, ADDR bytesRead, NULL
        ; Read up to 1024 bytes into buffer from file

; ---------------------------------------------------------
; Error Handling Example
; ---------------------------------------------------------
ErrorHandling:
    INVOKE GetLastError                              ; Get the last error code from system
    MOV messageID, EAX                               ; Store it in messageID
    INVOKE FormatMessage, FORMAT_MESSAGE_FROM_SYSTEM, messageID, ADDR errorMsg
        ; Convert error code to readable message string
    INVOKE MessageBox, NULL, ADDR errorMsg, ADDR errorTitle, MB_ICONERROR
        ; Show the error message in a message box
    INVOKE LocalFree, errorMsg                       ; Free memory allocated for error message

; ---------------------------------------------------------
; End of the Program
; ---------------------------------------------------------
exit:
    INVOKE ExitProcess, 0                            ; Exit the program with return code 0

end
