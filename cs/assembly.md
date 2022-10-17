# Assembly Reference (x86)

An assembly language program instruction consists of two parts:
- Opcode
- Operand

Type of Adressing Modes:
- Immediate
- Direct Addressing
- Register Addressing

Registers
- Stack pointer: rsp (64), esp (32)
- Point pointer: rbp (64), ebp (32)

On an x64 chip, for the register RAX:
- RAX is the 64-bit register
- EAX is the 32-bit subset
- AX is the 16-bit subset
- AH, and AL are the 8-bit subsets

Stacks grow from high-mem address to lower mem-address on x86:
- `(ebp+4)` gets you the return address
- `(ebp+8)` gets you the first arg
- `(ebp+12)` gets you the second arg, etc...

Fastcall
- Fastcall is a way to call a subroutine with a convention of certain registers
- For gcc x64, the convention is:
  - `RDI`, `RSI`, `RDX`, `RCX`, `R8`, `R9`, `[XYZ]MM0–7` for args

Instructions:
- `lea` (Load Effective Address) - puts the memory adress 4-bytes before the stack-pointer into register rdi (e.g. `lea 0x4(%rsp),%rdi`)

Techniques
- `xor %eax,%eax` - an efficient way to set register eax to 0 since an xor against the same value will always be false (0)

Stack Frame
```
------------------------------
.
.
.
Arg 2
Arg 1
Return Address
------------------------------
Saved %ebp (Stack Base Pointer) <--- Current Frame Stack Base Pointer (%ebp)
Saved reg, local/temp/vars
Arg build area                  <--- Current Frame Stack Pointer (%esp)
------------------------------
```

Makefile to disassemble C program:
```Makefile
all:
    test -f test && /bin/rm test
    gcc -O0 -g test.c -o test
    ./test
    gdb -batch -ex 'file test' -ex 'disassemble /m main'
```
