CLO

MOV AL, 1
MOV BL, 1

while:
	PUSH BL
	ADD BL, AL
	POP AL
	JO endl
	JMP while
endl:
	END	