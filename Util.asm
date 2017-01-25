;MAHMOUD KHALED NASR
;4/12/2016
;THIS IS A UTILITY FILE WITH COMMEN FUNCTIONALITIES
;===================================================


SET_CURSOR MACRO ROW,COL 
	
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
    		MOV AH,02H
		MOV DL,COL
		MOV DH,ROW
		MOV BH,0
		INT 10H
	POP DX
	POP CX
	POP BX
	POP AX
ENDM  

WRITE_STRING MACRO STRING
        	MOV AH,09H
		MOV DX,OFFSET STRING
		INT 21H 
ENDM	

printWordUnsignedInteger MACRO integer
    LOCAL printLoop, readyOp
    MOV BX, integer
    MOV CX, 4H
    printLoop:  MOV AX, 1
                MOV CH, CL
                readyOp:    MOV DX, 0aH
                            MUL DX
                            DEC CL
                            JNZ readyOp
                MOV CL, CH
                MOV CH, 0H
                XCHG AX, BX
                DIV BX
                MOV BX, DX
                MOV DX, AX
                ADD DL, '0'
                MOV AH, 2H
                INT 21H
                LOOP printLoop
    MOV DL, BL
    ADD DL, '0'
    MOV AH, 2H
    INT 21H
ENDM printWordUnsignedInteger

printByteUnsignedInteger MACRO integer
    LOCAL printLoop, readyOp
    MOV DX, 0H
    MOV BL, integer
    MOV CX, 2H
    printLoop:  MOV AX, 1
                MOV CH, CL
                readyOp:    MOV DL, 0aH
                            MUL DL
                            DEC CL
                            JNZ readyOp
                MOV CL, CH
                MOV CH, 0H
                XCHG AL, BL
                DIV BL
                MOV BL, AH
                MOV DL, AL
                ADD DL, '0'
                MOV AH, 2H
                INT 21H
                LOOP printLoop
    MOV DL, BL
    ADD DL, '0'
    MOV AH, 2H
    INT 21H
ENDM printByteUnsignedInteger

TEST_BEEP MACRO
		MOV AH,02H
		MOV DL,07H
		INT 21H
ENDM

TEST_DELAY MACRO TIME
		MOV AH,86H
		MOV DX,TIME
		MOV CX,1
		INT 15H
ENDM

CLEAR_WINDOW MACRO 
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
		MOV AH,0
		MOV AL,03
		INT 10H
	POP DX
	POP CX
	POP BX
	POP AX
ENDM

WAIT_FOR_STRING MACRO BUFFER
	MOV AH,0AH
	MOV DX, OFFSET BUFFER
	INT 21H	
ENDM

CLEAR_OBJECT_LOCATION MACRO
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
		MOV AH,09
		MOV BH,0
		MOV CX,1
		MOV AL,' '
		MOV BL,00000000B ;GREEN FOR TESTING
		INT 10H
	POP DX
	POP CX
	POP BX
	POP AX
ENDM
