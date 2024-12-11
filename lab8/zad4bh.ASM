mov AL, FF 
out 04
jmp start
ORG 07
rep:
out 04
dec BL
jnz rep
ret
start:
mov AL, 4F
mov BL, A
call 07
mov AL, 1F
mov BL, 2
call 07
mov AL, 8F
mov BL, 5
call 07
mov AL, 1F
mov BL, 3
call 07
mov AL, 4F
mov BL, 5
call 07
mov AL, 1F
mov BL, 3
call 07
mov AL, 8F
mov BL, 7
call 07
mov AL, 2F
mov BL, 5
call 07
mov AL, 8F
mov BL, 3
call 07
mov AL, 1F
mov BL, 7
call 07
mov AL, 4F
mov BL, B
call 07
end