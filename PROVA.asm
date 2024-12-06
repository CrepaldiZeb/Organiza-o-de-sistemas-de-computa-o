.MODEL SMALL

.DATA
    pula db ,13,10,'$'
    msg db 'O Maior: ',13,10,'$'
    N1 db 4D
    N2 db 2D
    N3 db 3D
    N4 db 6D
    N5 db 0D
    
    Maior db 0
    
.STACK 100H

.CODE
main proc

    mov ax, @data   ;deixa o sistema usar as variaveis
    mov ds, ax

    mov ah, 09      ;pula linha
    lea dx, pula    
    int 21h

    lea bx ,N1      ;le n1 da mem e coloca em cl
    mov cl ,[bx]
    
    lea bx ,MAIOR      ;le maior da mem e coloca em ch
    mov ch ,[bx]
    
    cmp cl , ch
    
    jns UPD_1
    
    PT1:
    
    lea bx ,N2      ;le n2 da mem e coloca em cl
    mov cl ,[bx]
    
    cmp cl , ch
    
    jns UPD_2
    PT2:
    
    lea bx ,N3      ;le n3 da mem e coloca em cl
    mov cl ,[bx]
    
    cmp cl , ch
    
    jns UPD_3
    PT3:
    
    lea bx ,N4      ;le n4 da mem e coloca em cl
    mov cl ,[bx]
    
    cmp cl , ch
    
    jns UPD_4
    PT4:
    
    lea bx ,N5      ;le n5 da mem e coloca em cl
    mov cl ,[bx]
    
    cmp cl , ch
    
    jns UPD_5
    PT5:
    
    jmp EXIT
    
    UPD_1:
    mov ch,cl
    jmp PT1 
    
    UPD_2:
    mov ch,cl
    jmp PT2
    
    UPD_3:
    mov ch,cl
    jmp PT3
    
    UPD_4:
    mov ch,cl
    jmp PT4
    
    UPD_5:
    mov ch,cl
    jmp PT5
    
    EXIT:
    
    mov ah, 09      ;pula linha
    lea dx, pula    
    int 21h
    
    mov ah, 09      ;mensagem
    lea dx, msg    
    int 21h
    
    add ch,30h
    
    mov ah, 02  ;numero maior    
    mov dl, ch    
    int 21h
   
    CHAP:
    mov ah, 4ch     ;finaliza o rpograma
    int 21h
    
main endp

end main