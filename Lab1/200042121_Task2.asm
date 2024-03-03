ORG 100h     



START:  
        
    
MAIN PROC
        BEGIN:
            MOV AH, 9
            MOV DX, OFFSET INPUT
            INT 21h
            MOV AH,1     
            INT 21h  
            SUB AL,48
            JZ EXIT
            ADD AL,48
            CMP AL,97 
            JGE LOWERCASE
            CMP AL,65
            JGE UPPERCASE
            JMP INVALID  
            
            
                     
        
        LOWERCASE: 
            CMP AL,122
            JG INVALID  
            SUB AL,32       
            CALL NEXT_MSG 
            JMP DISPLAY_NEXT_UPPER
        
        
        UPPERCASE: 
            CMP AL,90
            JG INVALID
            ADD AL,32      
            CALL NEXT_MSG 
            JMP DISPLAY_NEXT_LOWER
        
        
        DISPLAY_NEXT_UPPER:  
            PUSH AX 
            CALL INCREMENT_UPPER
            ADD CH,1
            CMP CH,5
            JL DISPLAY_NEXT_UPPER   
            CALL PREV_MSG        
            JMP DISPLAY_PREV_UPPER 
            
        DISPLAY_NEXT_LOWER:
            PUSH AX 
            CALL INCREMENT_LOWER
            ADD CH,1
            CMP CH,5
            JL DISPLAY_NEXT_LOWER 
            CALL PREV_MSG    
            JMP DISPLAY_PREV_LOWER
        
        DISPLAY_PREV_LOWER: 
            PUSH AX
            CALL DECREMENT_LOWER   
            ADD CH,1
            CMP CH,5
            JL DISPLAY_PREV_LOWER                    
            JMP BEGIN 
              
        DISPLAY_PREV_UPPER: 
            PUSH AX
            CALL DECREMENT_UPPER   
            ADD CH,1
            CMP CH,5
            JL DISPLAY_PREV_UPPER                    
            JMP BEGIN   
        
        
        INVALID: 
            MOV AH,9
            MOV DX,OFFSET ERROR
            INT 21h
            JMP BEGIN 
    
MAIN ENDP
RET
    
INCREMENT_LOWER PROC
    INIT_INCREMENT_LOWER:
        PUSH BP   
        MOV BP, SP 
        MOV AX, [BP+4]    
        JMP LOWERCASE_INC 
         
    LOWERCASE_INC:      
        ADD AL, 1  
        CMP AL, 122
        JG RESET_LOWERCASE 
        JMP EXIT_INC_LOWER 
        
    RESET_LOWERCASE:  
        MOV AL, 97
        JMP EXIT_INC_LOWER
   
        
    EXIT_INC_LOWER:   
        MOV [BP+6], AX
        MOV AH, 2
        MOV DL, AL
        INT 21h 
        POP BP   
        RET 4 
INCREMENT_LOWER ENDP


INCREMENT_UPPER PROC
    INIT_INCREMENT_UPPER:
        PUSH BP   
        MOV BP, SP 
        MOV AX, [BP+4]  
        JMP UPPERCASE_INC 
         
    
    UPPERCASE_INC: 
        ADD AL, 1
        CMP AL, 90
        JG RESET_UPPERCASE 
        JMP EXIT_INC_UPPER 
        
    RESET_UPPERCASE:
        MOV AL, 65  
        JMP EXIT_INC_UPPER
        
    EXIT_INC_UPPER:   
        MOV [BP+6], AX 
        MOV AH, 2
        MOV DL, AL
        INT 21h 
        POP BP   
        RET 4 
INCREMENT_UPPER ENDP

DECREMENT_LOWER PROC
    INIT_DECREMENT_LOWER:
        PUSH BP   
        MOV BP, SP 
        MOV AX, [BP+4]  
        JMP LOWERCASE_DEC 
        
    LOWERCASE_DEC:      
        SUB AL, 1  
        CMP AL, 97
        JL RESET_LOWERCASE_DEC 
        JMP EXIT_DEC_LOWER 
        
    RESET_LOWERCASE_DEC:  
        MOV AL, 122
        JMP EXIT_DEC_LOWER
    
    EXIT_DEC_LOWER:   
        MOV [BP+6], AX
        MOV AH, 2
        MOV DL, AL
        INT 21h 
        POP BP   
        RET 4 
DECREMENT_LOWER ENDP


DECREMENT_UPPER PROC
    INIT_DECREMENT_UPPER:
        PUSH BP   
        MOV BP, SP 
        MOV AX, [BP+4]  
        JMP UPPERCASE_DEC 
         
    
    UPPERCASE_DEC: 
        SUB AL, 1
        CMP AL, 65
        JL RESET_UPPERCASE_DEC 
        JMP EXIT_DEC_UPPER 
        
    RESET_UPPERCASE_DEC:
        MOV AL, 90  
        JMP EXIT_DEC_UPPER
        
    EXIT_DEC_UPPER:   
        MOV [BP+6], AX 
        MOV AH, 2
        MOV DL, AL
        INT 21h 
        POP BP   
        RET 4 
DECREMENT_UPPER ENDP


NEXT_MSG PROC  
    MOV CL,AL
    MOV AH,9
    MOV DX,OFFSET NEXT     
    INT 21h 
    MOV AL,CL  
    MOV CH,0
    RET 
    
NEXT_MSG ENDP


PREV_MSG PROC
    MOV CH,2
    MOV AX,CX 
    MOV CL,AL
    MOV AH,9
    MOV DX,OFFSET PREV     
    INT 21h  
    MOV AH,2              
    MOV AL,CL
    MOV CH,0 
    RET 
    
PREV_MSG ENDP


      
INPUT DB 0AH,0DH,'Enter a letter, Input 0 to exit: $'      
ERROR DB 0AH,0DH,'Error Input, Please Try Again',0AH,0DH,'$'   
NEXT DB 0AH,0DH,'Next 5 Letters: $'
PREV DB 0AH,0DH,'Previous 5 Letters: $'  
UPPER DB 0AH,"UPPER",0AH,'$'
LOWER DB 0AH,"LOWER",0AH,'$'



EXIT:
    
END START
