    MOV DL, 2E         ; znak koñcz¹cy dla zdania to '.'
    MOV CL, C0         ; pocz¹tek zapisu zdania
    MOV BL, DF         ; koniec zakresu dla zdania      
    MOV [BA], CL       ; przechowaj adres w komórce pamiêci B0
    CALL 30

    MOV DL, 0D         ; znak koñcz¹cy dla frazy to Enter
    MOV CL, E0         ; pocz¹tek zapisu frazy
    MOV BL, EF         ; koniec zakresu dla frazy
    MOV [BA], CL       ; przechowaj adres w komórce pamiêci B0
    CALL 30

    MOV CL, F0         ; pocz¹tek zapisu frazy zastêpuj¹cej
    MOV BL, FF         ; koniec zakresu dla frazy
    MOV [BA], CL       ; przechowaj adres w komórce pamiêci B0
    CALL 30
    CALL 4A

ORG 30			; procedura wczytuj¹ca dane
rs:
    IN 00              ; wczytaj znak do AL
    MOV [CL], AL       ; zapisz znak w pamiêci wyœwietlacza
    INC CL
    CMP CL, BL
    JNZ rs1
    MOV AL, BA       ; wczytaj wartoœæ pocz¹tkow¹ z komórki pamiêci 70
    MOV CL, [AL]         ; ustaw wartoœæ w rejestrze CL
rs1:
    CMP AL, DL         ; sprawdŸ znak koñcz¹cy
    JZ ret
    JMP rs

ORG 4A		; procedura porównuj¹ca zdanie i frazê
    MOV CL, C0    ; wskaŸnik na pocz¹tek zdania
    MOV DL, E0    ; wskaŸnik na pocz¹tek frazy
    MOV AL, 0
    MOV [BC], AL  ; isfound = 0

rep:
    MOV AL, [CL]  ; AL = bie¿¹cy znak ze zdania
    MOV BL, [DL]  ; BL = bie¿¹cy znak z frazy
    CMP AL, BL
    JZ matched_char
    CMP AL, 2E     ; sprawdŸ czy koniec zdania
    JZ ret         ; jeœli tak, wyjdŸ (fraza nieznaleziona)
    ; Niezgodnoœæ, reset:
    MOV AL, 0
    MOV [BC], AL   ; isfound = 0
    MOV DL, E0     ; wróæ do pocz¹tku frazy
    INC CL         ; przejdŸ do kolejnej litery zdania
    JMP rep

matched_char:
    MOV BL,[BC]
    CMP BL,0       ; sprawdŸ czy isfound = 0 (pierwszy pasuj¹cy znak frazy)
    JNZ continue_match

    ; Pierwszy pasuj¹cy znak
    MOV AL,1
    MOV BL,BC
    MOV [BL],AL     ; isfound = 1
    MOV BL,BD
    MOV [BL],CL     ; BD = pocz¹tek wyst¹pienia

continue_match:
    INC CL
    INC DL
    MOV BL,[DL]
    CMP BL,0D
    JZ phrase_end   ; dopiero teraz sprawdŸ, czy koniec frazy!
    JMP rep

phrase_end:
    ; Ca³a fraza dopasowana, BL = 0D oznacza koniec frazy
    ; CL wskazuje teraz na znak po ostatnim dopasowanym znaku frazy w zdaniu
    DEC CL           ; cofamy wskaŸnik o 1, by wskazaæ na ostatni dopasowany znak
    MOV [BE], CL     ; BE = koniec frazy
    JMP ret

ret:
    RET

end:
    END