.MODEL SMALL
.DATA
str1 db 'OSC 2S21$'  
str2 db 8 dup(?),'$'

.STACK 100H
.CODE

main proc

    mov ax, @data  
    mov ds,ax
    mov es,ax

    xor cx,cx
    mov cx,08h

    lea si,str1
    lea di,str2

    cld

    REP movsb

    mov ah,09h
    lea dx,str2
    int 21h
    
    mov ah,4ch
    int 21h

    
main endp
END main