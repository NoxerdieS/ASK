CLO
    MOV CL, C0         ; pocz�tek zapisu zdania
    CALL 18

    MOV CL, E0         ; pocz�tek zapisu frazy
    CALL 18

    MOV CL, F0         ; pocz�tek zapisu frazy zast�puj�cej
    CALL 18
    CALL 26

ORG 18			; procedura wczytuj�ca dane
rs:
    IN 00              ; wczytaj znak do AL
    MOV [CL], AL       ; zapisz znak w pami�ci wy�wietlacza
    INC CL
    CMP AL, 0D         ; sprawd� znak ko�cz�cy
    JZ finish
    JMP rs

ORG 26
start_search:
    MOV CL, C0       ; wska�nik na pocz�tek zdania
    MOV DL, E0       ; wska�nik na pocz�tek frazy
    MOV BL, 0       ; BL = adres BC
    MOV [BC], BL      ; [BC] = 0 => jeszcze nie mamy pocz�tku dopasowania

rep:
    MOV AL, [CL]     ; AL = bie��cy znak zdania

    ; 1. Sprawd� kropk�
    CMP AL, 2E
    JZ isFound        ; je�li kropka '.', ko�cz dzia�anie algorytmu

    ; 2. Pobierz znak z frazy
    MOV BL, [DL]     ; BL = znak frazy
    CMP AL, BL
    JZ matched_char

    ; brak dopasowania
    MOV BL, 0      
    MOV [BC], BL       ; BC = 0 => reset pocz�tku
    MOV DL, E0       ; wr�� DL do E0
    INC CL
    JMP rep

matched_char:
    ; sprawd�, czy to pierwszy pasuj�cy znak
    MOV AL, [BC]     ; AL = [BC]
    CMP AL, 0
    JNZ continue_match

    ; je�li AL=0 => to pierwszy dopasowany znak
    PUSH CL
    POP AL
    MOV [BC], AL     ; BC = CL

continue_match:
    ; Przesu� wska�niki
    INC CL
    INC DL

    ; Sprawd�, czy doszli�my do ko�ca frazy (znak 0D)
    MOV BL, [DL]
    CMP BL, 0D
    JZ phrase_end
    JMP rep

phrase_end:
    ; Ca�a fraza dopasowana
    ; CL jest ju� na znak "za" ostatnim dopasowanym
    DEC CL
    MOV [BD], CL     ; BD = koniec wyst�pienia (CL)
	CALL 80
	JMP rep

ORG 80
	MOV AL, F0	; adres pocz�tku frazy zamieniaj�cej
	MOV CL, [BC]    ; adres pocz�tku wyst�pienia
switch:
	MOV DL, [AL]	; litera frazy zamieniaj�cej
	MOV [CL], DL
	INC AL
	INC CL
	CMP CL, [BD]
	JZ end_switch
	JMP switch
end_switch:
	MOV DL, [AL]
	MOV [CL], DL
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