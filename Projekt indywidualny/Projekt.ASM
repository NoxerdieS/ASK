CLO
    MOV CL, C0         ; pocz¹tek zapisu zdania
    CALL 18

    MOV CL, E0         ; pocz¹tek zapisu frazy
    CALL 18

    MOV CL, F0         ; pocz¹tek zapisu frazy zastêpuj¹cej
    CALL 18
    CALL 26

ORG 18			; procedura wczytuj¹ca dane
rs:
    IN 00              ; wczytaj znak do AL
    MOV [CL], AL       ; zapisz znak w pamiêci wyœwietlacza
    INC CL
    CMP AL, 0D         ; sprawdŸ znak koñcz¹cy
    JZ finish
    JMP rs

ORG 26
start_search:
    MOV CL, C0       ; wskaŸnik na pocz¹tek zdania
    MOV DL, E0       ; wskaŸnik na pocz¹tek frazy
    MOV BL, 0       ; BL = adres BC
    MOV [BC], BL      ; [BC] = 0 => jeszcze nie mamy pocz¹tku dopasowania

rep:
    MOV AL, [CL]     ; AL = bie¿¹cy znak zdania

    ; 1. SprawdŸ kropkê
    CMP AL, 2E
    JZ isFound        ; jeœli kropka '.', koñcz dzia³anie algorytmu

    ; 2. Pobierz znak z frazy
    MOV BL, [DL]     ; BL = znak frazy
    CMP AL, BL
    JZ matched_char

    ; brak dopasowania
    MOV BL, 0      
    MOV [BC], BL       ; BC = 0 => reset pocz¹tku
    MOV DL, E0       ; wróæ DL do E0
    INC CL
    JMP rep

matched_char:
    ; sprawdŸ, czy to pierwszy pasuj¹cy znak
    MOV AL, [BC]     ; AL = [BC]
    CMP AL, 0
    JNZ continue_match

    ; jeœli AL=0 => to pierwszy dopasowany znak
    PUSH CL
    POP AL
    MOV [BC], AL     ; BC = CL

continue_match:
    ; Przesuñ wskaŸniki
    INC CL
    INC DL

    ; SprawdŸ, czy doszliœmy do koñca frazy (znak 0D)
    MOV BL, [DL]
    CMP BL, 0D
    JZ phrase_end
    JMP rep

phrase_end:
    ; Ca³a fraza dopasowana
    ; CL jest ju¿ na znak "za" ostatnim dopasowanym
    DEC CL
    MOV [BD], CL     ; BD = koniec wyst¹pienia (CL)
	CALL 80
	JMP rep

ORG 80
	MOV AL, F0	; adres pocz¹tku frazy zamieniaj¹cej
	MOV CL, [BC]    ; adres pocz¹tku wyst¹pienia
switch:
	MOV DL, [AL]	; litera frazy zamieniaj¹cej
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