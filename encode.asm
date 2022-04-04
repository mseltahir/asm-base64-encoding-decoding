%include "io.inc"
extern printf

section .data
Table: db 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/', 0
input: db 'WordsOfRadiance' ; sample input
length equ $ - input
output: 

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    xor eax, eax
    xor edx, edx
    mov ecx, length
    mov ebx, Table
    mov esi, input
    mov edi, output
process:
    mov eax, [esi]
    bswap eax
    cmp ecx, 3
    jge three
    cmp ecx, 2
    je two
    cmp ecx, 1
    je one
    jmp done
three:
    shr eax, 8
    mov edx, eax
    
    shr eax, 18
    xlat 
    mov [edi], al
    inc edi
    
    mov eax, edx
    shr eax, 12
    and eax, 0x3f
    xlat
    mov [edi], al
    inc edi
    
    mov eax, edx
    shr eax, 6
    and eax, 0x3f
    xlat     
    mov [edi], al
    inc edi
    
    mov eax, edx
    and eax, 0x3f
    xlat
    mov [edi], al
    inc edi
    
    sub ecx, 3
    add esi, 3
    jmp process
two:
    shr eax, 16
    mov edx, eax

    shr eax, 10
    and eax, 0x3f
    xlat
    mov [edi], al
    inc edi
    
    mov eax, edx
    shr eax, 4
    and eax, 0x3f
    xlat
    mov [edi], al
    inc edi
    
    mov eax, edx
    shl eax, 2
    and eax, 0x3f
    xlat 
    mov [edi], al
    inc edi
    
    mov al, '='
    mov [edi], al
    inc edi
    
    sub ecx, 2    
    add esi, 2
    
    jmp done
    
one:
    shr eax, 24
    mov edx, eax
    shr eax, 2
    and eax, 0x3f
    xlat 
    mov [edi], al
    inc edi
    
    mov eax, edx
    shl eax, 4
    and eax, 0x3f
    xlat
    mov [edi], al
    inc edi
    
    mov ax, '=='
    mov [edi], ax
    add edi, 2
    
    sub ecx, 1
    add esi, 1
    
done:
    mov al, 0
    mov [edi], al
    inc edi
    push output
    call printf
    add esp, 4
    ret
