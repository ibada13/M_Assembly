
include C:\masm32\include\masm32rt.inc 
.stack 4096
.data

prompt db "hello world: ",0
del db "world",0
dell db "world",0

minput DB 50 DUP(?)
slen db 0
.code 
;
;1 str => size at cx
strlen proc
push eax
mov eax , [esp + 8 ]
cmp byte ptr [eax],0
je retl
xor cx,cx

l1:

inc cx 
inc eax
cmp byte ptr [eax],0
jne l1
retl:
pop eax
ret

strlen endp
strcmp proc
push ebx
mov  eax,[esp + 12]
mov  ebx,[esp+8]
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
pop ebx
ret
strcmp endp


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
cmp [ebp - 4],0
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
je retl:




retl:
mov esp,ebp
pop ebp
ret
removestr endp
start: 
    push offset prompt ; p>d
    push offset del
    call checkstrinstr   
    push ebx 
    call StdOut
    invoke ExitProcess,1
end start
