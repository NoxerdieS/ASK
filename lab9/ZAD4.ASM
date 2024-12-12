    MOV BL, 80
    MOV CL, C0
    CALL 20
    JMP reset

reset:
    MOV BL, 80
    CALL 40

next_call:
    MOV BL, 80
    MOV CL, C0
    CALL 60
    JMP endl

ORG 20
rep_read:
    IN 00
    MOV [BL], AL
    INC BL
    CMP BL, A0
    JZ wrap_read
check_enter:
    CMP AL, 0D
    JZ ret_read
    JMP rep_read

wrap_read:
    MOV BL, 80
    JMP check_enter

ret_read:
    RET

ORG 40
rep_convert:
    MOV AL, [BL]
    CMP AL, 0D
    JZ ret_convert
    ADD AL, 20
    MOV [BL], AL
    INC BL
    CMP BL, 9F
    JZ ret_convert
    JMP rep_convert

ret_convert:
    RET

ORG 60
rep_display:
    MOV AL, [BL]
    CMP AL, 0D
    JZ ret_display
    MOV [CL], AL
    INC CL
    INC BL
    CMP BL, 9F
    JZ ret_display
    JMP rep_display

ret_display:
    RET

endl:
    END
