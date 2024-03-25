

include C:\masm32\include\masm32rt.inc 


.data

prompt db "hello world: ",0
pass db "password",0
inp db 25 dup(?)
wel db "ctf level: easy ",10," welcom admin " , 10 , "enter the password : ",0
passc db "welcome admin ", 0 
passw db "not welcome" , 0 
there db 50 dup(0)
minput DB 50 DUP(?)
slen db 0
.code 
;
;1 str => size at cx
;------------------------------------------------------------
;strlen, 
; Calculates the lenght of string.
; as input : EAX CONTAINS offset of the string should be pushed
;
; Returns: cx = lenght.
;-------------------------------------------------------------


strlen proc
PUSH EAX
MOV eax , [esp + 8]
xor cx,cx
l1:
cmp byte ptr [eax],0
je retl


inc cx 
inc eax
JMP l1
retl:
pop eax
retn 4

strlen endp


strcmp proc

PUSH EAX
mov eax, [esp + 8] 
push ecx
push ebx
mov ebx,[esp + 20]
PUSH EBP 
MOV EBP ,ESP 
SUB ESP , 4
push eax 
call strlen
mov dx , cx
push ebx
call strlen 
cmp cx, dx
jne retl
l1:
mov dl,[eax]
cmp dl,[ebx]
jne retl
cmp dl,0
je retl
inc eax
inc ebx 
jmp l1
retl:
mov esp,ebp
pop ebp 
pop ebx
pop ecx
POP EAX
ret
strcmp endp
;------------------------------------------------------------
;strcpy
; copy string into anothter
;
; Receives: destnition offset should pushed first and well declerad
; source offset should pushed secondly and null terminjated
; 
; reurnes : cx containes the number of chracter that are copied
;-------------------------------------------------------------
strcpy proc
push ebx
push eax
push edx
mov eax , [esp + 16]
mov ebx , [esp + 20 ]

xor cx,cx 
l1:
cmp byte ptr [ebx],0
je retl
mov dl,[ebx]
mov [eax],dl
inc eax
inc bx
inc cx
jmp l1
retl:

mov byte ptr [eax],00h
pop edx
pop eax
pop ebx
ret
strcpy endp

;1 should be included in 2: the adress of 1 that si in 2 will be in ebx else cx is 0 
checkstrinstr proc
mov eax,[esp + 4 ];1
mov ebx,[esp + 8 ];2
push ebp
mov ebp,esp

sub esp ,8

push eax
call strlen
mov word ptr [ebp-4],cx
cmp cx,0 
jle retl
add esp,4
push ebx
call strlen
mov word ptr [ebp-8],cx
cmp cx,0 
jle retl
add esp,4
mov dl,[eax]
l1:
cmp cx,[ebp - 4 ]
jl retl

cmp dl,[ebx]
jne l2
push dx
push cx
push eax
push ebx

call strcmp
mov eax,[esp + 4]
mov cx,[esp+ 8]
add esp , 8
cmp dl,0 
je retl

mov dl,[esp]


l2:
inc ebx
dec cx
jmp l1
;push offset zmesg
;call StdOut

retl:
mov esp,ebp
pop ebp
ret
checkstrinstr endp
;p3 = the one we want to remove ,p2= the target , p1 destnition
removestr proc

pop eax ; rm
pop ebx ; tr
pop edx ; des
push ebp 
mov ebp,esp
sub esp,12
push eax
call strlen
mov [ebp - 4 ],cx
push edx
call strlen
mov [ebp - 12 ],cx
push ebx
call strlen
mov [ebp - 8 ],cx
cmp cx,[ebp - 4]
jl retl
sub cx,[ebp - 4]
cmp cx,[ebp - 12]
jl retl
;cmp [ebp - 4],0
jle retl
mov cl,[eax]
l1:
cmp [ebx],cl
jne l2


l2:
inc ebx

push ebx 
push eax
call checkstrinstr
cmp cx,0
je retl




retl:
mov esp,ebp
pop ebp
ret
removestr endp
start: 

	push offset wel
	call StdOut
	push 50
	push offset inp
	call StdIn
	push offset inp
	push offset pass 
	
	call strcmp
	cmp dl , 0
	jne endl
	
		
		push offset passc
		call StdOut
                   invoke ExitProcess , 1                   
	endl:
                    push offset passw 
                    call StdOut
	invoke ExitProcess , 0
	
end start
