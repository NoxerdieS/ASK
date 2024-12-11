CLO

MOV AL, 41
MOV [B0], AL

while:
	CMP AL, 47
	JNS end_label
	INC AL
	MOV [B0], AL
	JMP while	
end_label:
	END