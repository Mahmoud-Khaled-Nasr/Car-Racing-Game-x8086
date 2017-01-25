;TEAM 6
;29/11/2016
; GAME MAIN LOOP
;======================================	
 
INCLUDE Util.asm
EXTRN ADD_NEW_OBJECTS:FAR
EXTRN INITIALIZE_WINDOW:FAR
EXTRN DRAW:FAR
EXTRN CONTROLS:FAR
EXTRN MOVE:FAR
EXTRN COLLISION:FAR
PUBLIC MAIN
PUBLIC PLAYER1CENTER
PUBLIC PLAYER2CENTER
PUBLIC PLAYER1OBJECTS
PUBLIC PLAYER2OBJECTS
PUBLIC BLOCKP1
PUBLIC COINP1
PUBLIC BLOCKP2
PUBLIC COINP2
PUBLIC BLOCK_SPEED
PUBLIC COIN_SPEED
PUBLIC HEADER_CHAT1
PUBLIC HEADER_CHAT2
PUBLIC SCORE1STRING
PUBLIC SCORE2STRING
PUBLIC SCORE1
PUBLIC SCORE2 
PUBLIC CURRENT_ACTION	
PUBLIC GAME_STATUS
PUBLIC P1OFFSET
PUBLIC P2OFFSET
PUBLIC RETURN_VAR
		.MODEL LARGE
		.STACK 64
		.DATA
		;PLAYER1 IS THE CURRENT PC PLAYER IN THE GAME
		;PLAYER2 IS THE SECOND PLAYER
		
		PLAYER1NAME DB 12,?,13 DUP('$')
		PLAYER2NAME DB 13 DUP('$')

		;CRAFTS POSITIONS
		;HIGHER BYTE THE Y
		;LOWER BYTE THE X
		PLAYER1CENTER DW ?  ;SET TO DEFAULT POSITION (START INITIALLY)
		PLAYER2CENTER DW ?  ;SET TO DEFAULT POSITION (START INITIALLY)
		
		;BLOCKS POSITIONS 
		;WHERE HIGH PART IS X AND LOW IS Y
		;OBJECT POSITION 
		;HIGH BYTE = COL LOCATION
        	;LOW BYTE 
        		;D7,D6,D5=LOCATION IN ROWS //NOTE THE ROW INFORMATION IS SAVED DISCRETLY WITHOUT ITS REAL LOCATION IN THE SCREEN
        		;D4,D3,D2=SPEED :HOW MANY STEPS AT THE TIME
        		;D1 = TYPE :TYPE =1 BLOCK, =0 COIN
        		;D0 = STILL IN GAME : TURE =1 FLASE =0

		PLAYER1OBJECTS DW 10 DUP(0H),0FFFFH
		PLAYER2OBJECTS DW 10 DUP(0H),0FFFFH
		;players row offsets
		P1OFFSET DB ?
		P2OFFSET DB ?
		
		;WINDOW INITIALIZATION STRINGS
		HEADER_CHAT1 DB 'MYCHAT$'
		HEADER_CHAT2 DB 'HISCHAT$'
		SCORE1STRING DB '0000$'
		SCORE2STRING DB '0000$'
		SCORE1 DB ?
		SCORE2 DB ?
		
		;NEW OBJECTS VARIABLES
		BLOCKP1 DW ?
      		COINP1 DW ?
        	BLOCKP2 DW ?
        	COINP2 DW ?
        	BLOCK_SPEED DB ?
        	COIN_SPEED DB ?
		
		;ACTION BASED ON USEERS INPUT
		CURRENT_ACTION DB ?
		;WIN OR LOSE CONDITION
			;3H TIE :: 2H P1 LOSE :: 1H P2 LOSE :: 0 CONTINUE THE GAME
		GAME_STATUS DB ? 
		;PROGRAM STATUS ON IF IT IS PAUSED
		PROGRAM_STATUS DB ?
		
		PLAYER1WINS DB 'PLAYER 1 WINS','$'
		PLAYER2WINS DB 'PLAYER 2 WINS','$'
		TIE DB 'THE GAME IS TIE','$'
		RETURN_VAR DB 0
		
		.CODE		
MAIN PROC FAR
		MOV AX,@DATA
		MOV DS,AX
		
		CALL SET_DEFAULTS
		CALL TEST_DEFAULTS
		CALL INITIALIZE_WINDOW  ;NEARLY T99 STRUCTIONS
GAME_LOOP:
				
		CALL ADD_NEW_OBJECTS ;NEARLY T50
	
		CALL CONTROLS
	
		CALL DRAW ;T40
		
		TEST_DELAY 0FFFFH
		;TEST_DELAY 0FFFFH
		;TEST_DELAY 0FFFFH
		;TEST_DELAY 0FFFFH

		CALL COLLISION
		
		CALL MOVE
		CALL WIN_LOSE
		MOV AL,GAME_STATUS
		CMP AL,0
		JNE END_GAME
		
		CMP RETURN_VAR,1
		JE END_GAME
MOV AX,0
MOV BLOCKP2,AX
MOV COINP2,AX
	
		JMP GAME_LOOP
END_GAME:
		TEST_DELAY 0FFFFH
		TEST_DELAY 0FFFFH
		TEST_DELAY 0FFFFH
		TEST_DELAY 0FFFFH
		TEST_DELAY 0FFFFH
		TEST_DELAY 0FFFFH
		TEST_DELAY 0FFFFH
		TEST_DELAY 0FFFFH
	RET
MAIN ENDP

WIN_LOSE PROC NEAR
	MOV AL,GAME_STATUS
	CMP AX,0
	JE CONTINUE_GAME

	CLEAR_WINDOW
	SET_CURSOR 24,0

	CMP AX,1
	JNE CHECK_P1
	WRITE_STRING PLAYER1WINS
	JMP CONTINUE_GAME
CHECK_P1:
	CMP AX,2
	JNE CHECK_TIE
	WRITE_STRING PLAYER2WINS
	JMP CONTINUE_GAME
CHECK_TIE:
	CMP AX,3
	JNE CONTINUE_GAME
	WRITE_STRING TIE
CONTINUE_GAME:
	RET
WIN_LOSE ENDP

SET_DEFAULTS PROC NEAR 
		MOV AL,' '
		MOV CURRENT_ACTION,AL
		MOV AX,0405H
		MOV PLAYER1CENTER,AX 
		MOV AX,0D05H
		MOV PLAYER2CENTER,AX
		MOV AL,1
		SHL AL,1
		MOV BLOCK_SPEED,AL
		MOV AL,1
		SHL AL,1
		MOV COIN_SPEED,AL
		MOV AX,0
		MOV SCORE1,AL
		MOV SCORE2,AL
		MOV AL,1
		MOV P1OFFSET,AL
		MOV AL,10   
		MOV P2OFFSET,AL
		MOV AL,0	
		MOV GAME_STATUS,AL
		RET
SET_DEFAULTS ENDP     

TEST_DEFAULTS PROC NEAR 
		MOV AX,4F77H	;4F 0110 0111
		MOV BLOCKP2,AX
		MOV AX,4F6DH  ;4F 0110 1101
		MOV COINP2,AX
		RET
TEST_DEFAULTS ENDP

TEST_WAIT_FOR_BUTTOM PROC NEAR
		MOV AH,08H
MYLOOP:
		INT 21H
		CMP AL,0
		JE MYLOOP
		RET
TEST_WAIT_FOR_BUTTOM ENDP

END
