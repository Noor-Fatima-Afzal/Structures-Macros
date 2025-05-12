# Advanced Procedures in Assembly Language

This project contains example code illustrating advanced procedure handling in x86 Assembly Language, as presented in **Chapter 8: Advanced Procedures**.

## 📄 File Included

- `chapter8_advanced_procedures.asm`  
  This file demonstrates core procedure concepts using x86 assembly, including:
  - Stack frame creation
  - Argument passing (by value and by reference)
  - Local variables within procedures
  - Recursive procedures (e.g., factorial)
  - Usage of `INVOKE`, `ADDR`, `PROC`, and `PROTO` directives
  - Example structure for multi-module programs (via `PROTO` and `INCLUDE`)

## 🛠 Topics Covered

- **Stack Frames**: How to create and manage activation records using `ebp` and `esp`.
- **Parameter Passing**:
  - By Value: Using `push` for actual values.
  - By Reference: Using `offset` to pass addresses.
- **Local Variables**: Allocating memory on the stack using `sub esp, n`.
- **Recursion**: Demonstrates recursive factorial using proper stack management.
- **Procedure Directives**:
  - `INVOKE`, `ADDR`: For higher-level procedure calls.
  - `PROC`, `PROTO`: To define and declare procedures.
- **Java Bytecode (for comparison)**: Included as a conceptual contrast with stack-based JVM architecture.

## 🧠 Author

- **Noor Fatima**
- Prepared for **Dr. Asim Rehmat**

## 💡 Note

All the code snippets were extracted directly from a Beamer LaTeX presentation and compiled into a single `.asm` file. This project serves as a study resource for understanding structured assembly language programming.

