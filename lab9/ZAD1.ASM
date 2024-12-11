reset:
	MOV BL, C0
rep:
	IN 00
	MOV [BL], AL
	CMP
	INC BL
	CMP BL, FF
	JZ reset
	
JMP rep
END