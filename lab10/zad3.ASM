JMP Main
JMP Wrap
DB 0E

Main:
	MOV DL, C0
	MOV BL, A0

Wrap:
	MOV BL, A0

Rep:
	IN 00
	MOV [BL], AL
	CMP BL, A5
	JZ Wrap
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
	CMP CL, A5
	JZ Main
	INC DL
	JMP rep2

Endl:
	END