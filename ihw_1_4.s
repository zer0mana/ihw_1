.file "ihw_1_4.c"
 .intel_syntax noprefix # Используем синтаксис в стиле Intel
 .text # Начало секции
 .local ARRAY_A # Объявляем символ ARRAY_A, но не экспортируем его
 .comm ARRAY_A,4194304,32 # Неинициализированный массив
 .local ARRAY_B # Объявляем символ ARRAY_B, но не экспортируем его
 .comm ARRAY_B,4194304,32 # Неинициализированный массив
 .section .rodata # Переходим в секцию .rodata
.LC0:  # Метка `.LC0:`…
 .string "%d"  # …прямо перед тем, как положить в файл строку "%d\0"
 .text
 .globl main  # Объявляем и экспортируем вовне символ `main`
 .type main, @function
main:  # Теперь метка `main:`, именно её мы и экспортируем
 push rbp  # / Пролог функции (1/3). Сохранили предыдущий rbp на стек.
 mov rbp, rsp  # | Пролог функции (2/3). Вместо rbp записали rsp.
 sub rsp, 32   # \ Пролог функции (3/3). А сам rsp сдвинули на 32 байт
 lea rax, -16[rbp]  # rax := rbp[-16] — переменная n на стеке
 mov rsi, rax # rsi := rax 
 lea rax, .LC0[rip] # rdi := rip[.LC0] — наша строка "%d"
 mov rdi, rax # rdi := rax
 mov eax, 0 # Обнуляет eax
 call __isoc99_scanf@PLT  # Вызывает функцию `scanf`
 mov DWORD PTR -8[rbp], 0  # rbp[-8] := 0 — счетчик цикла
 mov DWORD PTR -4[rbp], 0  # rbp[-4] := 0 — счетчик цикла
 jmp .L2 # переход к метке .L2
.L3:
 lea rax, -20[rbp] # rax := rbp[-20]  # rax := rbp[-20] — переменная size_A на стеке
 mov rsi, rax  # rsi := rax
 lea rax, .LC0[rip] # rax := rip[.LC0] — наша строка "%d"
 mov rdi, rax  # rdi := rax
 mov eax, 0 # Обнуляет eax
 call __isoc99_scanf@PLT # Вызывает функцию `scanf`
 mov eax, DWORD PTR -20[rbp] # eax := rbp[-20]
 mov edx, DWORD PTR -4[rbp] # edx := rbp[-4]
 movsx rdx, edx
 lea rcx, 0[0+rdx*4] # / rcx := rax * 4
 lea rdx, ARRAY_A[rip]  # | rdx := &rip[ARRAY_A] — адрес начала массива
 mov DWORD PTR [rcx+rdx], eax # | eax := rbp[-16]
 mov eax, DWORD PTR -20[rbp] # \ [rcx + rdx] := eax — наконец, записать в rdx[rcx] := eax
 add DWORD PTR -8[rbp], eax
 add DWORD PTR -4[rbp], 1 # rbp[-4] += 1
.L2:
 mov eax, DWORD PTR -16[rbp]  # eax := rbp[-16] 
 cmp DWORD PTR -4[rbp], eax # сравнить rbp[-16] и eax (это счетчик цикла и n)
 jl .L3 # если меньше, то перейти к .L3: (иначе выйти из цикла)
 mov esi, DWORD PTR -16[rbp]  # esi := rbp[-16] — снова загрузка n из стека в регистр
 mov eax, DWORD PTR -8[rbp]  # eax := rbp[-8] — снова загрузка n из стека в регистр
 cdq
 idiv esi
 mov DWORD PTR -8[rbp], eax # rbp[-16] := eax — записать в i полученное число…
 mov eax, DWORD PTR ARRAY_A[rip]
 mov DWORD PTR -12[rbp], eax # rbp[-12] := eax
 mov DWORD PTR -4[rbp], 0 # rbp[-4] := 0
 jmp .L4
