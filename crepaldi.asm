.MODEL SMALL

.DATA
    pula db ' ',13,10,'$'
    msg db 'Bota um numero ae pae:',13,10,'$'
    msg2 db 'Se tu for brabo memo bota mais um ai:' ,13,10,'$'
    res db 'ta ae tua respostinha: $'
    n1 db ?
    n2 db ?
    nF db ?

.STACK 100H

.CODE
main proc

    mov ax, @data   ;deixa o sistema usar as variaveis
    mov ds, ax

    mov ah, 09      ;printa msg na tela 
    lea dx, msg
    int 21h

    mov ah, 01      ;le o primeiro caracter
    int 21h
    sub al, 30h

    lea bx, n1      ;armazena no n1
    mov [bx],al

    mov ah, 09      ;pula linha
    lea dx, pula    
    int 21h

    mov ah, 09      ;printa msg2
    lea dx, msg2        
    int 21h

    mov ah, 01      ;le o segundo caracter
    int 21h
    sub al, 30h

    lea bx, n2      ; armazena em n2
    mov [bx],al

    lea bx ,n1      ;le n1 da mem e coloca em cl
    mov cl ,[bx]

    lea bx ,n2      ;le n2 da mem e coloca em ch
    mov ch ,[bx]

    sub cl ,ch      ;onde a magia da sub acontece

    add cl , 30H       ;transforma o resultado em caracter

    lea bx ,nF          ;armazena resultado em nf
    mov [bx], cl

    mov ah, 09      ;pula linha
    lea dx, pula
    int 21h

    mov ah, 09      ;printa mensagem pré resultado
    lea dx, res
    int 21h

    mov ah, 09      ;resultado da sub printado
    lea dx, nF
    int 21h


    mov ah, 4ch     ;finaliza o rpograma
    int 21h

main endp

end main