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
	MOV DL, 0D
	PUSH DL
	JMP get_on_stack

get_on_stack:
	MOV AL, [BL]
	CMP AL, 0D
	JZ disp_rep
	PUSH AL
	INC BL
	JMP get_on_stack
	
disp_rep:
	POP AL
	MOV [CL], AL
	INC CL
	CMP AL, 0D
	JZ endl
	JMP disp_rep 
endl:
	END
	
