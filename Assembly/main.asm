.386 
.model flat, stdcall 

includelib C:\masm32\lib\kernel32.lib 
    ExitProcess PROTO STDCALL :DWORD
.data
count = 500
slptr dd $
sum byte 15h
notsum word 155h
tes byte 20 dup(10h)
x equ <10>
move equ <mov>
instm equ <move al , x> 
grtting byte "hello world",'\0'
.code 
main proc 
main endp
start: 
    

 mov ax,05h
 xor ax,ax 
 mov sum,al
 mov notsum,ax
 nop
 mov eax,slptr 
 add eax,4
 lea ebx, sum
    xor ax,ax
    nop 
    nop
    instm
    invoke ExitProcess,0 
end start
end