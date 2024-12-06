;RA: 21012485 NOME: Antônio Marcio Crepaldi Júnior 
;RA: 21014084 NOME: Yuka Sakai 
;RA: 21008388 NOME: Nathan Gonzalez Jurcevic
.MODEL SMALL

.DATA  
msg1 db '       ======================',13,10,'$'
msg2 db '       |                    |',13,10,'$'
msg3 db '       ======================',13,10,'$'
msg4 db '       == + == - == * == / ==',13,10,'$'
msg5 db '       ======================',13,10,'$'
msg6 db '       == x^y == x^2 == |x| =',13,10,'$'
msg7 db '       ======================',13,10,'$'
msg8 db '       == 10^x == y%x == = ==',13,10,'$'
msg9 db '       ======================',13,10,'$'
pula db '',13,10,'$'
dn1 db 'Digite o primeiro Numero: $'
dn2 db 'Digite o segundo Numero: $'
msgInicial db 'Qual operacao ? (use (e) para (^) e ascii de (|) = 124)',13,10,'$'
msgA db 'Voce escolheu: Soma',13,10,'$'
msgB db 'Voce escolheu: Subtracao',13,10,'$'
msgC db 'Voce escolheu: Multiplicacao',13,10,'$'
msgD db 'Voce escolheu: Divisao',13,10,'$'
msgE db 'Voce escolheu: X elevado a Y',13,10,'$'
msgF db 'Voce escolheu: X elevado ao quadrado',13,10,'$'
msgG db 'Voce escolheu: Modulo de X',13,10,'$'
msgH db 'Voce escolheu: 10 elevado a X',13,10,'$'
msgI db 'Voce escolheu: Porcentagem',13,10,'$'
erro db 'Nao entendi. Digite novamente ?',13,10,'$'
Ope db ?
n1 db ?
n2 db ?
R db ?
.STACK 100H
.386

.CODE 
    main proc
    mov ax, @DATA
    mov ds,ax
    
    call pri_calc
    call escolhe_op
    call leitura
    call efetuar

    xor ax,ax

    lea bx,n1
    mov ax,[bx]

    lea bx,n2
    mov ax,[bx]

    lea bx, R
    mov ax,[bx]

    call _out

    mov ah,4ch
    int 21h
    main endp

    efetuar proc 
    push ax
    push bx
    push cx
    push dx

    lea bx,ope

    cmp [bx],1
    jz somar

    cmp [bx],2
    jz subtrair

    cmp [bx],3
    jz multiplicar

    cmp [bx],4
    jz dividir

    cmp [bx],5
    jz _10_elevado

    cmp [bx],6
    jz modular

    cmp [bx],7
    jz percentual

    cmp [bx],8
    jz x_elevado_y

    cmp [bx],9
    jz x_ao_quadrado

    somar:
    call soma
    jmp saindo

    subtrair:
    call subt
    jmp saindo

    multiplicar:
    call mult
    jmp saindo

    dividir:
    call divs
    jmp saindo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    _10_elevado:
    call _10_ev
    jmp saindo

    modular:
    call module
    jmp saindo

    percentual:
    call perc
    jmp saindo

    x_elevado_y:
    call exp
    jmp saindo

    x_ao_quadrado:
    call ev_2
    
    saindo:
    pop dx
    pop cx
    pop bx
    pop ax

    ret

    efetuar endp


    leitura proc
    push ax
    push bx
    push cx
    push dx

    lea bx,ope

    cmp [bx],1
    jz d_inp

    cmp [bx],2
    jz d_inp

    cmp [bx],3
    jz d_inp

    cmp [bx],4
    jz d_inp

    cmp [bx],7
    jz d_inp

    cmp [bx],8
    jz d_inp

    mov ah,09h
    lea dx,pula
    int 21H

    lea dx,dn1
    int 21h

    call inp
    
    lea bx,n1
    mov [bx],ax

    jmp fim

    d_inp:
    mov ah,09h
    lea dx,pula
    int 21H

    lea dx,dn1
    int 21h

    xor ax,ax

    call inp
    
    lea bx,n1
    mov [bx],ax

    mov ah,09h
    lea dx,pula
    int 21H

    lea dx,dn2
    int 21h

    call inp
    
    lea bx,n2
    mov [bx],ax

    fim: 
    pop dx 
    pop CX
    pop BX
    pop ax

    ret
    leitura endp


    escolhe_op proc

    beg:
    mov ah,09h
    lea dx, msgInicial
    int 21h

    lea bx,ope

    mov ah,01h
    int 21H
        
    cmp al,43
    jz mais
    
    cmp al,45
    jz menos

    cmp al,42
    jz multplica

    cmp al,47
    jz diviz

    cmp al,31h
    jz _10_elv

    cmp al,124
    jz module1

    cmp al,121
    jz percent

    cmp al,120
    jz _x

    mov ah,09h
    lea dx, erro 
    int 21H

    jmp beg

    mais:

    mov ah,09h
    lea dx,msgA
    int 21h

    mov dx,1
    mov [bx],dx
    jmp exit2

    menos:
    mov dx,2
    mov [bx],dx

    mov ah,09h
    lea dx,msgB
    int 21h

    jmp exit

    multplica:
    mov dx,3
    mov [bx],dx

    mov ah,09h
    lea dx,msgC
    int 21h

    jmp exit

    diviz:
    mov dx,4
    mov [bx],dx

    mov ah,09h
    lea dx,msgD
    int 21h

    jmp exit

    _10_elv:
    mov dx,5
    mov [bx],dx

    mov ah,09h
    lea dx,msgH
    int 21h

    jmp exit

    module1:
    mov dx,6
    mov [bx],dx

    mov ah,09h
    lea dx,msgG
    int 21h

    jmp exit

    percent:
    mov dx,7
    mov [bx],dx

    mov ah,09h
    lea dx,msgI
    int 21h

    jmp exit

    _x:         ;começa com x
    mov ah,01h 
    int 21H

    mov ah,01h 
    int 21H

    cmp al,121
    jz x_elv_y_

    mov dx,9
    mov [bx],dx

    mov ah,09h
    lea dx,msgF
    int 21h

    jmp exit

    x_elv_y_:
    mov dx,8
    mov [bx],dx

    mov ah,09h
    lea dx,msgE
    int 21h


    exit:
    exit2:
    ret


    escolhe_op endp
