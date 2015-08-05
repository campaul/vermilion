extern syscall_handler

global _syscall_handler
_syscall_handler:
    call syscall_handler
    iretd

global syscall
syscall:
    int 0x80
    ret

global halt
halt:
    hlt
    ret
