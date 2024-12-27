; --- Kod i wektor w niskich adresach
ORG 00
JMP start
DB 10
DB 00

ORG 05
start:
loop_main:
    INT 02
    JMP loop_main

; --- Procedura przerwania INT 04 (od 1E)
ORG 10
int_04_handler:
    IN 00          ; AL = znak z klawiatury

    ; read w [50], write w [51]
    MOV DL, 50
    MOV BL, [DL]   ; BL = read
    MOV DL, 51
    MOV CL, [DL]   ; CL = write

    ; zapisz AL do bufora (60..64) => base 60 + CL
    MOV DL, 60
    ADD DL, CL
    MOV [DL], AL

    ; inkrementacja write
    INC CL
    CMP CL, 05
    JNZ store_write
    MOV CL, 00
store_write:
    ; sprawdz kolizje
    CMP CL, BL
    JNZ done_ptr
    INC BL
    CMP BL, 05
    JNZ skip_read_reset
    MOV BL, 00
skip_read_reset:

done_ptr:
    ; zapisz read
    MOV DL, 50
    MOV [DL], BL
    ; zapisz write
    MOV DL, 51
    MOV [DL], CL

    ; jesli AL=0D, wyswietl
    CMP AL, 0D
    JNZ end_int
    JMP disp_buffer

disp_buffer:
    ; wczytaj read i write
    MOV DL, 50
    MOV BL, [DL]
    MOV DL, 51
    MOV CL, [DL]

disp_loop:
    CMP BL, CL
    JZ disp_done
    ; pobierz z bufora
    MOV DL, 60
    ADD DL, BL
    MOV AL, [DL]

    ; wyslij do portu 01
    OUT 01

    ; inkrementuj BL
    INC BL
    CMP BL, 05
    JNZ skip_wrap
    MOV BL, 00
skip_wrap:
    ; zapisz read
    MOV DL, 50
    MOV [DL], BL
    JMP disp_loop

disp_done:
end_int:
    IRET

; --- Zmienne w pamiêci
ORG 90
DB 00   ; read
DB 00   ; write

ORG A0
DB 00
DB 00
DB 00
DB 00
DB 00   ; 5-bajtowy bufor

END