.L6:
 mov eax, DWORD PTR -4[rbp] # eax := rbp[-4]  
 cdqe
 lea rcx, 0[0+rax*4] # / rcx := rax * 4
 lea rdx, ARRAY_B[rip] # | rax := &rip[ARRAY_B]
 mov eax, DWORD PTR -12[rbp] # | eax := rbp[-12]
 mov DWORD PTR [rcx+rdx], eax # | (rdx + rcx):= eax
 mov eax, DWORD PTR -4[rbp] # \ eax := rbp[-4]
 cdqe
 lea rdx, 0[0+rax*4]  # / rdx := rax * 4
 lea rax, ARRAY_B[rip]  # | rax := &rip[ARRAY]
 mov eax, DWORD PTR [rdx+rax]  # \ eax := *(rdx + rax)
 mov esi, eax  # esi := eax
 lea rax, .LC0[rip] # rax := rip[.LC0] — снова строчка "%d"
 mov rdi, rax  # rdi := rax
 mov eax, 0  # eax := 0
 call printf@PLT # Вызывает функцию `printf`
 mov edi, 32 # edo := 32
 call putchar@PLT # Вызывает функцию `putchar`
 add DWORD PTR -4[rbp], 1 # rbp[-4] += 1
 mov eax, DWORD PTR -4[rbp] # eax := rbp[-4]
 cdqe
 lea rdx, 0[0+rax*4]  # / rdx := rax * 4
 lea rax, ARRAY_A[rip] # | rax := &rip[ARRAY]
 mov eax, DWORD PTR [rdx+rax] # | eax := *(rdx + rax)
 add DWORD PTR -12[rbp], eax # \ rbp[-12] += eax
.L4:
 mov eax, DWORD PTR -16[rbp] # eax := rbp[-16]
 cmp DWORD PTR -4[rbp], eax
 jge .L5
 mov eax, DWORD PTR -4[rbp] # eax := rbp[-4]
 cdqe
 lea rdx, 0[0+rax*4] # / rdx := rax * 4
 lea rax, ARRAY_A[rip]  # | rax := &rip[ARRAY]
 mov eax, DWORD PTR [rdx+rax] # | eax := *(rdx + rax)
 cmp DWORD PTR -8[rbp], eax # \ rbp[-8] := eax
 jge .L6
.L5:
 mov eax, DWORD PTR -16[rbp] # eax := rbp[-16]
 cmp DWORD PTR -4[rbp], eax # rbp[-4] := eax
 je .L7
 mov eax, DWORD PTR -4[rbp]
 cdqe
 lea rcx, 0[0+rax*4]  # / rcx := rax * 4
 lea rdx, ARRAY_B[rip]  # | rax := &rip[ARRAY]
 mov eax, DWORD PTR -12[rbp]
 mov DWORD PTR [rcx+rdx], eax # | eax := *(rdx + rax)
 mov eax, DWORD PTR -4[rbp] # \ eax := rbp[-4] 
 cdqe
 lea rdx, 0[0+rax*4] # rdx := rax * 4
 lea rax, ARRAY_B[rip] # rax := &rip[ARRAY]
 mov eax, DWORD PTR [rdx+rax] # eax := *(rdx + rax)
 mov esi, eax # esi := eax
 lea rax, .LC0[rip] # rax := rip[.LC0] — снова строчка "%d"
 mov rdi, rax  # rdi := rax
 mov eax, 0 # eax := 0
 call printf@PLT # Вызывает функцию `printf`
.L7:
 mov eax, 0
 leave # / Эпилог (1/2)
 ret  # \ Эпилог (2/2)
 .size main, .-main
 .ident "GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
 .section .note.GNU-stack,"",@progbits
 .section .note.gnu.property,"a"
 .align 8
 .long 1f - 0f
 .long 4f - 1f
 .long 5
0:
 .string "GNU"
1:
 .align 8
 .long 0xc0000002
 .long 3f - 2f
2:
 .long 0x3
3:
 .align 8
4:
