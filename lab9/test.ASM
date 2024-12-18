    MOV DL, 2E         ; znak ko�cz�cy dla zdania to '.'
    MOV CL, C0         ; pocz�tek zapisu zdania
    MOV BL, DF         ; koniec zakresu dla zdania      
    MOV [BA], CL       ; przechowaj adres w kom�rce pami�ci B0
    CALL 30

    MOV DL, 0D         ; znak ko�cz�cy dla frazy to Enter
    MOV CL, E0         ; pocz�tek zapisu frazy
    MOV BL, EF         ; koniec zakresu dla frazy
    MOV [BA], CL       ; przechowaj adres w kom�rce pami�ci B0
    CALL 30

    MOV CL, F0         ; pocz�tek zapisu frazy zast�puj�cej
    MOV BL, FF         ; koniec zakresu dla frazy
    MOV [BA], CL       ; przechowaj adres w kom�rce pami�ci B0
    CALL 30
    CALL 4A

ORG 30			; procedura wczytuj�ca dane
rs:
    IN 00              ; wczytaj znak do AL
    MOV [CL], AL       ; zapisz znak w pami�ci wy�wietlacza
    INC CL
    CMP CL, BL
    JNZ rs1
    MOV AL, BA       ; wczytaj warto�� pocz�tkow� z kom�rki pami�ci 70
    MOV CL, [AL]         ; ustaw warto�� w rejestrze CL
rs1:
    CMP AL, DL         ; sprawd� znak ko�cz�cy
    JZ ret
    JMP rs

ORG 4A		; procedura por�wnuj�ca zdanie i fraz�
    MOV CL, C0    ; wska�nik na pocz�tek zdania
    MOV DL, E0    ; wska�nik na pocz�tek frazy
    MOV AL, 0
    MOV [BC], AL  ; isfound = 0

rep:
    MOV AL, [CL]  ; AL = bie��cy znak ze zdania
    MOV BL, [DL]  ; BL = bie��cy znak z frazy
    CMP AL, BL
    JZ matched_char
    CMP AL, 2E     ; sprawd� czy koniec zdania
    JZ ret         ; je�li tak, wyjd� (fraza nieznaleziona)
    ; Niezgodno��, reset:
    MOV AL, 0
    MOV [BC], AL   ; isfound = 0
    MOV DL, E0     ; wr�� do pocz�tku frazy
    INC CL         ; przejd� do kolejnej litery zdania
    JMP rep

matched_char:
    MOV BL,[BC]
    CMP BL,0       ; sprawd� czy isfound = 0 (pierwszy pasuj�cy znak frazy)
    JNZ continue_match

    ; Pierwszy pasuj�cy znak
    MOV AL,1
    MOV BL,BC
    MOV [BL],AL     ; isfound = 1
    MOV BL,BD
    MOV [BL],CL     ; BD = pocz�tek wyst�pienia

continue_match:
    INC CL
    INC DL
    MOV BL,[DL]
    CMP BL,0D
    JZ phrase_end   ; dopiero teraz sprawd�, czy koniec frazy!
    JMP rep

phrase_end:
    ; Ca�a fraza dopasowana, BL = 0D oznacza koniec frazy
    ; CL wskazuje teraz na znak po ostatnim dopasowanym znaku frazy w zdaniu
    DEC CL           ; cofamy wska�nik o 1, by wskaza� na ostatni dopasowany znak
    MOV [BE], CL     ; BE = koniec frazy
    JMP ret

ret:
    RET

end:
    END