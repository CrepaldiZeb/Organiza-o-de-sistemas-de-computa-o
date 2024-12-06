;RA: 21012485 NOME: Antônio Marcio Crepaldi Júnior 
;RA: 21014084 NOME: Yuka Sakai 
;RA: 21008388 NOME: Nathan Gonzalez Jurcevic
.MODEL SMALL

.DATA
pula db 13,10,'$'
ms1 db 'Digite um numero e aperte Enter:',13,10,'$'
ms2 db 'Digite outro numero e aperte Enter: $'
ms3 db 'Obrigado por usar a nossa calculadora =D$' 
op db ?
REP db ?
table12 db 13,10,'(+) --> Soma',13,10,'(-) --> subtracao',13,10,'(*) --> multi por 2 n times',13,10,'(/) --> Div por 2 n times',13,10,'(=) --> Sair$' 
P3 db ?
P2 db ? 
P1 db ?
L1 dw ?
L2 dw ?
 
.STACK 100H
.386 
.CODE
main proc

mov ax,@data
mov ds,ax

inicio:

mov ah, 09h ; pula
lea dx, pula
int 21h

mov ah, 09h ; imprime tabela
lea dx, table12
int 21h

mov ah, 09h ; pula
lea dx, pula
int 21h

mov ah, 01h ; pega o operando e joga em AL
int 21h

cmp al, 61 ;leva a opera??o para a EXIT
jz EXIT

lea bx , op 
mov [bx], al

mov ah, 09h ; pula
lea dx, pula
int 21h

mov ah, 09h ; pede o usuriao numero
lea dx, ms1
int 21h

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
mov ah, 09h ; imprime tabela
lea dx, ms2
int 21h

mov ah, 01h ; pegar o digito --> Al
int 21h

lea bx, L2
mov dx,0d
mov [bx],dx ; zera o L1 

sub al,30h ; numero 
mov [bx], al ; guarda o N lido em L1

mov di, 10d ; registrador secreto uuu

Inpt2:

mov ah, 01h ; pegar o digito --> Al
int 21h 

cmp al,13d
je X

sub al,30h ; numero 

xor cx,cx

mov cl, al

mov ax,[bx] ; resgata

mul di

add ax,cx

mov [bx], ax ; atualiza a variavel

jmp Inpt2

X:
lea bx, op ; pega op da memoria e compara
mov al, [bx]

lea bx,REP ; 
mov [bx], 0

lea bx, L1   ; N1 pra dh
mov dh, [bx]

lea bx, L2   ; N2 pra dl
mov dl, [bx]

cmp al, 43 ; leva a opera??o para soma
jz SOMA

cmp al, 45 ; leva a opera??o para subtra??o
jz SUBT

cmp al, 42 ; leva a opera??o para multiplica??o
jz MT

cmp al, 47 ; leva a opera??o para a subtra??o
jz DV


SOMA:
add dh, dl ; guarda a soma em dh

lea bx, REP  ; armazena o resultado em R
mov [bx],dh

jmp print

SUBT: 
sub dh, dl ; guarda a subtra??o em dh

lea bx, REP ; armazena o resultado em R
mov [bx],dh

jmp print

MT:
mov bh,1d ; var aux
add dl,1

MTI:
add dh,dh ; 
inc bh ; bh++
cmp dl,bh
jnz MTI ; pula se n?o for 0

lea bx, REP ; armazena o resultado em R
mov [bx],dh

jmp print

DV:
xor bx,bx
xor ax,ax

mov ah,dh ; joga N1 em ax
mov di ,2 ;prepara o dividendo
mov ch,dh
mov cl,dl
mov dx,0

divv:

div di  ;divides AX by DI, with quotient being stored in AX, and remainder in DX
inc bh ; bh++
cmp cl,bh
jnz divv ; pula se n?o for 0

xor bx,bx

lea bx, REP ; armazena o resultado em R
mov [bx],ah

print:

lea bx,REP ; armazena o resultado
mov di,[bx]

xor ax,ax

lea bx, REP ; Ax possui o Numero Resultado
mov ax, [bx]

printdp:

mov bx, ax ; backup do Resultado

;;;;;;;;;;; Pegar o resto !
mov ax,ax ;preparing the dividend
mov dx,0 ;zero extension
mov cx,10 ;preparing the divisor
div cx   ;divides AX by CX, with quotient being stored in AX, and remainder in DX

mov cx,bx ; backup in cx


lea bx, P3 ; endere?o da primeira variavel
mov [bx], dx ; armazena o Resto nesse endere?o

sub cx, dx ; Subtrai o resto de resultado

mov ax,cx ; 120 TA AQUI EM AX 

mov dx,0 ;zero extension
mov cx,10 ;preparing the divisor
div cx   ;divides AX by CX, with quotient being stored in AX, and remainder in DX


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PT2 


mov bx, ax ; backup do Resultado

;;;;;;;;;;; Pegar o resto !
mov ax,ax ;preparing the dividend
mov dx,0 ;zero extension
mov cx,10 ;preparing the divisor
div cx   ;divides AX by CX, with quotient being stored in AX, and remainder in DX

mov cx,bx ; backup in cx


lea bx, P2 ; endere?o da primeira variavel
mov [bx], dx ; armazena o Resto nesse endere?o

sub cx, dx ; Subtrai o resto de resultado

mov ax,cx ; 120 TA AQUI EM AX 

mov dx,0 ;zero extension
mov cx,10 ;preparing the divisor
div cx   ;divides AX by CX, with quotient being stored in AX, and remainder in DX
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PT3

mov bx, ax ; backup do Resultado

;;;;;;;;;;; Pegar o resto !
mov ax,ax ;preparing the dividend
mov dx,0 ;zero extension
mov cx,10 ;preparing the divisor
div cx   ;divides AX by CX, with quotient being stored in AX, and remainder in DX

mov cx,bx ; backup in cx


lea bx, P1 ; endere?o da primeira variavel
mov [bx], dx ; armazena o Resto nesse endere?o

sub cx, dx ; Subtrai o resto de resultado

mov ax,cx ; 120 TA AQUI EM AX 

mov dx,0 ;zero extension
mov cx,10 ;preparing the divisor
div cx   ;divides AX by CX, with quotient being stored in AX, and remainder in DX


mov ah, 09h ; pula
lea dx, pula
int 21h


xor dx,dx
 
lea bx, P1
mov dx, [bx]

add dx, 30h

mov ah, 02h
int 21h

xor dx,dx
 
lea bx, P2
mov dx, [bx]

add dx, 30h

int 21h

xor dx,dx
 
lea bx, P3
mov dx, [bx]

add dx, 30h   

int 21h

jmp inicio

EXIT:

mov ah, 09h ; pula
lea dx, pula
int 21h

mov ah, 09h ; mensagem de despedida
lea dx, ms3
int 21h

MOV AH, 4CH ; termina programa
INT 21H

main endp
END main