        ORG 00
        JMP main        
ORG 40
bin2gray:
        PUSH AL
	POP BL      
        SHR BL       
        XOR AL, BL      
        RET


ORG 50
gray2bin:
        PUSH AL
	POP BL
        SHR BL
	SHR BL
	SHR BL
	SHR BL
        XOR AL, BL

        PUSH AL
	POP BL
        SHR BL
	SHR BL
        XOR AL, BL

        PUSH AL
	POP BL
        SHR BL
        XOR AL, BL

        RET

ORG 05
main:
        MOV AL, 17       
        CALL 40          
        MOV DL, 80
        MOV [DL], AL


        MOV AL, [DL]
        CALL 50          
        MOV DL, 81
        MOV [DL], AL

        END              
