org 100h

.data
    input_msg db "We are IUT Students",0Dh,0Ah, "$" 

.code
main:
    mov ax, @data                   
    mov ds, ax                      

    mov si, offset input_msg         
    mov cx, 0                       

count_loop:
    mov al, [si]                    
    cmp al, '$'                     
    je end_count_loop               
    inc cx                          
    inc si                          
    jmp count_loop                  

end_count_loop:                    
    mov ah, 9                       
    mov dx, offset input_msg          
    int 21h     
    mov ah,2
    mov dx,cx
    int 21h
    xor cx,cx
    xor ax,ax                                             
end main
