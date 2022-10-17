# Compsci

## Back-of-the-Envelope

```
Nanoseconds  Exponent      Description
0.5          0.5 * 10^0    L1 cache reference
5            5   * 10^0    Branch mispredict
7            7   * 10^0    L2 cache reference
100          1   * 10^2    Mutex lock/unlock
100          1   * 10^2    Main memory reference
1000         1   * 10^3    [------- 1 us --------]
10000        1   * 10^4    Compress 1K with zippy
10000        1   * 10^4    Send 1K over 1 Gbps network
250000       2.5 * 10^5    Read 1 MB from memory
500000       5   * 10^5    Round trip within same datacenter
1000000      1   * 10^6    [------- 1 ms --------]
1000000      1   * 10^6    Read 1 MB sequentially from SSD
10000000     1   * 10^7    Disk seek
150000000    1.5 * 10^8    Send packet from CA to Netherlands to CA
1000000000   1   * 10^9    [------- 1 s  --------]
```

Example: Generate Image Results Page of 30 Thumbnails

- Scenario 1:
  - Read images serially. Do a disk seek. Read a 256K image and then go on to the next image.
  - Performance: `30 seeks * 10 ms/seek + 30 * 256K / 30 MB /s = 560 ms`
- Scenario 2:
  - Issue reads in parallel.
  - Performance: `10 ms/seek + 256K read / 30 MB/s = 18ms`
  - There will be variance from the disk reads, so the more likely time is `30-60 ms`

## Terms

- Marshalling - Transforming the memory representation of an object to a data format suitable for storage or transmission.

## Compiler

Structure of Compiler
- Lexical Analysis
- Parsing
- Semantic Analysis
- Code Generation

Structure of Compiler (Detailed)
- Lexical Analyzer (token stream)
- Syntax Analyzer (syntax tree)
- Semantic Analyzer (syntax tree)
- Intermediate Code Generator (intermediate representation)
- Machine-Independent Code Optimzer (intermediate representation)
- Code Generator (target-machine code)
- Machine-Dependent Code Optimizer (target-machine code)

Token Class
- Operator
- Whitespace
- Keyword
- Single Character (e.g. "(", ")", "[", "]", ";", etc...)
- Identifier
- Numbers

Lexical Analysis
- Partition the input into substrings corresponding to tokens (the lexemes)
- Identify the token class of each lexeme

Regular Expressions specify Regular Languages
- Five constructs
  - Two base cases: empty (epsilon) and 1-character strings
  - Three compound: union, concatenation, iteration
