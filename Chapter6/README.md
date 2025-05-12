
# Conditional Processing in Assembly Language

This repository contains examples of conditional processing in **x86 Assembly Language**, as presented by **Noor Fatima** to **Prof. Dr. Asim Rehmat**. The concepts are demonstrated through simple, well-commented code snippets, showcasing how decisions and loops can be implemented at the assembly level.

---

## 📁 File Structure

- `conditional_processing_examples.asm`  
  A single file containing multiple examples of conditional processing, including:
  - Finite-State Machine (FSM) transitions
  - Comparisons with `CMP` and conditional jumps like `JZ`
  - Bitwise checks (e.g., even/odd using `AND`)
  - Conditional loops using `LOOPNZ`

---

## 💡 Topics Covered

- **Comparison Instructions**: `CMP`, `TEST`
- **Conditional Jumps**: `JE`, `JZ`, `JG`, `JC`
- **Bitwise Operations**: `AND`
- **Loop Instructions**: `LOOPZ`, `LOOPNZ`
- **Finite-State Machines (FSMs)**

---

## 🛠 Usage

These examples are designed for educational purposes and can be assembled and run using any assembler that supports Intel x86 syntax (such as NASM).

### Example NASM Workflow:

```bash
nasm -f elf32 conditional_processing_examples.asm -o output.o
ld -m elf_i386 output.o -o output
./output
