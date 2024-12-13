    MOV DL, 2E         ; znak ko�cz�cy dla zdania to '.'
    MOV CL, C0         ; pocz�tek zapisu zdania
    MOV BL, DF         ; koniec zakresu dla zdania
    MOV AL, C0         ; zapisz pocz�tkowy adres startu dla zdania
    MOV [B0], AL       ; przechowaj adres w kom�rce pami�ci 70
    CALL 40

    MOV DL, 0D         ; znak ko�cz�cy dla frazy to Enter
    MOV CL, E0         ; pocz�tek zapisu frazy
    MOV BL, EF         ; koniec zakresu dla frazy
    MOV AL, E0         ; zapisz pocz�tkowy adres startu dla frazy
    MOV [B0], AL       ; przechowaj adres w kom�rce pami�ci 71
    CALL 40

    MOV DL, 0D         ; znak ko�cz�cy dla kolejnej frazy
    MOV CL, F0         ; pocz�tek zapisu frazy zast�puj�cej
    MOV BL, FF         ; koniec zakresu dla frazy
    MOV AL, F0         ; zapisz pocz�tkowy adres startu dla frazy
    MOV [B0], AL       ; przechowaj adres w kom�rce pami�ci 72
    CALL 40
    CALL 60

    JMP end

ORG 40			; procedura wczytuj�ca dane
rs:
    IN 00              ; wczytaj znak do AL
    MOV [CL], AL       ; zapisz znak w pami�ci wy�wietlacza
    INC CL
    CMP CL, BL
    JNZ rs1
    MOV AL, B0       ; wczytaj warto�� pocz�tkow� z kom�rki pami�ci 70
    MOV CL, [AL]         ; ustaw warto�� w rejestrze CL
rs1:
    CMP AL, DL         ; sprawd� znak ko�cz�cy
    JZ ret
    JMP rs

ORG 60			; procedura por�wnuj�ca d�ugo��
    MOV CL, C0    
    MOV DL, E0    
    MOV BL, B1
    MOV AL, 0
    MOV [BL], AL

rep:
    MOV AL, [CL]  ; pierwsza litera zdania
    MOV BL, [DL]  ; pierwsza litera szukanej frazy
    CMP AL, BL
    JZ comp	; s� takie same
    CMP AL, 2E	; sprawd� czy nie jest to koniec zdania
    JZ ret
    INC CL
    JMP rep
comp:
    MOV BL, B1     
    MOV AL, [BL]   ; AL = aktualna d�ugo��
    INC AL         ; zwi�ksz d�ugo��
    MOV [BL], AL   ; zapisz now� d�ugo�� z powrotem do pami�ci

    INC CL
    INC DL
    JMP rep

ret:
    RET

end:
    END