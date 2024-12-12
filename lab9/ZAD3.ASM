reset:
    MOV BL, 60      
rep:
    IN 00            
    MOV [BL], AL      
    INC BL            

    CMP BL, 9F       
    JZ  reset         
    
    CMP AL, 0D      
    JZ  start_disp    

    JMP rep          

start_disp:
    DEC BL 
    DEC BL            
    MOV CL, C0     

disp:
    MOV AL, [BL]     
    MOV [CL], AL      
    INC CL            
    DEC BL           
    CMP BL, 5F       
    JZ endl           

    JMP disp

endl:
    END
