.MODEL SMALL

.DATA  
    lista dw 16 dup(0)
    msg db 'Insira um numero: $'

.STACK 100H
.386

.CODE 
    main proc
    mov ax,@data   ;libera acesso as variaveis
    mov ds,ax

    mov ah, 09h
    lea bx, msg
    int 21H

    call get_

    call set_

    mov ah,4ch
    int 21h
    main endp

    
    get_ proc
    mov cx,15  ; prepara o loop com 16 ciclos
    lea bx,lista 

    mov ah,01h
    int 21H

    mov dh,2
    ler:
    mov ah,01h
    int 21H

    add bx,dh ; passa para o proximo end de lista
    mov [bx],al

    loop ler

    ret 
    get_ ednp

    set_ proc
    xor bx,bx
    xor si,si

    ; lista[bx][si]  bx anda em 8 / si em 2
aqui:
    mov cx,16
    and lista [bx][si],01h
    jz par

    ; caso n seja
    inc lista [bx][si]
    par:
    add si
    cmp si,10
    jz atu
    loop aqui
    atu:
    
    ret 
    set_ ednp
    

    
    end main