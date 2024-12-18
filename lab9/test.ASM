    MOV DL, 2E         ; znak koñcz¹cy dla zdania to '.'
    MOV CL, C0         ; pocz¹tek zapisu zdania
    MOV BL, DF         ; koniec zakresu dla zdania
    MOV AL, C0         ; zapisz pocz¹tkowy adres startu dla zdania
    MOV [B0], AL       ; przechowaj adres w komórce pamiêci 70
    CALL 35

    MOV DL, 0D         ; znak koñcz¹cy dla frazy to Enter
    MOV CL, E0         ; pocz¹tek zapisu frazy
    MOV BL, EF         ; koniec zakresu dla frazy
    MOV AL, E0         ; zapisz pocz¹tkowy adres startu dla frazy
    MOV [B0], AL       ; przechowaj adres w komórce pamiêci 71
    CALL 35

    MOV DL, 0D         ; znak koñcz¹cy dla kolejnej frazy
    MOV CL, F0         ; pocz¹tek zapisu frazy zastêpuj¹cej
    MOV BL, FF         ; koniec zakresu dla frazy
    MOV AL, F0         ; zapisz pocz¹tkowy adres startu dla frazy
    MOV [B0], AL       ; przechowaj adres w komórce pamiêci 72
    CALL 35

    JMP end

ORG 35
rs:
    IN 00              ; wczytaj znak do AL
    MOV [CL], AL       ; zapisz znak w pamiêci wyœwietlacza
    INC CL
    CMP CL, BL
    JNZ rs1
    MOV AL, B0       ; wczytaj wartoœæ pocz¹tkow¹ z komórki pamiêci 70
    MOV CL, [AL]         ; ustaw wartoœæ w rejestrze CL
rs1:
    CMP AL, DL         ; sprawdŸ znak koñcz¹cy
    JZ ds
    JMP rs
ds:
    RET

end:
    END