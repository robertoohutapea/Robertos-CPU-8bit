# CPU Architecture

## 1. Overview

Roberto's CPU is a simple single-cycle 8-bit processor.

The processor uses:
- 8-bit data width
- 16-bit instruction width
- 8-bit program addressing
- Four general-purpose registers

## 2. Main Components

### Program Counter
Maintains the address of the current instruction.

### Instruction Memory
Stores the processor instruction program.

### Instruction Decoder
Extracts the opcode, register addresses,
and immediate values.

### Control Unit
Generates control signals based on the instruction opcode.

### Register File
Provides four 8-bit general-purpose registers.

### ALU
Performs arithmetic and logical operations.

### Data Memory
Stores and retrieves 8-bit data.

## 3. Execution Flow

1. Fetch instruction from Instruction Memory.
2. Decode the instruction.
3. Read source registers.
4. Execute ALU or memory operation.
5. Write results into the Register File.
6. Update Program Counter.
7. Stop when HALT is executed.

## 4. Architecture Type

Single-cycle execution.

Each supported instruction is designed to complete
within one active clock cycle.
