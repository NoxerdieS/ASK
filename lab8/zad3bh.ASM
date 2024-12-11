on:
	mov AL, 80
	out 03
rep:
	in 03
	cmp AL, 1
	jnz on

	mov AL, 0
	out 03
	
JMP rep
end