;;;;;;;;;;;;;;;;;;;;;;;; SOMA
    soma proc
    push ax     
    push bx
    push cx 
    push dx     ;backup dos regs antes do proc

    lea bx, N1    ;lê numero 1 da memoria
    xor ax,ax
    mov ax,[bx]

    lea bx, N2      ;lê numero 2 da memoria
    
    add ax, [bx]    ;soma acontecendo (N1+N2) 

    lea bx, R
    mov [bx], ax    ;salvando em Resposta

    pop dx
    pop cx
    pop bx
    pop ax    ;devolve os valores dos regs 

    ret
    soma endp
;;;;;;;;;;;;;;;;;;;;;;;; Subtração
    subt proc
    push ax     
    push bx
    push cx 
    push dx     ;backup dos regs antes do proc

    lea bx, N1    ;lê numero 1 da memoria
    mov ax,[bx]

    lea bx, N2      ;lê numero 2 da memoria
    
    sub ax, [bx]    ;subtração acontecendo (N1-N2) 

    lea bx, R
    mov [bx], ax    ;salvando em Resposta

    pop dx
    pop cx
    pop bx
    pop ax    ;devolve os valores dos regs 

    ret
    subt endp
;;;;;;;;;;;;;;;;;;;;;;;; Multplicação
    mult proc
    push ax     
    push bx
    push cx 
    push dx     ;backup dos regs antes do proc

    lea bx, N1    ;lê numero 1 da memoria
    mov ax,[bx]

    lea bx, N2      ;lê numero 2 da memoria e prepara cx
    mov cx,[bx]

    mul cx

    lea bx,R        ;armazena resultado de mul em R
    mov [bx], ax

    pop dx
    pop cx
    pop bx
    pop ax    ;devolve os valores dos regs 
    
    ret
    mult endp
;;;;;;;;;;;;;;;;;;;;;;;; Divisão
    divs proc
    push ax     
    push bx
    push cx 
    push dx     ;backup dos regs antes do proc

    lea bx, N1    ;lê numero 1 da memoria
    mov ax,[bx]

    lea bx, N2      ;lê numero 2 da memoria e prepara cx
    mov cx,[bx]

   xor dx, dx   ; preparando dx para a div

    div cx

    lea bx,R        ;armazena resultado de mul em R
    mov [bx], ax

    pop dx
    pop cx
    pop bx
    pop ax    ;devolve os valores dos regs 

    ret
    divs endp
;;;;;;;;;;;;;;;;;;;;;;;; Exponencial
    exp proc
    push ax     
    push bx
    push cx 
    push dx     ;backup dos regs antes do proc

    lea bx, N1    ;lê N1 da memoria
    mov ax,[bx]

    lea bx, N2    ;lê N2 da memoria e prepara as iterações
    mov dx,[bx]

    mov cx, ax ; multiplicador

    sub dx,1d ; numero de iterações corretas

    ;;; EX: 3^4 3*3*3*3

    mult1:
    mul cx
    loop mult1

    lea bx,R        ; armazena o resultado em R
    mov [bx],ax

    pop dx
    pop cx
    pop bx
    pop ax    ;devolve os valores dos regs 

    ret

    exp endp
    ;;;;;;;; Numero elevado a 2
    ev_2 proc
    push ax     
    push bx
    push cx 
    push dx     ;backup dos regs antes do proc

    lea bx, N1    ;lê N1 da memoria
    mov ax,[bx]

    mov cx, ax

    mul cx

    lea bx, R       ; armazena resultado em R
    mov [bx],ax

    
    pop dx
    pop cx
    pop bx
    pop ax    ;devolve os valores dos regs 

    ret
    ev_2 endp

    ;;;;;;;;;; Modulo de um numero

    module proc
    push ax     
    push bx
    push cx 
    push dx     ;backup dos regs antes do proc

    lea bx, N1    ;lê N1 da memoria
    mov ax,[bx]

    cmp ax,0
    js negativo

    mov dx, ax
    jmp exit1

    negativo:
    neg ax
    mov dx,ax

    exit1:
    lea bx,R
    mov [bx],dx

    pop dx
    pop cx
    pop bx
    pop ax    ;devolve os valores dos regs 

    ret
    module endp
    ;;;;;;;;;;;;; 10 elevado a N
    _10_ev proc
    push ax     
    push bx
    push cx 
    push dx     ;backup dos regs antes do proc

    lea bx, N1    ;lê N1 da memoria
    mov bx,[bx]

    mov ah,02h
    mov dl,31h
    int 21h         ;imprime o 1

    mov dl,30h
    loo:
    int 21h
    dec bx
    jnz loo

    pop dx
    pop cx
    pop bx
    pop ax    ;devolve os valores dos regs 

    ret
    _10_ev endp
