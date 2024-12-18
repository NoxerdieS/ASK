MOV CL, C1
MOV BL, D0
rs:
    IN 00          ; Pobierz znak z klawiatury do AL
    MOV [CL], AL    ; Zapisz pobrany znak w pamiêci wyœwietlacza pod adresem CL
    INC CL          ; Przesuñ wskaŸnik wyœwietlacza o jeden znak w przód
    CMP CL, BL      ; SprawdŸ, czy osi¹gniêto koniec obszaru wyœwietlacza
    JNZ rs1         ; Jeœli nie, przejdŸ do rs1
    MOV CL, C0       ; Jeœli tak, zresetuj CL do pocz¹tku (C0)
rs1:
    CMP AL, 2E      ; SprawdŸ, czy wczytany znak jest znakiem koñcz¹cym
    JZ ds           ; Jeœli tak, zakoñcz procedurê (przejdŸ do ds)
    JMP rs          ; Jeœli nie, kontynuuj wczytywanie znaków

MOV CL, E0
MOV BL, EF
rs2:
    IN 00          ; Pobierz znak z klawiatury do AL
    MOV [CL], AL    ; Zapisz pobrany znak w pamiêci wyœwietlacza pod adresem CL
    INC CL          ; Przesuñ wskaŸnik wyœwietlacza o jeden znak w przód
    CMP CL, BL      ; SprawdŸ, czy osi¹gniêto koniec obszaru wyœwietlacza
    JNZ rs1         ; Jeœli nie, przejdŸ do rs1
    MOV CL, E0       ; Jeœli tak, zresetuj CL do pocz¹tku (C0)
rs12:
    CMP AL, DL      ; SprawdŸ, czy wczytany znak jest znakiem koñcz¹cym
    JZ ds           ; Jeœli tak, zakoñcz procedurê (przejdŸ do ds)
    JMP rs  

MOV CL, EF
MOV BL, EF
rs3:
    IN 00          ; Pobierz znak z klawiatury do AL
    MOV [CL], AL    ; Zapisz pobrany znak w pamiêci wyœwietlacza pod adresem CL
    INC CL          ; Przesuñ wskaŸnik wyœwietlacza o jeden znak w przód
    CMP CL, BL      ; SprawdŸ, czy osi¹gniêto koniec obszaru wyœwietlacza
    JNZ rs1         ; Jeœli nie, przejdŸ do rs1
    MOV CL, E0       ; Jeœli tak, zresetuj CL do pocz¹tku (C0)
rs13:
    CMP AL, DL      ; SprawdŸ, czy wczytany znak jest znakiem koñcz¹cym
    JZ ds           ; Jeœli tak, zakoñcz procedurê (przejdŸ do ds)
    JMP rs  

ds:
    RET   

END  