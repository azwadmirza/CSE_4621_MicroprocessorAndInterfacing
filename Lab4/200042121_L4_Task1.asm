org 100h

.DATA 
    A DW 2,3,4,5,6,7,8,9
    Message DB 'Enter the value of N: $'
    Result DW ?
.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    XOR AX, AX
    MOV SI, OFFSET A
    MOV DX, OFFSET Message

    MOV AH, 09h 
    INT 21h 
    MOV AH, 01h
    INT 21h
    MOV AH,0  
    SUB AX,30H
    MOV CX, AX
    MOV Result,01H         

Loop_Square:
    MOV AX, [SI]  
    MOV BX,[SI] 
    MUL BX
    ADD Result,AX    
    INC SI  
    CMP BX,CX
    JNE Loop_Square 
    MOV DX,Result                        

    MAIN ENDP
END MAIN