;;;;;;;;;;;;;;;;;N1 % de N2 (porcentagem)
    perc proc
    push ax     
    push bx
    push cx 
    push dx     ;backup dos regs antes do proc

    lea bx, N1    ;lê N1 da memoria
    mov ax,[bx]

    lea bx, N2    ;lê N2 da memoria
    mov cx,[bx]

    mul cx    ;N1*N2


    mov dx,0       ; preparações para divisão por 100
    mov cx,100d

    mul cx

    lea bx,R
    mov [bx],ax

    pop dx
    pop cx
    pop bx
    pop ax    ;devolve os valores dos regs 

    ret
    perc endp

    pri_calc proc
    mov ah,09
    lea dx, msg1
    int 21H

    lea dx, msg2
    int 21H

    lea dx, msg3
    int 21H

    lea dx, msg4
    int 21H

    lea dx, msg5
    int 21H
         
    lea dx, msg6
    int 21H
        
    lea dx, msg7
    int 21H

    lea dx, msg8
    int 21H

    lea dx, msg9
    int 21H

    ret
    pri_calc endp 

 inp PROC
     xor ax,ax
; lê um numero entre -32768 A 32767
; entrada nenhuma
; saída numero em AX
PUSH BX
PUSH CX
PUSH DX
@INICIO:

;  total = 0
XOR BX,BX
; negativo = falso
XOR CX,CX
; le caractere
MOV AH,1
INT 21H
; case caractere lido eh?
CMP AL,'-'
JE @NEGT
CMP AL,'+'
JE @POST
JMP @REP2

@NEGT:
MOV CX,1
@POST:
INT 21H
;end case
@REP2:
; if caractere esta entre 0 e 9
CMP AL, '0'
JNGE @NODIG
CMP AL, '9'
JNLE @NODIG
; converte caractere em digito
AND AX,000FH
PUSH AX
; total = total X 10 + digito
MOV AX,10
MUL BX   ; AX = total X 10
POP BX
ADD BX,AX ; total - total X 10 + 

; le caractere
MOV AH,1
INT 21H
CMP AL,13  ;CR ?
JNE @REP2    ; não, continua
; ate CR
MOV AX,BX   ; guarda numero em AX
; se negativo
OR CX,CX    ; negativo ?
JE @SAI      ; sim, sai
; entao
NEG AX
; end if
@SAI:
POP DX    ; restaura registradores
POP CX
POP BX

RET   ; retorna
@NODIG:
; se caractere ilegal
MOV AH,2
MOV DL, 0DH
INT 21H
MOV DL, 0AH
INT 21H
JMP @INICIO
inp ENDP




 _out PROC
SAIDEC PROC
; imprime numero decimal sinalizado em AX
;entrada AX
;sa?da nenhuma
PUSH AX
PUSH BX
PUSH CX
PUSH DX
; if AX < 0
OR AX,AX      ; AX < 0 ?
JGE @END_IF1
;then
PUSH AX     ;salva o numero
MOV DL, '-'
MOV AH,2
INT 21H         ; imprime -
POP AX          ; restaura numero
NEG AX
; digitos decimais
@END_IF1:
XOR CX,CX      ; contador de d?gitos
MOV BX,10      ; divisor
@REP1:
XOR DX,DX      ; prepara parte alta do dividendo
DIV BX         ; AX = quociente   DX = resto
PUSH DX        ; salva resto na pilha
INC CX         ; contador = contador +1
;until
OR AX,AX       ; quociente = 0?
JNE @REP1      ; nao, continua
; converte digito em caractere
MOV AH,2
; for contador vezes
@IMP_LOOP:
POP DX        ; digito em DL
OR DL,30H
INT 21H
LOOP @IMP_LOOP
; fim do for
POP DX
POP CX
POP BX
POP AX
RET
SAIDEC ENDP
_out ENDP



    end main