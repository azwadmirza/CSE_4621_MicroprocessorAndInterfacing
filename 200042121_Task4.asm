ORG 0100h

.DATA

C DW 260
F DW ?

.CODE

MAIN PROC
    MOV AX,C
    MOV DL,5
    DIV DL
    MOV DX,10
    MUL DX
    ADD AX,32
    SUB AX,1
    MOV F,AX
    MAIN ENDP
END MAIN
RET