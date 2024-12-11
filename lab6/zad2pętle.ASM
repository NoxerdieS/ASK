CLO

MOV AL, 0

while:
	CMP AL, 3F
	JNS end_label
	ADD AL, 3
	JMP while
	
end_label:
	END