CLO

MOV AL, B

while:
	JS end_label
	SUB AL, 2
	JMP while

end_label:
	END

