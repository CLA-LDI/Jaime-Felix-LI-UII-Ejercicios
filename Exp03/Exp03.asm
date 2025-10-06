						TITLE	Programa para evaluar una expresión
						PAGE	60, 132

Include Macros.inc

; Prototipos de funciones del sistema
GetStdHandle	PROTO	:QWORD
ReadConsoleW	PROTO	:QWORD,	:QWORD,	:QWORD,	:QWORD,	:QWORD
WriteConsoleW	PROTO	:QWORD,	:QWORD,	:QWORD,	:QWORD,	:QWORD

						.DATA
E						QWORD	0
MenEnt01				WORD	'P', 'r', 'o', 'p', 'o', 'r', 'c', 'i', 'o', 'n', 'e', ' ', 'e', 'l', ' ', 'v', 'a', 'l', 'o', 'r', ' ', 'd', 'e', ' ', 'l', 'a', ' ', 'v', 'a', 'r', 'i', 'a', 'b', 'l', 'e', ' ', 'N', ':', ' '
MenSal01				WORD	'E', 'l', ' ', 'v', 'a', 'l', 'o', 'r', ' ', 'd', 'e', ' ', 'l', 'a', ' ', 'v', 'a', 'r', 'i', 'a', 'b', 'l', 'e', ' ', 'E', ' ', 'e', 's', ':', ' '

; Variables requeridas por las llamadas al sistema
ManejadorE				QWORD	?
ManejadorS				QWORD	?
Caracteres				QWORD	?
STD_INPUT				EQU		-10
STD_OUTPUT				EQU		-11
SaltoLinea				WORD	13, 10
Texto					WORD	13 DUP ( ? )

						.CODE
Principal				PROC

						; Reserva espacio en la pila
						SUB		RSP, 40

						; Obtener manejador de la entrada y salida estándar
						MOV		RCX, STD_INPUT
						CALL	GetStdHandle
						MOV		ManejadorE, RAX
						MOV		RCX, STD_OUTPUT
						CALL	GetStdHandle
						MOV		ManejadorS, RAX

						; Mostrar primer mensaje
						MOV		RCX, ManejadorS
						LEA		RDX, MenEnt01
						MOV		R8, LENGTHOF MenEnt01
						LEA		R9, Caracteres
						MOV		R10, 0
						PUSH	R10
						CALL	WriteConsoleW
						POP		R10
						; Leer el valor de N
						MOV		RCX, ManejadorE
						LEA		RDX, Texto
						MOV		R8, 13
						LEA		R9, Caracteres
						MOV		R10, 0
						PUSH	R10
						CALL	ReadConsoleW
						POP		R10
						MacroCadenaAEntero	Texto, N


						; Evaluar la expresión E = ( ( N * M ) / ( Y + Z ) ) – 1


						; Mostrar mensaje de salida
						MOV		RCX, ManejadorS
						LEA		RDX, MenSal01
						MOV		R8, LENGTHOF MenSal01
						LEA		R9, Caracteres
						MOV		R10, 0
						PUSH	R10
						CALL	WriteConsoleW
						POP		R10
						; Mostrar el valor de E en pantalla
						MacroEnteroACadena	E, Texto, Caracteres

						; Recuperar el espacio de la pila
						ADD		RSP, 40

						; Salir al S. O.
						MOV		RAX, 0					; Código de salida 0
						RET								; Retornar al sistema operativo
Principal				ENDP
						END
