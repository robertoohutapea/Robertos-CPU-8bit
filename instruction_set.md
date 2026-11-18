# Instruction Set Architecture

## Instruction Width

16 bits.

## R-Type Format

[15:12] Opcode
[11:10] RD
[9:8]   RA
[7:6]   RB
[5:0]   Unused

## I-Type Format

[15:12] Opcode
[11:10] RD
[9:8]   Unused
[7:0]   Immediate / Address

## Opcodes

0000 - NOP
0001 - ADD
0010 - SUB
0011 - AND
0100 - OR
0101 - XOR
0110 - NOT
0111 - ADDI
1000 - LDI
1001 - LOAD
1010 - STORE
1011 - JMP
1111 - HALT

## Operation Description

ADD:
RD = RA + RB

SUB:
RD = RA - RB

AND:
RD = RA AND RB

OR:
RD = RA OR RB

XOR:
RD = RA XOR RB

NOT:
RD = NOT RA

ADDI:
RD = RA + Immediate

LDI:
RD = Immediate

LOAD:
RD = DataMemory[Address]

STORE:
DataMemory[Address] = RD

JMP:
PC = Address

HALT:
Stop processor execution.
