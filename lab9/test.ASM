    MOV DL, 2E         ; znak koñcz¹cy dla zdania to '.'
    MOV CL, C0         ; pocz¹tek zapisu zdania
    MOV BL, DF         ; koniec zakresu dla zdania
    MOV AL, C0         ; zapisz pocz¹tkowy adres startu dla zdania
    MOV [B0], AL       ; przechowaj adres w komórce pamiêci 70
    CALL 40

    MOV DL, 0D         ; znak koñcz¹cy dla frazy to Enter
    MOV CL, E0         ; pocz¹tek zapisu frazy
    MOV BL, EF         ; koniec zakresu dla frazy
    MOV AL, E0         ; zapisz pocz¹tkowy adres startu dla frazy
    MOV [B0], AL       ; przechowaj adres w komórce pamiêci 71
    CALL 40

    MOV DL, 0D         ; znak koñcz¹cy dla kolejnej frazy
    MOV CL, F0         ; pocz¹tek zapisu frazy zastêpuj¹cej
    MOV BL, FF         ; koniec zakresu dla frazy
    MOV AL, F0         ; zapisz pocz¹tkowy adres startu dla frazy
    MOV [B0], AL       ; przechowaj adres w komórce pamiêci 72
    CALL 40
    CALL 60

    JMP end

ORG 40			; procedura wczytuj¹ca dane
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
    JZ ret
    JMP rs

ORG 60			; procedura porównuj¹ca d³ugoœæ
    MOV CL, C0    
    MOV DL, E0    
    MOV BL, B1
    MOV AL, 0
    MOV [BL], AL

rep:
    MOV AL, [CL]  ; pierwsza litera zdania
    MOV BL, [DL]  ; pierwsza litera szukanej frazy
    CMP AL, BL
    JZ comp	; s¹ takie same
    CMP AL, 2E	; sprawdŸ czy nie jest to koniec zdania
    JZ ret
    INC CL
    JMP rep
comp:
    MOV BL, B1     
    MOV AL, [BL]   ; AL = aktualna d³ugoœæ
    INC AL         ; zwiêksz d³ugoœæ
    MOV [BL], AL   ; zapisz now¹ d³ugoœæ z powrotem do pamiêci

    INC CL
    INC DL
    JMP rep

ret:
    RET

end:
    END