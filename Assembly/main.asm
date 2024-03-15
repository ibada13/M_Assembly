
include C:\masm32\include\masm32rt.inc 
.stack 4096
.data

prompt db "hello wrold: ",0
del db "world",0
minput DB 50 DUP(?)
slen db 0
.code 
;
;1 str => size at cx
strlen proc
mov eax , [esp + 4 ]
cmp byte ptr [eax],0
je retl
xor cx,cx

l1:

inc cx 
inc eax
cmp byte ptr [eax],0
jne l1
retl:

ret

strlen endp
;1 should be included in 2
checkstrinstr proc
mov eax,[esp + 4 ]
mov ebx,[esp + 8 ]
push ebp
mov ebp,esp

sub esp ,8

push eax
call strlen
mov word ptr [ebp-4],cx
add esp,4
push ebx
call strlen
mov word ptr [ebp-8],cx

add esp,4
cmp cx,[ebp - 4 ]
jl retl
l1:

mov edx,[eax]
cmp edx,[ebx]
jne l2
dec cx
cmp cx,0
je retl
inc ebx



l2:
inc ax
mov dx,[ebp - 4]
dec dx
mov [ebp - 4],dx
cmp cx,dx
jl retl
jmp l1
;push offset zmesg
;call StdOut

zl:
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
l3:
cmp byte ptr [ebx],0
je l2
cmp byte ptr [eax],0
je l2

l1:




cmp byte ptr [ebx],0
jne l3
cmp byte ptr [edx],0
jne l3
l2:

removestr endp
start: 
    push offset prompt
    push offset del
    call checkstrinstr    
    invoke ExitProcess,1
end start
