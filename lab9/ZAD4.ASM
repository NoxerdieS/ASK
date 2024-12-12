MOV BL, 80
CALL 20
JMP reset
reset:
	MOV BL, 80
	CALL 20
CALL 40
next_call:
	MOV BL, 80
	CALL 60

ORG 20
rep:
	IN 00
	MOV [BL], AL
	INC BL
	CMP BL, 9F
	JZ reset
	CMP AL, 0D
	JZ ret
	JMP rep
ret:
	RET


ORG 40
rep2:
	MOV AL, [BL]
	CMP AL, 0D
	JZ next_call
	ADD AL, 20
	MOV [BL], AL
	INC BL
	JMP rep2

ORG 60
rep3:
	MOV AL, [BL]
	MOV [CL], AL
	CMP AL, 0D
	JZ endl
	INC CL
	INC BL
	JMP rep3

endl:
	END