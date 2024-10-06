						TITLE	Programa para evaluar una expresión
						PAGE	60, 132

Include Macros.inc

; Prototipos de funciones del sistema
GetStdHandle	PROTO	:QWORD
ReadConsoleW	PROTO	:QWORD,	:QWORD,	:QWORD,	:QWORD,	:QWORD
WriteConsoleW	PROTO	:QWORD,	:QWORD,	:QWORD,	:QWORD,	:QWORD
ExitProcess		PROTO	nCodigoSalida:QWORD

						.DATA
E						QWORD	0
MenEnt01				WORD	'P', 'r', 'o', 'p', 'o', 'r', 'c', 'i', 'o', 'n', 'e', ' ', 'e', 'l', ' ', 'v', 'a', 'l', 'o', 'r', ' ', 'd', 'e', ' ', 'l', 'a', ' ', 'v', 'a', 'r', 'i', 'a', 'b', 'l', 'e', ' ', 'A', ':', ' '
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
						CALL	WriteConsoleW
						; Leer el valor de A
						MOV		RCX, ManejadorE
						LEA		RDX, Texto
						MOV		R8, 13
						LEA		R9, Caracteres
						MOV		R10, 0
						CALL	ReadConsoleW
						MacroCadenaAEntero	Texto, A


						; Evaluar la expresión E = ( 4 * A * B ) - ( C * C )


						; Mostrar mensaje de salida
						MOV		RCX, ManejadorS
						LEA		RDX, MenSal01
						MOV		R8, LENGTHOF MenSal01
						LEA		R9, Caracteres
						MOV		R10, 0
						CALL	WriteConsoleW
						; Mostrar el valor de E en pantalla
						MacroEnteroACadena	E, Texto, Caracteres

						; Salir al S. O.
						MOV		RCX, 0
						CALL	ExitProcess
Principal				ENDP
						END