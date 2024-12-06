.MODEL SMALL

.DATA
    pula db ' ',13,10,'$'
    msg db 'Digite um numero:',13,10,'$'
    msg2 db 'Digite outro numero:' ,13,10,'$'
    n1 db ?
    n2 db ?
    nA db ?
    nS db ?


.STACK 100H

.CODE
main proc

    mov ax, @data   ;deixa o sistema usar as variaveis
    mov ds, ax

    mov ah, 09      ;printa msg na tela 
    lea dx, msg
    int 21h

    mov ah, 01      ;le o primeiro caracter == 3
    int 21h
    sub al, 30h     ; ; ; FLAG DE PARIDADE=1 /// 3 + 30H = 11 0011 (NUMERO PAR DE 1'S)  
    
    lea bx, n1      ;armazena no n1
    mov [bx],al

    mov ah, 09      ;pula linha
    lea dx, pula    
    int 21h

    mov ah, 09      ;printa msg2
    lea dx, msg2        
    int 21h

    mov ah, 01      ;le o segundo caracter == 5
    int 21h
    sub al, 30h     ; ; ; FLAG DE PARIDADE=1 /// 5 + 30H = 11 0101 (NUMERO PAR DE 1'S)

    lea bx, n2      ; armazena em n2
    mov [bx],al

    lea bx ,n1      ;le n1 da mem e coloca em cl
    mov cl ,[bx]

    lea bx ,n2      ;le n2 da mem e coloca em ch
    mov ch ,[bx]

    add cl ,ch      ;adição ; ; FLAG DE PARIDADE=0 /// 3 + 5 = 1000 (NUMERO IMPAR DE 1'S)

    lea bx ,nA          ;armazena resultado em nA
    mov [bx], cl

    lea bx ,n1      ;le n1 da mem e coloca em cl
    mov cl ,[bx]

    lea bx ,n2      ;le n2 da mem e coloca em ch
    mov ch ,[bx]

    sub cl ,ch      ;subtração 3 - 5 /// CF=1 (VAI UM) /// SF = 1 (NUMERO NEGATIVO (-2)) /// AF = 1 (VAI UM BCD)

    lea bx ,nS          ;armazena resultado em nS
    mov [bx], cl
   
    mov ah, 4ch     ;finaliza o programa
    int 21h

main endp

end main