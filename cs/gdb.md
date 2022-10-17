# GDB (Gnu Debugger) Reference

- Quickref: <http://users.ece.utexas.edu/~adnan/gdb-refcard.pdf>
- GNU Docs: <https://sourceware.org/gdb/current/onlinedocs/gdb/>

1. ulimit -c unlimited
2. Run program - will generate core.n
3. CD to source
   ```
   $ gdb -tui <binary> <core>
   (gdb) bt
   (gdb) frame <n>
   (gdb) print *argv@argc
   ```

- `layout regs`
- `layout asm`
- `layout source`
