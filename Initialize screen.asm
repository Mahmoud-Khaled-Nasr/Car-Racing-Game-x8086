;MAHMOUD KHALED
;29/11/2016
;INITIALIZE THE GAME SCREEN
;=================================================	
	
	;**********************************************
	;|
	;|
	;|
	;|>		PLAYER1
	;|
	;|
	;|
	;***********************************************
	;***********************************************
	;|
	;|
	;|
	;|>		PLAYER2
	;|
	;|
	;|
	;***********************************************	
	;===============================================
	;MYCHAT
	;\
	;\
	;HISCHAT
	;\
	;\

INCLUDE Util.asm
	
EXTRN HEADER_CHAT1:BYTE
EXTRN HEADER_CHAT2:BYTE
EXTRN SCORE1STRING:BYTE
EXTRN SCORE2STRING:BYTE
PUBLIC INITIALIZE_WINDOW



DRAW_CHAR_ALONG_A_ROW MACRO ROW,CHAR,ATTRIBUTE
;SET THE CURSOR
		SET_CURSOR ROW,0	
;PRINT THE CHAR WITH ATTRIBUTE
		MOV AH,09
		MOV BH,0
		MOV AL,CHAR
		MOV BL,ATTRIBUTE
		MOV CX,80
		INT 10H
ENDM

.MODEL SMALL
.STACK 64
.DATA
.CODE
INITIALIZE_WINDOW PROC FAR
	CALL INTIALIZE_WINDOWX
	RET
INITIALIZE_WINDOW ENDP

INTIALIZE_WINDOWX PROC NEAR 
;SET VIDEO MODE TO 85X25
		MOV AH,0H
		MOV AL,03H
		INT 10H

;DRAW THE * AND =
		DRAW_CHAR_ALONG_A_ROW 0,'*',11000001B
		DRAW_CHAR_ALONG_A_ROW 8,'*',11000001B
		DRAW_CHAR_ALONG_A_ROW 9,'*',11000001B
		DRAW_CHAR_ALONG_A_ROW 17,'*',11000001B
		DRAW_CHAR_ALONG_A_ROW 18,'=',11000001B
		;WRITE THE HEADERS OF CHAT
		SET_CURSOR 19,0 ;ROW,COL
		WRITE_STRING HEADER_CHAT1   ;STRING AT THE CURSOR POSITION
		SET_CURSOR 22,0 
		WRITE_STRING HEADER_CHAT2
		;SET_CURSOR 0,0
		;WRITE_STRING SCORE1STRING
		;SET_CURSOR 9,0
		;WRITE_STRING SCORE2STRING
		RET
INTIALIZE_WINDOWX ENDP

END		
