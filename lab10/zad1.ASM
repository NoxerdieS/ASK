JMP Start
DB 0D

Start:
	MOV AL, A
	MOV BL, 0
	CALL 30
	JMP endl
ORG 30
	CMP BL, 0
	JZ is_zero
	DIV AL, BL
	RET

is_zero:
	INT 02

ORG 0D
	MOV AL, 81
	OUT 01
	MOV AL, 1
	PUSH AL
	POPF
	RET
endl:
	END