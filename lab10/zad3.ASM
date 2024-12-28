JMP start
JMP wrap
DB 0E

start:
	MOV DL, C0
	MOV BL, A0

wrap:
	MOV BL, A0

rep:
	IN 00
	MOV [BL], AL
	CMP BL, A4
	JZ wrap
	INC BL
	CMP AL, 0D
	JZ print
	INT 04

print:
	MOV CL, A0
rep2:
	MOV AL, [CL]
	MOV [DL], AL
	INC CL
	CMP CL, A4
	JZ start
	INC DL
	JMP rep2

Endl:
	END 