reset:
	MOV BL, 60
rep:
	IN 00
	MOV [BL], AL
	INC BL
	CMP BL, 9F
	JZ reset
	CMP AL, 0D
	JZ disp
	JMP rep
disp:
	MOV CL, C0
	MOV BL, 60
	JMP disp_rep
	
disp_rep:
	MOV AL, [BL]
	MOV [CL], AL
	INC CL
	INC BL
	CMP AL, 0D
	JZ endl
	JMP disp_rep 
endl:
	END
	
