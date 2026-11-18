# Roberto's CPU 8-bit

An educational 8-bit CPU implementation using Verilog HDL.

## Architecture

- Single-cycle CPU architecture
- 8-bit data path
- 16-bit instruction format
- 4 general-purpose registers
- 8-bit Program Counter
- 256 x 16-bit Instruction Memory
- 256 x 8-bit Data Memory
- Arithmetic Logic Unit (ALU)
- Instruction Decoder
- Control Unit

## Components

| Module | Description |
|---|---|
| alu_8bit | Arithmetic and logical operations |
| register_file | Four 8-bit registers |
| program_counter | Instruction address management |
| instruction_memory | Instruction ROM |
| instruction_decoder | Instruction field extraction |
| control_unit | CPU control signals |
| data_memory | Data storage |
| cpu_8bit | Top-level CPU integration |

## Instruction Set

| Opcode | Instruction |
|---|---|
| 0000 | NOP |
| 0001 | ADD |
| 0010 | SUB |
| 0011 | AND |
| 0100 | OR |
| 0101 | XOR |
| 0110 | NOT |
| 0111 | ADDI |
| 1000 | LDI |
| 1001 | LOAD |
| 1010 | STORE |
| 1011 | JMP |
| 1111 | HALT |

## Demo Program

LDI R0, 10
LDI R1, 5
ADD R2, R0, R1
STORE R2, 0x10
LOAD R3, 0x10
HALT

Expected results:
- R0 = 10
- R1 = 5
- R2 = 15
- Memory[0x10] = 15
- R3 = 15
- CPU halted = 1

## Testing

Each module has an independent Verilog testbench.

The CPU integration testbench verifies the execution
of the complete demonstration program.

## Tools

- Verilog HDL
- Icarus Verilog compatible RTL style
- Peruri Chip Design Platform
