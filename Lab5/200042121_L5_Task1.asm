org 100h
.DATA
    num1 DB ?
    num2 DB ?
    num3 DB ?
    num4 DB ?
    num5 DB ?
    small_num DB ?
    large_num DB ?  
    input_string DB "Enter a Number Sequence of Length 5: ",0Dh,0Ah,'$'
    output_avg DB 0Ah,0Dh,"Average=",'$'
    output_large DB 0Ah,0Dh,"Large=",'$'
    output_small DB 0Ah,0Dh,"Small=",'$'
    
.CODE

MAIN PROC  
    MOV AX,@DATA
    MOV DS,AX 
    MOV AH,9
    MOV DX,OFFSET input_string
    INT 21h
    MOV AH,1
    INT 21h
    MOV num1,AL 
    SUB num1,30h 
    MOV AH,1
    INT 21h
    MOV num2,AL 
    SUB num2,30h
    MOV AH,1
    INT 21h
    MOV num3,AL 
    SUB num3,30h
    MOV AH,1
    INT 21h
    MOV num4,AL
    SUB num4,30h
    MOV AH,1
    INT 21h
    MOV num5,AL 
    SUB num5,30h
    CALL AVG   
    CALL SMALL
    CALL LARGE
    RET
    
MAIN ENDP 

AVG PROC  
    XOR DX,DX  
    XOR AX,AX
    MOV DL,0h
    ADD DL,num1 
    ADD DL,num2
    ADD DL,num3
    ADD DL,num4
    ADD DL,num5 
    MOV AL,DL
    MOV DL,5 
    DIV DL 
    MOV CL,AL    
    MOV AH,9
    MOV DX,OFFSET output_avg
    INT 21h     
    XOR DX,DX 
    MOV DL,CL
    MOV AH,2 
    ADD DL,30h
    INT 21h   
    RET
AVG ENDP


SMALL PROC
    MOV AH, 0
    MOV AL, num1
    CMP AL, num2
    JL  SMALL_check_num2
    MOV AL, num2
SMALL_check_num2:
    CMP AL, num3
    JL  SMALL_check_num3
    MOV AL, num3
SMALL_check_num3:
    CMP AL, num4
    JL  SMALL_check_num4
    MOV AL, num4
SMALL_check_num4:
    CMP AL, num5
    JL  SMALL_end
    MOV AL, num5
SMALL_end:
    MOV small_num, AL
    MOV AH, 9
    MOV DX, OFFSET output_small
    INT 21h
    MOV AH, 2
    MOV DL, small_num
    ADD DL, 30h
    INT 21h
    
    RET
SMALL ENDP

LARGE PROC
    MOV AH, 0
    MOV AL, num1
    CMP AL, num2
    JG  LARGE_check_num2
    MOV AL, num2
LARGE_check_num2:
    CMP AL, num3
    JG  LARGE_check_num3
    MOV AL, num3
LARGE_check_num3:
    CMP AL, num4
    JG  LARGE_check_num4
    MOV AL, num4
LARGE_check_num4:
    CMP AL, num5
    JG  LARGE_end
    MOV AL, num5
LARGE_end:
    MOV large_num, AL
    
    MOV AH, 9
    MOV DX, OFFSET output_large
    INT 21h
    MOV AH, 2
    MOV DL, large_num
    ADD DL, 30h 
    INT 21h
    
    RET
LARGE ENDP
