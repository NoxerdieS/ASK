MOV BL, 80
MOV CL, C0
CALL 20
JMP reset
reset:
	MOV BL, 80

CALL 40
next_call:
	MOV BL, 80
	CALL 60

ORG 20
	IN 00
	MOV [BL], AL
	INC BL
	CMP BL, BF
	JZ reset
	CMP AL, 0D
	JZ ret
	CALL 20
ret:
	RET


ORG 40
	MOV AL, [BL]
	CMP AL, 0D
	JZ next_call
	ADD AL, 20
	MOV [BL], AL
	INC BL
	CALL 40

ORG 60
	MOV AL, [BL]
	MOV [CL], AL
	CMP AL, 0D
	JZ endl
	INC CL
	INC BL
	CALL 60

endl:
	END