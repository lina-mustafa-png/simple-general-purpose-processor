# Simple General-Purpose Processor (VHDL)

This project is a simple general-purpose processor designed and implemented using **VHDL** in **Intel Quartus** as part of a Digital Systems laboratory. The processor integrates storage units, a control unit, and an ALU to perform a sequence of arithmetic and logical operations on two 8-bit inputs.

The design was fully simulated using Quartus’ Waveform Editor and implemented as a modular, hierarchical system.

---

## High-Level Architecture

The processor is composed of four main components known from a typical processing unit:

- **Storage Units (Registers)**  
  Two 8-bit registers store inputs A and B. Values are latched on the rising edge of the clock and forwarded to the ALU.

- **Control Unit**  
  Implemented using a Finite State Machine (FSM) and a 4-to-16 decoder.  
  The FSM cycles through states, and the decoder converts each state into a 16-bit microcode that selects the ALU operation.

- **ALU Core**  
  Performs arithmetic and logical operations such as addition, subtraction, AND, OR, XOR, inversion, and modified operations depending on the assigned problem set.

- **Display Unit**  
  The 8-bit ALU output is split and displayed using two seven-segment displays in hexadecimal format.

---

## Implemented Operations

The ALU supports multiple operations selected via microcode, including:

- Addition and subtraction
- Bitwise logic (AND, OR, XOR, XNOR, NAND, NOR)
- Bit inversion and shifts
- Rotations and comparison-based operations (problem-dependent)

Modified versions of the ALU were implemented to satisfy additional problem sets.

---

## Project Structure

src/
-- ALU.vhd -> ALU core implementation
-- ALU_mod.vhd -> Modified ALU based on problem set
-- ALU_prob3.vhd -> Modified ALU based on problem set
-- decoder.vhd -> 4-to-16 decoder
-- FSM.vhd -> Finite State Machine
-- latch1.vhd -> Register for input A
-- latch2.vhd -> Register for input B
-- sseg.vhd -> Seven-segment display logic
-- sseg_mod.vhd -> Modified seven-segment logic
-- GPU.bdf -> Top-level processor schematic
-- GPU_prob2.bdf -> Problem 2 top-level schematic
-- GPU_prob3.bdf -> Problem 3 top-level schematic
-- *.vwf -> Waveform simulations
