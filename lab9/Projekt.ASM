MOV CL, C1
MOV BL, D0
rs:
    IN 00          ; Pobierz znak z klawiatury do AL
    MOV [CL], AL    ; Zapisz pobrany znak w pami�ci wy�wietlacza pod adresem CL
    INC CL          ; Przesu� wska�nik wy�wietlacza o jeden znak w prz�d
    CMP CL, BL      ; Sprawd�, czy osi�gni�to koniec obszaru wy�wietlacza
    JNZ rs1         ; Je�li nie, przejd� do rs1
    MOV CL, C0       ; Je�li tak, zresetuj CL do pocz�tku (C0)
rs1:
    CMP AL, 2E      ; Sprawd�, czy wczytany znak jest znakiem ko�cz�cym
    JZ ds           ; Je�li tak, zako�cz procedur� (przejd� do ds)
    JMP rs          ; Je�li nie, kontynuuj wczytywanie znak�w

MOV CL, E0
MOV BL, EF
rs2:
    IN 00          ; Pobierz znak z klawiatury do AL
    MOV [CL], AL    ; Zapisz pobrany znak w pami�ci wy�wietlacza pod adresem CL
    INC CL          ; Przesu� wska�nik wy�wietlacza o jeden znak w prz�d
    CMP CL, BL      ; Sprawd�, czy osi�gni�to koniec obszaru wy�wietlacza
    JNZ rs1         ; Je�li nie, przejd� do rs1
    MOV CL, E0       ; Je�li tak, zresetuj CL do pocz�tku (C0)
rs12:
    CMP AL, DL      ; Sprawd�, czy wczytany znak jest znakiem ko�cz�cym
    JZ ds           ; Je�li tak, zako�cz procedur� (przejd� do ds)
    JMP rs  

MOV CL, EF
MOV BL, EF
rs3:
    IN 00          ; Pobierz znak z klawiatury do AL
    MOV [CL], AL    ; Zapisz pobrany znak w pami�ci wy�wietlacza pod adresem CL
    INC CL          ; Przesu� wska�nik wy�wietlacza o jeden znak w prz�d
    CMP CL, BL      ; Sprawd�, czy osi�gni�to koniec obszaru wy�wietlacza
    JNZ rs1         ; Je�li nie, przejd� do rs1
    MOV CL, E0       ; Je�li tak, zresetuj CL do pocz�tku (C0)
rs13:
    CMP AL, DL      ; Sprawd�, czy wczytany znak jest znakiem ko�cz�cym
    JZ ds           ; Je�li tak, zako�cz procedur� (przejd� do ds)
    JMP rs  

ds:
    RET   

END  