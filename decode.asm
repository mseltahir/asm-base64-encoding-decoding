%include "io.inc"
extern printf

section .data
input: db 'V29yZHNPZlJhZGlhbmNl' ; sample input
length equ $ - input
output:

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    xor eax, eax
    xor edx, edx
    mov ecx, length
    mov esi, input
    mov edi, output
process:
    xor ebx, ebx
    cmp ecx, 0
    je done
    mov eax, [esi]
    bswap eax
    mov edx, eax
;;;;;;;;;;;;;;; ONE out of FOUR ;;;;;;;;;;;;;;;
    shr eax, 24
    cmp eax, 'A'
    jge cap_or_small1
    jl plus_slash1
cap_or_small1:
    cmp eax, 'a'
    jge small1
    jl cap1
cap1:
    sub eax, 'A'
    add ebx, eax
    shl ebx, 6
    jmp next1
small1:
    sub eax, 'a'
    add eax, 26
    add ebx, eax
    shl ebx, 6
    jmp next1
plus_slash1:
    cmp eax, '/'
    jl plus1
    je slash1
    jg num1
plus1:
    add ebx, 62
    shl ebx, 6
    jmp next1
slash1:
    add ebx, 63
    shl ebx, 6
    jmp next1
num1:
    sub eax, '0'
    add eax, 52
    add ebx, eax
    shl ebx, 6
    jmp next1
;;;;;;;;;;;;;;; TWO out of FOUR ;;;;;;;;;;;;;;;
next1:
    mov eax, edx
    shr eax, 16
    and eax, 0xff
    cmp eax, 'A'
    jge cap_or_small2
    jl plus_slash2
cap_or_small2:
    cmp eax, 'a'
    jge small2
    jl cap2
cap2:
    sub eax, 'A'
    add ebx, eax
    shl ebx, 6
    jmp next2
small2:
    sub eax, 'a'
    add eax, 26
    add ebx, eax
    shl ebx, 6
    jmp next2
plus_slash2:
    cmp eax, '/'
    jl plus2
    je slash2
    jg num2
plus2:
    add ebx, 62
    shl ebx, 6
    jmp next2
slash2:
    add ebx, 63
    shl ebx, 6
    jmp next2
num2:
    sub eax, '0'
    add eax, 52
    add ebx, eax
    shl ebx, 6
    jmp next2
;;;;;;;;;;;;;;; THREE out of FOUR ;;;;;;;;;;;;;;;
next2:
    mov eax, edx
    shr eax, 8
    and eax, 0xff
    cmp eax, '='
    je equal2
    cmp eax, 'A'
    jge cap_or_small3
    jl plus_slash3
cap_or_small3:
    cmp eax, 'a'
    jge small3
    jl cap3
cap3:
    sub eax, 'A'
    add ebx, eax
    shl ebx, 6
    jmp next3
small3:
    sub eax, 'a'
    add eax, 26
    add ebx, eax
    shl ebx, 6
    jmp next3
plus_slash3:
    cmp eax, '/'
    jl plus3
    je slash3
    jg num3
plus3:
    add ebx, 62
    shl ebx, 6
    jmp next3
slash3:
    add ebx, 63
    shl ebx, 6
    jmp next3
num3:
    sub eax, '0'
    add eax, 52
    add ebx, eax
    shl ebx, 6
    jmp next3
;;;;;;;;;;;;;;; FOUR out of FOUR ;;;;;;;;;;;;;;;
next3:
    mov eax, edx
    and eax, 0xff
    cmp eax, '='
    je equal1
    cmp eax, 'A'
    jge cap_or_small4
    jl plus_slash4
cap_or_small4:
    cmp eax, 'a'
    jge small4
    jl cap4
cap4:
    sub eax, 'A'
    add ebx, eax
    jmp next4
small4:
    sub eax, 'a'
    add eax, 26
    add ebx, eax
    jmp next4
plus_slash4:
    cmp eax, '/'
    jl plus4
    je slash4
    jg num4
plus4:
    add ebx, 62
    jmp next4
slash4:
    add ebx, 63
    jmp next4
num4:
    sub eax, '0'
    add eax, 52
    add ebx, eax
    jmp next4
;;;;;;;;;;;;;;; NEXT FOUR CHARACTERS ;;;;;;;;;;;;;;;
next4:
    bswap ebx
    shr ebx, 8
    mov [edi], ebx
    add edi, 3
    sub ecx, 4
    add esi, 4
    jmp process
;;;;;;;;;;;;;;; EQUALS CASE ;;;;;;;;;;;;;;;
equal1:
    bswap ebx
    shr ebx, 8
    mov [edi], ebx
    add edi, 3
    sub ecx, 4
    add esi, 4
    jmp done
equal2:
    shr ebx, 10
    mov [edi], ebx
    add edi, 3
    sub ecx, 4
    add esi, 4
    jmp done
;;;;;;;;;;;;;;; FINISHING THE PROCESS ;;;;;;;;;;;;;;;
done:
    push output
    call printf
    add esp, 4
    ret
