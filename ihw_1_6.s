	.file	"ihw_1_5.c"
	.intel_syntax noprefix # Используем синтаксис в стиле Intel
	.text # Начало секции
	.local	ARRAY_A # Объявляем символ ARRAY_A, но не экспортируем его
	.comm	ARRAY_A,4194304,32 # Неинициализированный массив
	.local	ARRAY_B # Объявляем символ ARRAY_B, но не экспортируем его
	.file	"ihw_1_5.c"
	.intel_syntax noprefix
	.text
	.local	ARRAY_A # Объявляем символ ARRAY_A, но не экспортируем его
	.local	ARRAY_B # Объявляем символ ARRAY_B, но не экспортируем его
	.comm	ARRAY_B,4194304,32 # Неинициализированный массив
	.section	.rodata
.LC0:
	.string	"%d" # …прямо перед тем, как положить в файл строку "%d\0"
	.text
	.globl	createArray # Объявляем и экспортируем вовне символ `createArray`
	.type	createArray, @function
createArray:
	push	rbp # / Пролог функции (1/3). Сохранили предыдущий rbp на стек.
	mov	rbp, rsp # | Пролог функции (2/3). Вместо rbp записали rsp.
	sub	rsp, 32 # \ Пролог функции (3/3). А сам rsp сдвинули на 32 байт
	mov	r12d, edi # rbp[-20] := edi — переменная n на стеке
	mov	r13d, 0 # rsi := 0 
	mov	r14d, 0 # rsi := 0 
	jmp	.L2
.L3:
	lea	rax, -12[rbp] # rax := rbp[-12]
	mov	rsi, rax # rsi := rax 
	lea	rax, .LC0[rip] # rdi := rip[.LC0] — наша строка "%d"
	mov	rdi, rax # rdi := rax
	mov	eax, 0 # Обнуляет eax
	call	__isoc99_scanf@PLT # Вызывает функцию `scanf`
	mov	eax, DWORD PTR -12[rbp] # eax := rbp[-12]
	mov	edx, r14d #
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4] # / rcx := rax * 4
	lea	rdx, ARRAY_A[rip]  # | rdx := &rip[ARRAY_A]
	mov	DWORD PTR [rcx+rdx], eax # | (rdx + rcx):= eax
	mov	eax, DWORD PTR -12[rbp] # \ eax := rbp[-12]
	add	r13d, eax # rbp[-8] := eax
	add	r14d, 1 # rbp[-4] := 1
.L2:
	mov	eax, r14d # eax := rbp[-4]
	cmp	eax, r12d # eax := rbp[-20]
	jl	.L3
	mov	eax, r13d # eax := rbp[-8]
	cdq
	idiv	r12d
	mov	r13d, eax # rbp[-8] := eax;
	mov	eax, r13d # eax := rbp[-8]
	leave
	ret
	.size	createArray, .-createArray
	.globl	main
	.type	main, @function
main: # Теперь метка `main:`, именно её мы и экспортируем
	push	rbp # / Пролог функции (1/3). Сохранили предыдущий rbp на стек.
	mov	rbp, rsp # | Пролог функции (2/3). Вместо rbp записали rsp.
	sub	rsp, 16 # \ Пролог функции (3/3). А сам rsp сдвинули на 16 байт
	lea	rax, -16[rbp] # rax := rbp[-16] — переменная n на стеке
	mov	rsi, rax  # rsi := rax 
	lea	rax, .LC0[rip] # rdi := rip[.LC0] — наша строка "%d"
	mov	rdi, rax # rdi := rax
	mov	eax, 0 # Обнуляет eax
	call	__isoc99_scanf@PLT # Вызывает функцию `scanf`
	mov	eax, DWORD PTR -16[rbp]
	mov	edi, eax # edi := eax
	call	createArray # Вызывает функцию `createArray`
	mov	DWORD PTR -12[rbp], eax
	mov	eax, DWORD PTR ARRAY_A[rip]
	mov	r13d, eax
	mov	r14d, 0 # rbp[-4] := 0 — счетчик цикла
	jmp	.L6
.L8:
	mov	eax, r14d # eax := rbp[-4]  
	cdqe
	lea	rcx, 0[0+rax*4] # / rcx := rax * 4
	lea	rdx, ARRAY_B[rip] # | rax := &rip[ARRAY_B]
	mov	eax, r13d # | eax := rbp[-12]
	mov	DWORD PTR [rcx+rdx], eax # | (rdx + rcx):= eax
	mov	eax, r14d # \ eax := rbp[-4]
	cdqe
	lea	rdx, 0[0+rax*4] # / rdx := rax * 4
	lea	rax, ARRAY_B[rip] # | rax := &rip[ARRAY]
	mov	eax, DWORD PTR [rdx+rax] # \ eax := *(rdx + rax)
	mov	esi, eax # esi := eax
	lea	rax, .LC0[rip] # rax := rip[.LC0] — снова строчка "%d"
	mov	rdi, rax # rdi := rax
	mov	eax, 0 # eax := 0
	call	printf@PLT # Вызывает функцию `printf`
	mov	edi, 32 # edo := 32
	call	putchar@PLT # Вызывает функцию `putchar`
	add	r14d, 1 # rbp[-4] += 1
	mov	eax, r14d # eax := rbp[-4]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, ARRAY_A[rip]
	mov	eax, DWORD PTR [rdx+rax]
	add	r13d, eax
.L6:
	mov	eax, DWORD PTR -16[rbp] # eax := rbp[-16]
	cmp	r14d, eax
	jge	.L7
	mov	eax, r14d # eax := rbp[-4]
	cdqe
	lea	rdx, 0[0+rax*4] # / rdx := rax * 4
	lea	rax, ARRAY_A[rip] # | rax := &rip[ARRAY]
	mov	eax, DWORD PTR [rdx+rax] # | eax := *(rdx + rax)
	cmp	DWORD PTR -12[rbp], eax # \ rbp[-8] := eax
	jge	.L8
.L7:
	mov	eax, DWORD PTR -16[rbp] # eax := rbp[-16]
	cmp	DWORD PTR -4[rbp], eax # rbp[-4] := eax
	je	.L9
	mov	eax, r14d
	cdqe
	lea	rcx, 0[0+rax*4] # / rcx := rax * 4
	lea	rdx, ARRAY_B[rip] # | rax := &rip[ARRAY]
	mov	eax, r13d
	mov	DWORD PTR [rcx+rdx], eax # | eax := *(rdx + rax)
	mov	eax, r14d # \ eax := rbp[-4] 
	cdqe
	lea	rdx, 0[0+rax*4] # rdx := rax * 4
	lea	rax, ARRAY_B[rip] # rax := &rip[ARRAY]
	mov	eax, DWORD PTR [rdx+rax] # eax := *(rdx + rax)
	mov	esi, eax # esi := eax
	lea	rax, .LC0[rip] # rax := rip[.LC0] — снова строчка "%d"
	mov	rdi, rax # rdi := rax
	mov	eax, 0 # eax := 0
	call	printf@PLT # Вызывает функцию `printf`
.L9:
	mov	eax, 0
	leave # / Эпилог (1/2)
	ret # \ Эпилог (2/2)
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
