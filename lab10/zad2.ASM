JMP Start
DB 01
DB 40

Start:
rep:
    	IN 00        
	CMP AL, 51
	JZ is_q
	CMP AL, 71
	JZ is_q

    	CMP AL, 30   
    	JS not_digit 

	CMP AL, 3A
	JS is_digit

	CMP AL, 7E   
    	JS not_digit
	INT 03
	JMP rep
is_digit:
    	SUB AL, 30  
    	PUSH AL
	POP CL
	CALL 40

not_digit:
   	MOV CL, 0  
	SUB CL, 1
	CALL 40

is_q:
	MOV CL, 0
	SUB CL, 2
	CLO
	CALL 40
ORG 40
	MOV AL, 0
	SUB AL, 2
	CMP CL, AL
	JZ end
	MOV AL, 0
	SUB AL, 1
	CMP CL, AL
	JZ red_light
	JMP is_num

red_light:
	MOV AL, 81
	OUT 01
	JMP rep
is_num:
	MOV AL, 0
	OUT 01
	MOV [B0], CL
	MOV AL, 20
	OUT 01
	DEC CL
	MOV AL, 0
	OUT 01
	CMP CL, 0
	JZ rep
	JMP is_num
end:
    END
