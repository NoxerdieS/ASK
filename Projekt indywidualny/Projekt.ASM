    CLO
    MOV CL, C0         
    CALL 18

    MOV CL, E0         
    CALL 18

    MOV CL, F0         
    CALL 18
    CALL 26

ORG 18			
rs:
    IN 00             
    MOV [CL], AL      
    INC CL
    CMP AL, 0D    
    JZ finish
    JMP rs

ORG 26
start_search:
    MOV CL, C0       
    MOV DL, E0      
    MOV BL, 0       
    MOV [BC], BL      

rep:
    MOV AL, [CL]     

    CMP AL, 2E
    JZ isFound        

    MOV BL, [DL]    
    CMP AL, BL
    JZ matched_char

    MOV BL, 0      
    MOV [BC], BL       
    MOV DL, E0       
    INC CL
    JMP rep

matched_char:
    MOV AL, [BC]     
    CMP AL, 0
    JNZ continue_match

    PUSH CL
    POP AL
    MOV [BC], AL    

continue_match:
    INC CL
    INC DL

    MOV BL, [DL]
    CMP BL, 0D
    JZ phrase_end
    JMP rep

phrase_end:
    DEC CL
    MOV [BD], CL     
    CALL 80
    JMP rep

ORG 80
    MOV AL, F0	
    MOV CL, [BC]    
switch:
    MOV DL, [AL]	
    MOV [CL], DL
    CMP CL, [BD]
    JZ end_switch
    INC AL
    INC CL
    JMP switch
end_switch:
    JMP finish
finish:
    RET

isFound:
    MOV AL, [BD]     
    CMP AL, 0
    JZ not_found
    MOV AL, 21
    OUT 01
    JMP endl
not_found:
    MOV AL, 81
    OUT 01
    JMP endl
endl:
    END