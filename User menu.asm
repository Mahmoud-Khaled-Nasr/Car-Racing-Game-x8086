.MODEL SMALL
.STACK 64
.DATA      

MES DB 'PLEASE ENTER YOUR USERNAME$'
  
USERNAME DB 30,?,30 DUP('$')


.CODE
MAIN    PROC FAR        
        MOV AX,@DATA    
        MOV DS,AX
        
        MOV AH,2
        MOV DX,091BH
        INT 10H     
        
        MOV AH, 9
        MOV DX, OFFSET MES ;Display string in the new location
        INT 21H 
        
        MOV AH,2
        MOV DX,0B1BH
        INT 10H  
              
        MOV AH,0           ; GET KEY PRESSED
        INT 16H
        CMP AL,13	;CHECK FOR ENTER
        JE CLOSE      
              
        mov ah,0AH        ;Read from keyboard
        mov dx,offset USERNAME                  
        int 21h    
        
       
CLOSE:  MOV AH,4CH
        INT 21H      
       
       
       
       
MAIN    ENDP 

END MAIN                
