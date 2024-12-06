
.MODEL SMALL

pula MACRO 
mov ah,2 
mov DL,0AH     ;caraScter LF para a tela
int 21h        ;exibe
mov DL,0DH     ;caracter CR para a tela
int 21h        ;exibe
ENDM

print MACRO FONTE          
LEA dx, FONTE         
MOV ah, 09h
int 21h  
ENDM

.DATA
pula db 13,10,'$'
msg1 db 'Digite um numero e aperte Enter:',13,10,'$'
L1 dw ?

.STACK 100H
.386 
.CODE
main proc

mov ax,@data
mov ds,ax

pula
print msg1
pula

call leitura

xor ax,ax

lea bx, L1              
mov al, [bx]    ;fica armazenado em al 

MOV AH, 4CH ; termina programa
INT 21H

main endp
leitura proc
push ax
push bx
push cx
push dx

xor dx, dx ; prepara dh para guardar a soma de inputs

LN1:
mov ah, 01h ; pegar o digito --> Al
int 21h

lea bx, L1 ; acessar a variavel L1
mov dx,0d
mov [bx],dx ; zera o L1 

sub al,30h ; numero 
mov [bx], al ; guarda o N lido em L1

mov di, 10d ; registrador secreto uuu

Inpt1:

mov ah, 01h ; pegar o digito --> Al 
int 21h 

cmp al,13d
je LN2

sub al,30h ; numero 

xor cx,cx

mov cl, al ; guarda o numero efetivo em cl

mov ax,[bx] ; resgata

mul di ; multiplica ax por 10

add ax,cx ; soma lida agora com somatoria multiplicada

mov [bx], ax ; atualiza a variavel

jmp Inpt1

LN2:
pop dx 
pop cx
pop bx 
pop ax

ret
leitura endp
END main