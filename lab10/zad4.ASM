JMP start
DB 05   

ORG 05
JMP rep
start:	
    MOV CL, C0
    MOV DL, D0
    MOV [B0], DL
rep: 
    IN 00
    CMP AL, 8
    JZ backspace
    CMP AL, 0D
    JZ next_line
    MOV [CL], AL
    INC CL
    INT 02

next_line:
    MOV CL, [B0]
    ADD DL, F
    INC DL
    MOV [B0], DL
    JMP rep

backspace:
    DEC CL
    MOV AL, 20
    MOV [CL], AL
    JMP rep

END
