# x86 Assembly Programming (MASM)

This repository contains low-level programming projects developed in x86 Assembly using the Microsoft Macro Assembler (MASM). The content is divided between academic laboratory work and custom implementations of more advanced algorithmic challenges.

## Project Structure

* **`lab_work/`**: A collection of laboratory assignments focused on fundamental computer architecture concepts, including:
    * Basic arithmetic and logic operations.
    * Interrupt handling and BIOS/DOS services.
    * Memory addressing modes.
    * Stack operations and procedure calls.
* **`advanced_implementations/`**: Independent scripts solving more complex problems, such as:
    * Efficient string and array processing.
    * Bitwise optimizations.
    * Custom algorithms implemented directly in assembly for performance and educational purposes.

## Tech Stack

* **Architecture:** x86
* **Assembler:** MASM (Microsoft Macro Assembler)
* **Environment:** DOSBox / Native Windows Console

## Key Concepts Covered

* **Register Management:** Optimized use of general use and segment registers.
* **Control Flow:** Implementing loops, conditional jumps, and subroutines without high-level abstractions.
* **I/O Device Interaction:** Handling input/output operations via BIOS/DOS interrupts within the DOSBox environment.
* **Floating-Point Unit (FPU):** Implementing mathematical operations using the x87 instruction set and the FPU stack.
* **SSE Operations:** Utilizing Streaming SIMD Extensions for parallel data processing and performance optimization.
* **Low-level Debugging:** Understanding memory dumps, flags, and CPU state during execution.

## How to Run

To assemble and link the programs, you will need `masm.exe` and `link.exe` (from the MASM package, also available in the tools directory).
