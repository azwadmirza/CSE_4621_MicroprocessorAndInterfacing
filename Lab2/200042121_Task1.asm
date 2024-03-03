ORG 100h



START:
    MOV AH, 9
    MOV DX,OFFSET INPUT
    INT 21h
    
    MOV AH, 1
    INT 21h
    
    MOV BL, AL
    MOV CL, AL
    SUB CL,48
    JZ EXIT  
    MOV CL,AL
    MOV CH,AH
    MOV AH,9
    MOV DX,OFFSET OUTPUT
    INT 21h
    MOV AL,CL
    MOV AH,CH
    
    CMP AL, 65
    JL LOWERCASE
    
    CMP AL, 90
    JG LOWERCASE
    
    ADD AL, 32  
    JMP DISPLAY
    
LOWERCASE:
    CMP AL, 97
    JL INVALID
    
    CMP AL, 122
    JG INVALID
    
    SUB AL, 32
    
DISPLAY:
    MOV AH, 2  
    MOV DL, AL
    INT 21h
    MOV DL, 0DH
    INT 21h
    MOV DL, 0AH
    INT 21h
    JMP START

INVALID:
    MOV AH, 9
    MOV DX, OFFSET ERROR
    INT 21h
    JMP START   
    
EXIT:  

INPUT DB 'Input: $'
OUTPUT DB 0AH,0DH,'Output: $'   
ERROR DB 'Error Occured, Try Again',0AH,0DH,'$'
    
END START
