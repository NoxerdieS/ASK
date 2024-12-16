    MOV CL,C0
    MOV DL,E0

; Wczytanie zdania
rs:
    IN 00
    MOV [CL],AL
    INC CL
    CMP CL,DF
    JNZ rs1
    MOV CL,C0
rs1:
    CMP AL,2E
    JZ ds
    JMP rs
ds:

; Wczytanie frazy do znalezienia
    MOV DL,E0
rf:
    IN 00
    MOV [DL],AL
    INC DL
    CMP DL,EF
    JNZ rf1
    MOV DL,E0
rf1:
    CMP AL,0D
    JZ df
    JMP rf
df:

; Liczenie d³ugoœci frazy
    MOV BL,E0
    MOV AL,0
clp:
    MOV DL,[BL]
    CMP DL,0D
    JZ dlen
    INC AL
    INC BL
    JMP clp
dlen:
    MOV BL,71
    MOV [BL],AL

; Wczytanie frazy zastêpuj¹cej
    MOV DL,F0
rr:
    IN 00
    MOV [DL],AL
    INC DL
    CMP DL,FF
    JNZ rr1
    MOV DL,F0
rr1:
    CMP AL,0D
    JZ dr
    JMP rr
dr:

; Wyszukiwanie frazy
    MOV CL,C0
    MOV DL,E0
    MOV BL,70
	MOV AL, 0
    MOV [BL],AL

sr:
    MOV AL,[CL]
    MOV BL,[DL]
    CMP AL,BL
    JZ cmpm
    CMP AL,2E
    JZ endp
    INC CL
    MOV DL,E0
    MOV BL,70
	MOV AL, 0
    MOV [BL], AL
    JMP sr

cmpm:
    MOV BL,70
    MOV AL,[BL]
    INC AL
    MOV [BL],AL
    MOV BL,71
    MOV DL,[BL]
    CMP AL,DL
    JZ matched
    INC CL
    INC DL
    JMP sr

matched:
; Tu logika zamiany frazy na inn¹ (niezaimplementowana)
    JMP endp

endp:
    END
