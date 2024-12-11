reset:
	MOV BL, 60
	
rep:
	IN 00
	MOV [BL], AL
	INC BL
	CMP BL, 9F
	JZ reset
	CMP AL, 0D
	JNZ disp
	JMP rep
disp:
	
END