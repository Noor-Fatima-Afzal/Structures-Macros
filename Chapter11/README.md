# MS-Windows Programming in Assembly Language

This project demonstrates programming in assembly for MS-Windows, with examples for Win32 Console Programming, Windows API and SDK usage, console input/output handling, graphical window applications, memory management, file manipulation, and error handling.

## Overview

The following topics are covered in the assembly code:

- Win32 Console Programming
- Windows API and SDK
- Console Input Handling
- Graphical Windows Applications
- Memory Management
- x86 Memory Management
- File Manipulation
- Error Handling

## Requirements

To run the provided assembly code, you will need:

- **MASM** (Microsoft Macro Assembler)
- **Irvine32 Library** (used for input/output operations)

Ensure that you have these tools set up on your machine to successfully compile and execute the assembly code.

## Code Description

### 1. **Console Output Example**
   - Demonstrates how to output text to the console using the Windows API.
   - Uses `WriteConsole` to print the message `"Hello, World!"`.

### 2. **Single Character Input Example**
   - Shows how to capture single-character input from the user using `ReadConsole`.
   - Includes setting the console mode to allow reading one character at a time.

### 3. **Creating a Window Example**
   - A basic example of creating a graphical window using Windows API functions such as `CreateWindowEx`, `ShowWindow`, and `GetMessage`.
   - Demonstrates setting up a basic message loop to handle window events.

### 4. **Dynamic Memory Allocation Example**
   - Demonstrates memory allocation using `HeapCreate` and `HeapAlloc` for dynamic memory management.
   - Shows how to free memory with `HeapFree`.

### 5. **File Reading Example**
   - Shows how to read a file using the Windows API's `CreateFile` and `ReadFile` functions.
   - Useful for file input operations in assembly programs.

### 6. **Error Handling Example**
   - Demonstrates how to handle errors in a Windows environment.
   - Uses `GetLastError`, `FormatMessage`, and `MessageBox` to retrieve and display error messages.

## How to Run

1. **Setup MASM**: Ensure you have MASM installed on your system. You can download it from the official Microsoft website or use an IDE like Visual Studio that includes it.
   
2. **Compile the Code**:
   - Open a command prompt or terminal.
   - Navigate to the directory where the `.asm` file is located.
   - Run the following commands to assemble and link the code:
   
     ```bash
     ml /c /coff program.asm
     link /subsystem:console program.obj
     ```

3. **Execute the Program**:
   - After linking, run the output executable (`program.exe`) from the command line to see the results.

## Additional Resources

- [Irvine32 Library Documentation](http://www.kipirvine.com/asm/gettingstarted.php) for detailed information on the functions used in the examples.
- [MASM Documentation](https://docs.microsoft.com/en-us/cpp/assembler/masm/masm-reference) for assembly language syntax and API references.

## License

This project is provided for educational purposes under the [MIT License](LICENSE).

## Contact

If you have any questions or feedback, feel free to reach out.

**Author**: Noor Fatima  
**Instructor**: Dr. Asim Rehmat
