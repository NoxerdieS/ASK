        ORG 00

start:
        MOV AL, A       
	MOV BL, 05           
	XOR CL, CL    

mul_loop:
        CMP BL, 00    
        JZ  end_mul    

        PUSH BL
	POP DL
        AND DL, 01
        JZ skip_add
        ADD CL, AL

skip_add:
        SHL AL
        SHR BL

        JMP mul_loop

end_mul:
        END
