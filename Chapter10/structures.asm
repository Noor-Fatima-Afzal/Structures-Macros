1.Referencing Structure Variables: 

 Employee STRUCT
 IdNum    BYTE "000000000"  ; 9
 LastName BYTE 30 DUP(0)  ; 30
 ALIGN    WORD ; 1 byte added
 Years    WORD 0 ; 2
 ALIGN    DWORD  ; 2 bytes added
 SalaryHistory DWORD 0,0,0,0  ; 16
 Employee ENDS ; 60 total

 Given the data definition
 .data
 worker Employee <>

Each of the following expressions returns the same value:
 TYPE Employee  ; 60
 SIZEOF Employee  ; 60
 SIZEOF worker  ; 60
--------------------------------------------
2.Referencing by members
 .data
 worker Employee <>
 .code
 mov dx,worker.Years
 mov worker.SalaryHistory,20000  ; First salary
 mov [worker.SalaryHistory+4],30000  ; Second salary
--------------------------------------------
3.Loop through an array
 ; Loop Through Array    (AllPoints.asm)

 INCLUDE Irvine32.inc
 NumPoints = 3
 .data
 ALIGN WORD
 AllPoints COORD NumPoints DUP(<0,0>)
 .code
 main PROC
 mov edi,0  ; array index
 mov ecx,NumPoints   ; loop counter
 mov ax,1   ; starting X, Y values
 L1: mov (COORD PTR AllPoints[edi]).X,ax
 mov (COORD PTR AllPoints[edi]).Y,ax
 add edi,TYPE COORD
 inc ax
 loop L1
 exit
 main ENDP
 END main
--------------------------------------------
4. Displaying the system time

 MS-Windows provides console functions that set the screen cursor position and get the sys
tem time. To use these functions, create instances of two predefined structures—COORD and
 SYSTEMTIME:
 COORD STRUCT
 X WORD ?
 Y WORD ?
 COORD ENDS
 SYSTEMTIME STRUCT
    wYear WORD ?
    wMonth WORD ?
    wDayOfWeek WORD ?
    wDay WORD ?
    wHour WORD ?
    wMinute WORD ?
    wSecond WORD ?
    wMilliseconds WORD ?
 SYSTEMTIME ENDS

 .data
 sysTime SYSTEMTIME <>
 .code
 INVOKE GetLocalTime, ADDR sysTime
 movzx eax,sysTime.wYear
 call WriteDec
--------------------------------------------
5. Program Listing 
The following program (ShowTime.asm) retrieves the system time and dis
plays it at a selected screen location. It runs only in protected mode:

; Structures                               (ShowTime.ASM)
INCLUDE Irvine32.inc
.data
sysTime SYSTEMTIME <>
XYPos COORD <10,5>
consoleHandle DWORD ?
colonStr BYTE ":",0

.code
main PROC
    ; Get the standard output handle for the Win32 Console.
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov consoleHandle,eax

    ; Set the cursor position and get the system time.
    INVOKE SetConsoleCursorPosition, consoleHandle, XYPos
    INVOKE GetLocalTime, ADDR sysTime

    ; Display the system time (hh:mm:ss).
    movzx eax,sysTime.wHour              ; hours
    call WriteDec
    mov edx,OFFSET colonStr              ; ":"
    call WriteString
    movzx eax,sysTime.wMinute            ; minutes
    call WriteDec
    call WriteString
    movzx eax,sysTime.wSecond            ; seconds
    call WriteDec
    call Crlf
    call WaitMsg                         ; "Press any key..."
    exit
main ENDP
END main

 The following definitions were used by this program from SmallWin.inc (automatically
 included by Irvine32.inc):

 STD_OUTPUT_HANDLE EQU -11
 SYSTEMTIME STRUCT ...
 COORD STRUCT ...
 GetStdHandle PROTO,
 nStdHandle:DWORD
 GetLocalTime PROTO,
 lpSystemTime:PTR SYSTEMTIME
 SetConsoleCursorPosition PROTO,
 nStdHandle:DWORD,
 coords:COORD
--------------------------------------------

6. Drunkard’s Walk (Walk.asm)
; Drunkard’s Walk program. The professor starts at
; coordinates 25, 25 and wanders around the immediate area.

INCLUDE Irvine32.inc

Walks = 50
MaxCols = 10
StartX = 25
StartY = 25

DrunkardWalk STRUCT
    path COORD Walkies[10][5]
    pathUsed DWORD ?
DrunkardWalk ENDS

DrunkardsWalk PROTO
DisplayPosition PROTO curX:WORD, curY:WORD

.data
dWalk DrunkardWalk <>

.code
main PROC
    call DrunkardsWalk
    exit
main ENDP

DrunkardsWalk PROC
    LOCAL curX:WORD, curY:WORD
;
; Takes a walk in random directions (north, south, east, west)
; Receives: ESI points to a DrunkardWalk structure
; Returns: The structure is initialized with random values
;
    ; use the OFFSET operator to obtain the address of the
    ; path, the array of COORD objects, and copy it to ESI.
    mov esi, OFFSET dWalk
    add esi, OFFSET DrunkardWalk.path     ; path pointer
    mov eax, StartX                       ; current X-location
    mov curX, eax
    mov eax, StartY                       ; current Y-location
    mov curY, eax

Again:
    ; Insert current location in array.
    mov eax, curX
    mov DWORD PTR [esi],1,AX
    mov eax, curY
    mov DWORD PTR [esi+2],AX

    ; Choose a direction (0–3)
    call RandomRange
    mov eax,4
    call RandomRange
    .IF eax == 0
        inc curY     ; North
    .ELSEIF eax == 1
        dec curY     ; South
    .ELSEIF eax == 2
        inc curX     ; East
    .ELSE
        dec curX     ; West
    .ENDIF

    add esi, TYPE COORD     ; point to next COORD
    inc ebx                 ; count steps taken
    cmp ebx, Walks
    jl Again

Finish:
    mov (DrunkardWalk PTR [esi]).pathUsed, Walks
    ret
DrunkardsWalk ENDP

DISPLAY POSITION PROCEDURE
DisplayPosition PROC curX:WORD, curY:WORD
; Display the current X and Y positions.

.data
commaStr BYTE ",",0

.code
    movzx eax,curX         ; current X position
    call WriteDec
    mov edx, OFFSET commaStr
    call WriteString
    movzx eax,curY         ; current Y position
    call WriteDec
    ret
DisplayPosition ENDP
