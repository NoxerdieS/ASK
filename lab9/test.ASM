;----------------------------------------------------
; G£ÓWNA CZÊŒÆ PROGRAMU
;----------------------------------------------------

    MOV CL, C0         ; Wczytanie zdania do C0.. a¿ do Enter
    CALL 13

    MOV CL, E0         ; Wczytanie frazy do E0.. a¿ do Enter
    CALL 13

    MOV CL, F0         ; Wczytanie frazy zastêpuj¹cej do F0.. a¿ do Enter
    CALL 13

    ; Wywo³ujemy wyszukiwanie i zamianê. 
    ; Uwaga: teraz samo wyszukiwanie (ORG 26) zawiera w sobie pêtlê wielokrotnego wyszukiwania.
    CALL 22




;----------------------------------------------------
; PROCEDURA Wczytywania danych (ORG 18)
;----------------------------------------------------
; Wczytuje znaki z klawiatury do [CL], a¿ do napotkania Enter (0D).

ORG 13
rs:
    IN 00             ; pobierz znak do AL
    MOV [CL], AL      ; zapisz w pamiêci
    INC CL
    CMP AL, 0D        ; jeœli Enter, zakoñcz
    JZ finish
    JMP rs

finish:
    RET


;----------------------------------------------------
; PROCEDURA Wielokrotnego Wyszukiwania i Zamiany (ORG 26)
;----------------------------------------------------
; - Szuka frazy (E0..0D) w zdaniu (C0..)
; - Koñczy przy kropce ('.' = 2E) lub gdy nie ma dalszych dopasowañ.
; - Za ka¿dym znalezieniem frazy wywo³uje zamianê (ORG 79).

ORG 22
start_search:
    MOV CL, C0       ; CL = wskaŸnik na pocz¹tek zdania
cont_search:
    ; BD = 0 => nie mamy dopasowania
    MOV BL, 0      
MOV [BD], BL

    MOV DL, E0       ; DL = pocz¹tek frazy

rep:
    MOV AL, [CL]     ; pobierz znak zdania
    CMP AL, 2E       ; sprawdŸ kropkê
    JZ end_search    ; jeœli '.', koñcz przetwarzanie

    ; porównaj z bie¿¹cym znakiem frazy
    MOV BL, [DL]     ; BL = znak frazy
    CMP AL, BL
    JZ matched_char

    ; brak dopasowania:
    MOV BL, 0      
MOV [BD], BL     ; BD = 0
    MOV DL, E0       ; wróæ do pocz¹tku frazy
    INC CL
    JMP rep

matched_char:
    ; sprawdŸ, czy BD ju¿ ustawione (czyli czy to kontynuacja dopasowania)
    MOV BL, BD
    MOV AL, [BL]
    CMP AL, 0
    JNZ continue_match

    ; skoro AL=0 -> pierwszy znak pasuje => zapamiêtaj w BD pocz¹tek
	MOV [BC], AL
	MOV CL, [BC]
    MOV [BL], AL     ; BD = CL

continue_match:
    INC CL
    INC DL
    MOV BL, [DL]
    CMP BL, 0D       ; koniec frazy?
    JZ phrase_end
    JMP rep

phrase_end:
    DEC CL
    MOV [BE], CL       ; BE = koniec wyst¹pienia
    CALL 90            ; dokonaj zamiany

    ; Po zamianie przesuwamy siê o 1 dalej, ¿eby nie zaczynaæ wyszukiwania
    ; od œrodka tego samego fragmentu.
    MOV AL, [BE]
    INC AL
	MOV [BC], AL
	MOV CL, [BC]

    ; Reset frazy
    MOV DL, E0

    ; BD = 0 => nie mamy aktywnego dopasowania
    MOV BL, 0
    MOV [BD], BL

    JMP rep            ; wracamy do pêtli wyszukiwania


end_search:
    ; Natrafiliœmy na kropkê, koñczymy wyszukiwanie
    RET


;----------------------------------------------------
; PROCEDURA Zamiany (ORG 79)
;----------------------------------------------------
; Zamienia fragment [BD]..[BE] w zdaniu na frazê z F0.. (koñcz¹c¹ siê 0D)
; Nadpisuje tyle bajtów, ile wynosi ró¿nica [BE]-[BD] + 1.
; Jeœli fraza zastêpuj¹ca jest krótsza/d³u¿sza - ta prosta wersja tylko nadpisze 
; w obrêbie [BD]..[BE]. Dalsze dopasowanie w zdaniu realizujemy bez przesuwania.

ORG 90
    ; AL, BL, CL, DL uwaga na to, co jest w rejestrach
    ; Wejœcie:
    ;  - [BD], [BE] => zakres do nadpisania
    ;  - Fraza zastêpuj¹ca w F0..(0D)
    ;
    ; Za³ó¿my, ¿e w start_search zaraz przed CALL 79:
    ;    CL wskazuje na koniec dopasowania (CL=[BE]),
    ;    Ale my i tak ustalimy rejestry tutaj.

    ; Pocz¹tek frazy zastêpuj¹cej -> AL
    MOV AL, F0

    ; Pocz¹tek zastêpowanego obszaru -> CL = [BD]
    MOV BL, BD
    MOV CL, [BL]

    ; Pierwszy znak frazy zastêpuj¹cej:
    MOV DL, [AL]

switch_loop:
    MOV [CL], DL
    INC AL
    INC CL

    CMP CL, [BE]
    JZ last_char
    JMP switch_continue

last_char:
    ; Wstaw jeszcze ostatni znak
    MOV DL, [AL]
    MOV [CL], DL
    ; Mo¿na dodaæ sygna³/wyœwietlenie
    ; np. MOV AL, 21 / OUT 01
    RET

switch_continue:
    ; SprawdŸ czy przypadkiem nie dotarliœmy do 0D w frazie zastêpuj¹cej
    MOV DL, [AL]
    CMP DL, 0D
    JZ ret_early     ; jeœli koniec frazy zastêpuj¹cej -> koñcz pêtlê

    JMP switch_loop

ret_early:
    RET
END

