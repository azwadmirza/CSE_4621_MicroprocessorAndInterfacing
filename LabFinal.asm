org 100h 

.DATA
    a DW ?,?,?,?
    b DW ?,?,?,?  
    


.CODE
    mov AX,@Data
    mov DS,AX
    xor AX,AX
    mov CX,4     
    mov SI,OFFSET a
    input1:    
        MOV AH,01
        INT 21h
        SUB AL,30H 
        MOV [SI],AL
        INC SI
        loop input1  
    mov CX,4     
    mov SI,OFFSET b
    input2:    
        MOV AH,01
        INT 21h
        SUB AL,30H 
        MOV [SI],AL
        INC SI
        loop input2
    
    mov CX,4
    XOR AX,AX
    XOR BX,BX  
    mov SI, OFFSET a  
    first:     
        MOV AX,[SI]
        AND AX,1
        JZ skipped
        ADD BX,[SI]
        skipped:
            INC SI
        loop first
    XOR AX,AX
    XOR DX,DX
    MOV CX,4 
    mov SI, OFFSET b
    second:  
        MOV AX,[SI]  
        AND AX,1
        JZ skipped2
        ADD DX,[SI]
        skipped2:
            INC SI
        loop second 
    CMP DX,BX
    JL lesser 
    MOV AH,02H
    MOV SI,OFFSET b
    MOV DL,[SI]    
    ADD DL,30H
    INT 21h
    INC SI 
    MOV DL,[SI]  
    ADD DL,30H
    INT 21h
    INC SI
    MOV DL,[SI]
    ADD DL,30H
    INT 21h
    INC SI
    MOV DL,[SI]
    ADD DL,30H
    INT 21h     
    JMP end
    
    
    
    
    lesser:
        MOV AH,2
        MOV SI,OFFSET a
        MOV DL,[SI]    
        ADD DL,30H
        INT 21h
        INC SI 
        MOV DL,[SI]  
        ADD DL,30H
        INT 21h
        INC SI
        MOV DL,[SI]
         ADD DL,30H
        INT 21h
        INC SI
        MOV DL,[SI]
        ADD DL,30H
        INT 21h
    end:
        
         
    
    
    
    
    
    