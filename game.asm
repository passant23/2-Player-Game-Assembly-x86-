;---------------------Main Menu Macros---------------------
printmess macro msg 
mov di,offset msg
displaymess di 
endm printmess 
displaymess macro msg
mov dx,msg
mov ah,9
int 21h
endm displaymess
movecursor macro x
    mov ah,2
    add dl,x
    int 10h
endm movecursor
getcursor macro
    mov ah,3
    int 10h
endm getcursor
clearscr MACRO
 	 mov ah,0
     mov al,13h
     int 10h  
ENDM clearscr
;-------------------------------------------------------------
;----------------------------Game Macros-------------------------------------
 checkpressedkey macro
mov ax,0000       ;check key pressed
int 16h 
endm checkpressedkey
checkkey macro
 mov ax,0000 ;check key pressed to decide which player jumps/shoots 
int 16h 
endm 
checkeydontwait macro

  mov ah,1h
      int 16h  
	
endm 
delay macro 
   PUSH CX    ;delay 1 sec
PUSH DX 
PUSH AX
MOV     CX, 02H
MOV     DX, 4240H
MOV     AH, 86H
INT     15H  
POP AX
POP DX
POP CX 
endm 
.model small
.stack 64
.data
;Some constants for graphics (height and width)
Xplayer EQU 29
Yplayer EQU 48

Xbullet EQU 8
Ybullet EQU 7

Xbomb EQU 24
Ybomb EQU 29

Xlife EQU 14
Ylife EQU 8

XLostLife EQU 14
YlostLife EQU 8

;live states
life1stateP1 dw 1
life2stateP1 dw 1
life3stateP1 dw 1
life1stateP2 dw 1
life2stateP2 dw 1
life3stateP2 dw 1
;-------------------------------------------------
;bomb state
bombstate dw 0
;---------------------------------------------
;Players coordinates
Xp1 dw 10
Xp12 dw 10  ;have to be changed together with xp1
Yp1 dw 87

Xp2 dw 281
Xp22 dw 281   ;have to be changed together with xp2
Yp2 dw 87
;------------------------------------------------
;bullet coordinates
Xb1 dw 39     
Xb12 dw 39   ;have to be changed together with xb1
Yb1 dw 110

Xb2 dw 275
Xb22 dw 275 ;have to be changed together with xb2
Yb2 dw 110
;-------------------------------------------------
;bomb coordinates
Xbomb1 dw 148
Xbomb11 dw 148
Ybomb1 dw 106

bombtookoff db 0  ;1st take off
;-----------------------------------------------
;game state
gameon db 1
winner1 db 0
winner2 db 0
;------------------------------------------
;life coordinates
Xlife1 dw 0
Xlife11 dw 0
Ylife1 dw 140

XlostLife1 dw 0
XlostLife11 dw 0
YlostLife1 dw 140
YlostLife11 dw 140
;-------------------------------------------
; Bullets States 
Bullet1State  DB 0fh
Bullet2State  DB 0fh
;---------------------------------------
jumpup1state db 0ffh   ;initially 0 then incremented at each jumpup player 1
jumpdown1state db 0ffh ;initially 0 then incremented at each jumpdown player 1
jumpup2state db 0ffh   ;initially 0 then incremented at each jumpup  player 2
jumpdown2state db 0ffh  ;initially 0 then incremented at each jumpdown player2 
;----------------------------------------------------------------------
player db 9,0fh,9,9,9,9,9,6,6,6,6,6,9,9,9,9,9,6,6,6,6,6,9,9,9,9,9,9,9
       db 0fh,0fh,0fh,4,4,9,6,6,6,6,6,6,6,9,9,9,6,6,6,6,6,6,6,9,9,9,9,9,9
       db 9,0fh,9,9,9,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,9,9
       db 9,9,9,9,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,9,9
       db 9,9,9,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,9,9
       db 9,9,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,9,9
       db 9,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,9
       db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
       db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	   db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4

db 9,9,9,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,9,9,9
db 9,9,9,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,9,9,9
db 9,9,9,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,9,9,9
db 9,9,9,0Dh,0Dh,0Dh,0Dh,0,0,0,0,0,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0,0,0,0,0,9,9,9
db 9,9,9,0Dh,0Dh,0Dh,0Dh,0,0,0,0,0,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0,0,0,0,0,9,9,9
db 9,9,9,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0,0,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0,0,0Dh,0Dh,9,9,9
db 9,9,9,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,9,9,9
db 9,9,9,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,9,9,9
db 9,9,9,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,9,9,9
db 9,9,9,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,9,9,9
db 9,9,9,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,9,9,9
db 9,9,9,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,9,9,9
db 9,9,9,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,9,9,9

db 9,9,9,7,7,7,7,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 9,9,9,7,7,7,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 9,9,9,7,7,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 9,9,9,7,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 9,9,9,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 9,9,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 9,9,9,7,7,7,7,7,0,0,7,7,7,7,0,0,7,7,7,7,7,7,7,7,7,7,9,9,9
db 9,9,9,7,7,7,7,0,0,0,7,7,7,0,0,7,7,7,7,7,7,7,7,7,7,7,9,9,9
db 9,9,9,7,7,7,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,7,7,7,9,9,9
db 9,9,9,7,7,7,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,7,7,7,9,9,9
db 9,9,9,7,7,0,0,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,9,9,9,9
db 9,9,9,7,0,0,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,9,9,9

db 9,9,9,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,9,9,9
db 9,9,9,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,9,9,9
db 9,9,9,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,9,9,9
db 9,9,9,1,1,1,1,1,1,1,1,1,9,9,9,9,9,1,1,1,1,1,1,1,1,1,9,9,9
db 9,9,9,1,1,1,1,1,1,1,1,1,9,9,9,9,9,1,1,1,1,1,1,1,1,1,9,9,9
db 9,9,9,1,1,1,1,1,1,1,1,1,9,9,9,9,9,1,1,1,1,1,1,1,1,1,9,9,9
db 9,9,9,1,1,1,1,1,1,1,1,1,9,9,9,9,9,1,1,1,1,1,1,1,1,1,9,9,9
db 9,9,9,1,1,1,1,1,1,1,1,1,9,9,9,9,9,1,1,1,1,1,1,1,1,1,9,9,9
db 9,9,9,1,1,1,1,1,1,1,1,1,9,9,9,9,9,1,1,1,1,1,1,1,1,1,9,9,9
db 9,9,9,1,1,1,1,1,1,1,1,1,9,9,9,9,9,1,1,1,1,1,1,1,1,1,9,9,9
db 9,9,9,4,4,4,4,4,4,4,4,4,9,9,9,9,9,4,4,4,4,4,4,4,4,4,9,9,9
db 9,9,9,4,4,4,4,4,4,4,4,4,9,9,9,9,9,4,4,4,4,4,4,4,4,4,9,9,9

;---------------------------------------------------
bullet1 db 0Ch,4,0Ch,0Ch,4,9,9,9              
        db 0Ch,4,0Ch,0Ch,4,0Ch,9,9
        db 0Ch,4,0Ch,0Ch,4,0Ch,0Ch,9       
        db 0Ch,4,0Ch,0Ch,4,0Ch,0Ch,0Ch         
        db 0Ch,4,0Ch,0Ch,4,0Ch,0Ch,9        
        db 0Ch,4,0Ch,0Ch,4,0Ch,9,9  
        db 0Ch,4,0Ch,0Ch,4,9,9,9 
;-----------------------------------------------------------
bullet2 db 9,9,9,4,0Ch,0Ch,4,0Ch               
        db 9,9,0Ch,4,0Ch,0Ch,4,0Ch               
        db 9,0Ch,0Ch,4,0Ch,0Ch,4,0Ch               
        db 0Ch,0Ch,0Ch,4,0Ch,0Ch,4,0Ch        
        db 9,0Ch,0Ch,4,0Ch,0Ch,4,0Ch                 
        db 9,9,0Ch,4,0Ch,0Ch,4,0Ch                
	    db 9,9,9,4,0Ch,0Ch,4,0Ch
        
  ;--------------------------------------------------------
  life db 9,9,4,4,4,4,9,9,4,4,4,4,9,9
       db 9,9,4,4,4,4,9,9,4,4,4,4,9,9
       db 4,4,4,4,4,4,4,4,4,4,4,4,4,4
       db 4,4,4,4,4,4,4,4,4,4,4,4,4,4
       db 4,4,4,4,4,4,4,4,4,4,4,4,4,4
       db 9,9,4,4,4,4,4,4,4,4,4,4,9,9
       db 9,9,9,9,4,4,4,4,4,4,9,9,9,9
       db 9,9,9,9,9,9,4,4,9,9,9,9,9,9
	;------------------------------------------------------
	
lostlife  db 9,9,8,8,8,8,9,9,8,8,8,8,9,9
          db 9,9,8,8,8,8,9,9,8,8,8,8,9,9
          db 8,8,8,8,8,8,8,8,8,8,8,8,8,8
          db 8,8,8,8,8,8,8,8,8,8,8,8,8,8
          db 8,8,8,8,8,8,8,8,8,8,8,8,8,8
          db 9,9,8,8,8,8,8,8,8,8,8,8,9,9
          db 9,9,9,9,8,8,8,8,8,8,9,9,9,9
          db 9,9,9,9,9,9,8,8,9,9,9,9,9,9
	;------------------------------------------------------
	bomb db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,0,9,9,9,9,9,9
	     db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,0,9,9,9,9,9,9,9
	     db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,0,9,9,9,9,9,9,9,9
	     db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,0,9,9,9,9,9,9,9,9,9
	     db 9,9,9,9,9,9,9,9,9,9,9,9,9,0,9,9,9,9,9,9,9,9,9,9
	     db 9,9,9,9,9,9,9,9,9,0,0,0,0,0,0,9,9,9,9,9,9,9,9,9
         db 9,9,9,9,9,9,9,0,0,0,0,0,0,0,0,0,0,9,9,9,9,9,9,9
         db 9,9,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9,9,9
         db 9,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9,9
		 db 9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9
         db 9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9
         db 9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9
         db 9,0,0,0,0Fh,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9
         db 9,0,0,0,0Fh,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9
         db 0,0,0,0,0Fh,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
         db 0,0,0Fh,0Fh,0Fh,0Fh,0Fh,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
         db 0,0,0,0,0Fh,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
         db 0,0,0,0,0Fh,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
         db 0,0,0,0,0Fh,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
         db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
         db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
         db 9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9
         db 9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9
         db 9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9
         db 9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9
         db 9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9
         db 9,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9,9
         db 9,9,9,9,9,9,9,0,0,0,0,0,0,0,0,0,0,9,9,9,9,9,9,9
         db 9,9,9,9,9,9,9,9,9,0,0,0,0,0,0,9,9,9,9,9,9,9,9,9   
 ;-----------------------------------------------------------
    delayCount dw 10000
;-------------------------------------------------------------
;---------------------MAIN MENU Parameters-------------------------------

welcome db 9,'Welcome to Jumping Guns!',10,13,10,13,10,13
mesg db 'Press p to Play',10,13,10,13,'To Exit, Press Esc',10,13,10,13,'For chat mode, Press c','$'
backmsg db 'To go back to Main Menu press ESC',10,13,'$'
chatmes db 'Sorry, chat mode is not available yet','$'
firstplyr db 10,13,'Enter first player name:','$'
secondplyr db 10,13,10,13,'Enter second player name:','$'
lvl1 db 10,13,'level 1','$'
lvl2 db  10,13 ,'level 2 ','$'
errormsg db 'Oopps,Error!',10,13,'Try Again or press ESC','$'
errorlevl2 db 'lvl 2 is not available yet, Press Esc :)','$'
wins db ' wins!','$'
plyr1name db 17 dup('$')
plyr2name db 17 dup('$')
noname1 db 0  ;parameters to check for empty name slots
noname2 db 0
;constants 
pname1X equ 10
pname1Y equ 170 
pname2X equ 234
pname2Y equ 170
;----------------------------------------------------------------------- 

.code
main proc far
mov ax,@data
mov ds,ax

;-----------------change to video mode-------------
MainMenu:
mov ah,0
mov al,13h
int 10h
call status
;--------------------------------------------------
printmess welcome
;--------------------check which key is pressed----
checkpressedkey
;-------------- 
cmp al,1Bh ;check esc 
jz e ;jump to label then to endd because it's out of range
cmp al,70h   ;if P is pressed
jz play
cmp al,63h ;if C is pressed 
jz chat
jmp tryagain
e:
jmp endd ;temp 
;--------------Chat Interface--------------------
chat:
clearscr  ;clearscr
;show error message
printmess chatmes 
checkpressedkey 
cmp al,1Bh 
jpp:
jz MainMenu
jmp tryagain
;------------------------------------------------
play: 
clearscr
call status
;----------Levels--------------------
levelcheck:
printmess lvl1 
printmess lvl2  
checkpressedkey
cmp al,31h
jz interface1 
cmp al,32h
jz interface2
cmp al,1Bh
jz escapelevelmenu 
clearscr
printmess errormsg
jmp levelcheck
interface1:
clearscr
call status
jmp startplay
interface2:
clearscr
printmess errorlevl2  
call status 
;try again:
tryagain: 
checkpressedkey
cmp al,1bh
jz aux1 
clearscr
call status
printmess errormsg 
jmp tryagain 
aux1:
jmp MainMenu 
escapelevelmenu:
call StopGame
;------------------------------------
;ClearScreen
;return here if no name was entered 
checkp1name:
startplay:
clearscr
call status

printmess backmsg ;print escape option
;---------------1st player name------------------

printmess firstplyr
mov si,offset plyr1name  
mov cx,0fh
push cx
getname1:

mov ax,0000       ;check key pressed
int 16h 
cmp al,0Dh        ;compare it with ascii enter
jz  namec      ;jump to label namec to check that the name is entered 
cmp al,1bh 
jz aux1 
cmp al,40h
ja lettercheck1        ;start of letter check if it's between 41h-5Ah 
jmp getname1
 printandsave:
mov bh,0            ;print letter and saves it in memory
mov bl,00bh  
mov cx,01
mov ah,9h 
int 10h
pop cx 
mov [si],al
inc si 
dec cx  ;to check limit 15 characters
push cx
cmp cx,00000
jz namec 
getcursor            ;get cursor position to print
movecursor 1         ;increment cursor after each letter
jmp getname1
 
lettercheck1:  ;Checks that a letter is entered not a symbol or num.
cmp al,5Ah
jb printandsave

cmp al,60h
ja lettercheck2    ;letter check between 61h-7Ah
jmp getname1 
lettercheck2:
cmp al,7Ah 
jb printandsave
jmp getname1
;------------------------------------------------- 
m:
jmp MainMenu

namec:  ;name1 check 
;Checks if p1 entered a name or not 
call nonamecheck
cmp noname1,1
jz checkp1name

name2prep:
clearscr
printmess backmsg 
call status 
mov cx,0fh
push cx 
name2:
printmess secondplyr 
mov si,offset plyr2name
getname2:
mov ax,0000       ;check key pressed
int 16h 
cmp al,0Dh        ;compare it with ascii enter 
jz endd                ;temp
cmp al,1bh
jz m 
cmp al,40h           ;check for letters part1
ja lettercheck1a 
jmp getname2
 printandsave2:
                    ;print letter and saves it in memory
mov bl,00bh   
mov cx,01
mov ah,9h 
int 10h
pop cx
mov [si],al
inc si 
dec cx 
push cx 
cmp cx,0
jz endd ;temp 
getcursor            ;get cursor position to print
movecursor 1         ;increment cursor after each letter
jmp getname2
 
lettercheck1a:  ;Checks that a letter is entered not a symbol or num. part2
cmp al,5Ah
jb printandsave2
cmp al,60h
ja lettercheck2a 
displaymess di
jmp getname2 
lettercheck2a:
cmp al,7Ah 
jb printandsave2
displaymess di
jmp getname2
;------------------------------------------------
 
endd:
call StopGame
call noname2check
cmp noname2,1
jz name2prep
call StopGame
;print names:
;----------------------------------------
;changing bg color to blue
mov cx,0 ;Column
mov dx,0 ;Row
mov al,9 ;Pixel color
mov ah,0ch ;Draw Pixel Command
bg: int 10h
 inc cx
 cmp cx,320
 jnz bg
mov cx,0
inc dx
cmp dx,200
jnz bg                   
;-----------------------------------------
 mov ah,2
mov dh,250
mov dl,9
mov bh,0
int 10h

mov ah,3
int 10h 
printmess plyr1name
mov ah,2
mov dh,250
mov dl,193

mov bh,0
int 10h
printmess plyr2name
mov ah,2
mov dh,2
mov bh,0
mov dl,9
int 10h 
;----------------------------------------
;dividing the screen to 2/3 and 1/3 for status bar
mov cx,0 ;Column
mov dx,135 ;Row
mov al,0;Pixel color
mov ah,0ch ;Draw Pixel Command
back: int 10h
 inc cx
 cmp cx,320
 jnz back 
;------------------------------------------
;getting game mode ready
call drawlife

 mov Xlife1,15
 mov Xlife11,15
 call drawlife
 
mov XLife1,30
mov XLife11,30
call drawlife

 mov Xlife1,305
 mov Xlife11,305
 call drawlife
 
  mov Xlife1,290
 mov Xlife11,290
 call drawlife
 
 mov Xlife1,275
 mov Xlife11,275
 call drawlife

;--------------------------------------------------------------
call StopGame
;Start GAME!
call drawplayer1
call drawplayer2




 startlogic1:
 
 checkeydontwait 
JZ endcheckkeysoutofrange 
         cmp ah,4bh             ;*left arrow* player 2 fires
		 jz  p2fire             ;check for player 2 fire to set its variables state -Bullet2State-
         	 
		 jmp checkp1fire        ;if this is not the command we go check another
		 
p2fire: 
cmp jumpup2state,5              ;p2 is jumping -up-
jb nofirewhilejump2             ;he is jumping so he can't fire a bullet
cmp jumpdown2state,5            ;p2 is jumping -down-
jb nofirewhilejump2             ;no firing while jumping
mov Bullet2State,0		        ;player 2 shooting function will be called 
mov al,0 
nofirewhilejump2:

                checkkey
        jmp endcheckkeys
		
checkp1fire:                   ;check for player 1 fire to set its variables state -Bullet1State-
		 cmp al,64h            ;*d* player 1 fires
		 jz  p1fire 
		
		 jmp checkp1jump        ;if this is not the command we go check another
endcheckkeysoutofrange :	 
		 jmp endcheckkeys 
		 
p1fire:                         ;check for player 1 fire to set its variables state -Bullet1State-
cmp jumpup1state,5              ;p1 is jumping -up-
jb nofirewhilejump1             ;he is jumping so he can't fire a bullet
cmp jumpdown1state,5            ;p1 is jumping -down-
jb nofirewhilejump1 
mov Bullet1State,0		        ;player 1 shooting fn. will be called 
mov al,0
nofirewhilejump1:               ;go to another check

checkkey 
jmp endcheckkeys

checkp1jump:                    ;check if player 1 wants to jump
		 cmp al,61h             ;*a* player 1 jump
		
		 jz  p1jump
        		 
		 jmp checkp2jump
		 
p1jump:
cmp   jumpup1state,-1            ;check if the player wants to jump -up- or not
jE  endcheckkeysx1               ; if it is -1 he doesn't want to jump up , he maybe wants to go down or he is not jumping
jne  endcheckkeys                ;if it's not equal to -1 then the player wants to go up -he is jumping now-
Back1:
 mov jumpup1state,0		         ;p1 jumps 
mov al,0   
checkkey
jmp endcheckkeys

startlogicfarjump:  jmp StartLogic1

checkp2jump:   
		 cmp ah,48h               ;*up arrow* player2 jump
		  jz p2jump 
         	checkkey  
		  jmp endcheckkeys
		  
p2jump:
cmp jumpup2state,-1
jE endcheckkeysx2
jnE endcheckkeys
Back2: 
mov jumpup2state,0		  ;p2 jumps
mov al,0       
checkkey
endcheckkeys:
dec DelayCount
jg startlogicfarjump
mov DelayCount,10000
call jumpup1
call endgame
call PrintWinner
call StopGame
call jumpup2       
call shootbullet1
call shootbullet2
call jumpdown2
call jumpdown1
 ;-----------------------------------------------------
  ; handling call drawbomb and exploding
 cmp bombtookoff,1
jz skipdrawingbomb


cmp life2stateP2,0
jz tryExplodeP2 ;; player 1 explodes player 2
jmp skipdrawingbomb
tryexplodeP2: 

call drawbomb

mov bombtookoff,1

skipdrawingbomb:
 call explode
 jmp startlogic1

;-------------------------------------------------


  EndCheckKeysX1:
  cmp    jumpdown1state,-1           ;check if the player wants to go down
  JE Back1                           ;he was jumping and wants to go down
     checkkey                        ;he doesn't want to go down -he is on the ground- so we clear the buffer
   jmp endcheckkeys                  ;go to start reading another key
     EndCheckKeysX2:
  cmp    jumpdown2state,-1
  JE Back2
  ;---------------------------------
   ;;;;;end game


;-------------------------------
     checkkey  ;clear buffer 
   jmp endcheckkeys
;----------------------------------------------
   
;--------------------------------------------------
 mov ah,4ch
 int 21h
main endp

;-----------------------------------------------------------
;drawing 1st player
drawplayer1 proc
  ;drawing player 29*48
 push cx
 push dx
 push ax
 mov bx,0
  mov si,offset player
mov cx,Xp1;Column
mov dx,Yp1 ;Row
 ; add Xp1,Xplayer
    ; add Yp1,Yplayer
 p: mov al,[si] 
  mov ah,0ch  
   int 10h
   inc si
  inc cx
  inc bl
  cmp bl,29
  jb  p
  
   mov cx,Xp1
   inc dx
   mov bl,0
   inc bh
  cmp bh,48
  jb  p 
  ;sub Xp1,Xplayer
   ;  sub Yp1,Yplayer
	 pop ax
  pop dx
  pop cx
  ret
  drawplayer1 endp
  ;------------------------------------------------------------
    ;clear 1st player
  clearplayer1 proc
 push cx
 push dx
 push ax
    mov si,offset player
mov cx,Xp1;Column
mov dx,Yp1 ;Row
  add Xp1,Xplayer
     add Yp1,Yplayer
 cp: mov al,9 
  mov ah,0ch  
   int 10h
   inc si
  inc cx
  cmp cx,Xp1
  jb  cp
  
   mov cx,Xp12
   inc dx
  cmp dx,Yp1
  jb  cp 
sub Xp1,Xplayer
  sub Yp1,Yplayer
  pop ax
  pop dx
  pop cx
  ret
  clearplayer1 endp
  
  
 ;--------------------------------------------------------------
 ;drawing 2nd player
 drawplayer2 proc
  ;drawing player 29*48
  push cx
 push dx
 push ax
  mov si,offset player
mov cx,Xp2;Column
mov dx,Yp2 ;Row
  add Xp2,Xplayer
      add Yp2,Yplayer

p2: mov al,[si] 
   mov ah,0ch  
  int 10h
   inc si
   inc cx
   cmp cx,Xp2
  jb p2
   mov cx,Xp22
   inc dx
  cmp dx,Yp2
  jb p2
  sub Xp2,Xplayer
      sub Yp2,Yplayer
pop ax
  pop dx
  pop cx
  ret 
  drawplayer2 endp
  ;---------------------------------------------------------
  ;clearing 2nd player
  clearplayer2 proc
  push cx
 push dx
 push ax
  
    mov si,offset player
mov cx,Xp2;Column
mov dx,Yp2 ;Row
  add Xp2,Xplayer
      add Yp2,Yplayer

cp2: mov al,9
   mov ah,0ch  
  int 10h
   inc si
   inc cx
   cmp cx,Xp2
  jb cp2
   mov cx,Xp22
   inc dx
  cmp dx,Yp2
  jb cp2
  sub Xp2,Xplayer
      sub Yp2,Yplayer
  pop ax
  pop dx
  pop cx
ret
  clearplayer2 endp
  ;------------------------------------------------------------------
  ;drawing bullet 11*7
  drawbullet1 proc
   push cx
 push dx
 push ax
  mov si,offset bullet1
mov cx,Xb1;Column
mov dx,Yb1 ;Row
  add Xb1,Xbullet
      add Yb1,Ybullet

b1: mov al,[si] 
   mov ah,0ch  
  int 10h
   inc si
   inc cx
   cmp cx,Xb1
  jb b1
   mov cx,Xb12
   inc dx                            
  cmp dx,Yb1
  jb b1
  sub Xb1,Xbullet
      sub Yb1,Ybullet
pop ax
  pop dx
  pop cx
  ret 
  drawbullet1 endp
  ;-------------------------------------------------
    ;drawing bullet 11*7
  drawbullet2 proc
push cx
 push dx
 push ax
   mov si,offset bullet2
mov cx,xb2;Column
mov dx,Yb2 ;Row
  add Xb2,Xbullet
add Yb2, Ybullet
bu2: mov al,[si] 
   mov ah,0ch  
   int 10h
   inc si
  inc cx
  cmp cx,Xb2
  jb bu2
   mov cx,Xb22
   inc dx
  cmp dx,Yb2
  jb bu2
    sub Xb2,Xbullet
sub Yb2, Ybullet
  pop ax
  pop dx
  pop cx
  ret
  drawbullet2 endp
  
  ;------------------------------------------------

  ;-----------------------------------------------------
  ;clearing bullet
  
  clearbullet1 proc
  push cx
 push dx
 push ax
     mov si,offset bullet1
mov cx,Xb1;Column
mov dx,Yb1 ;Row
  add Xb1,Xbullet
add Yb1, Ybullet
cbu: mov al,9 
   mov ah,0ch  
   int 10h
   inc si
  inc cx
  cmp cx,Xb1
  jb cbu
   mov cx,Xb12
   inc dx
  cmp dx,Yb1
  jb cbu
  sub Xb1,Xbullet
sub Yb1, Ybullet
  pop ax
  pop dx
  pop cx
ret
  
  clearbullet1 endp
  ;-----------------------------------------------------
   clearbullet2 proc
   push cx
 push dx
 push ax
     mov si,offset bullet2
mov cx,Xb2;Column
mov dx,Yb2 ;Row
  add Xb2,Xbullet
add Yb2, Ybullet
cbu2: mov al,9 
   mov ah,0ch  
   int 10h
   inc si
  inc cx
  cmp cx,Xb2
  jb cbu2
   mov cx,Xb22
   inc dx
  cmp dx,Yb2
  jb cbu2
  sub Xb2,Xbullet
sub Yb2, Ybullet
  pop ax
  pop dx
  pop cx
  
ret
  
  clearbullet2 endp
  ;-----------------------------------------------
     drawbomb proc
	 ;drawing bomb 24*29
push cx
 push dx
 push ax
     mov si,offset bomb
mov cx,Xbomb1;Column
mov dx,Ybomb1 ;Row
add Xbomb1,Xbomb
add Ybomb1, Ybomb
bo: mov al,[si] 
   mov ah,0ch  
   int 10h
   inc si
  inc cx
  cmp cx,Xbomb1
  jb bo
   mov cx,Xbomb11
   inc dx
  cmp dx,Ybomb1
  jb bo
  mov bombstate,1
  sub Xbomb1,Xbomb
sub Ybomb1, Ybomb
  pop ax
  pop dx
  pop cx
ret
  
  drawbomb endp
  ;---------------------------------------------
    drawlife proc

  ;drawing life 14*8
  push cx
  push dx
  push ax

       mov si,offset life
mov cx,Xlife1;Column
mov dx,Ylife1 ;Row
add Xlife1,Xlife
add Ylife1, Ylife
l: mov al,[si] 
   mov ah,0ch  
   int 10h
   inc si
  inc cx
 cmp cx,Xlife1
  jb l
   mov cx,Xlife11
   inc dx
cmp dx ,Ylife1
  jb l
pop ax
pop dx
pop cx
sub Xlife1,Xlife
sub Ylife1, Ylife
ret

   drawlife endp
   ;----------------------------------------------------
   drawlostlife proc
; 14*8
push ax
push cx
push dx
    mov si,offset lostlife
mov cx,XlostLife1;Column
mov dx,YlostLife1 ;Row
add XlostLife1,XLostLife
add YlostLife1, YlostLife
ll: mov al,[si] 
   mov ah,0ch  
   int 10h
   inc si
  inc cx
  cmp cx,XLostLife1
  jb ll
   mov cx,XLostlife11
   inc dx
  cmp dx,YlostLife1
  jb ll
  sub XlostLife1,XLostLife
sub YlostLife1, YlostLife
 pop dx
 pop cx
 pop ax
ret
   
   drawlostlife endp
   ;-----------------------------------------------------
 clearbomb proc
 push cx    
 push dx
 push ax

   mov si,offset bomb
mov cx,Xbomb1;Column
mov dx,Ybomb1 ;Row
 add Xbomb1,Xbomb
add Ybomb1, Ybomb
cbo: mov al,9 
   mov ah,0ch  
   int 10h
   inc si
  inc cx
  cmp cx,Xbomb1
  jb cbo
   mov cx,Xbomb11
   inc dx
  cmp dx,Ybomb1
  jb cbo
  mov bombstate,0
   sub Xbomb1,Xbomb
sub Ybomb1, Ybomb
  pop ax
  pop dx
  pop cx
ret

clearbomb endp 
    ;-------------------ANIMATION-----------------
  ;MOVE UP
  moveup proc
  push ax
  lea di,Yp1   
  mov al,[di]    ;retrieve y of player 1 from memory
  sub al,9       ;dec yp1 by 9
  mov [di],al      ;store new value of yp1 in mem.
  pop ax
  ret
  moveup endp
  
  movedown proc
  push ax
  lea di,Yp1   
  mov al,[di]    ;retrieve y of player 1 from memory
  add al,9      ;inc yp1 by 9
  mov [di],al      ;store new value of yp1 in mem.
  pop ax
  ret
  movedown endp
  ;----------------------- move bullet--------------
  ;move bullet up
    ;MOVE UP
  moveupbullet proc
  push ax
  lea di,yb1       ;bullet postion
  mov al,[di]    ;retrieve y of player 1 from memory
  sub al,9       ;dec yb1 by 9
  mov [di],al      ;store new value of yp1 in mem.
  pop ax
  ret
  moveupbullet endp
  
  movedownbullet proc
  push ax
  lea di,Yb1   ; bullet position
  mov al,[di]    ;retrieve y of player 1 from memory
  add al,9      ;inc yb1 by 9
  mov [di],al      ;store new value of yp1 in mem.
  pop ax
  ret
  movedownbullet endp
  
  ;;;;;TO DO move bullet 2
  
  
  
   ;MOVE UP
  moveup2 proc
  push ax
  lea di,Yp2   
  mov al,[di]    ;retrieve y of player 2 from memory
  sub al,9       ;dec yp1 by 9
  mov [di],al      ;store new value of yp2 in mem.
  pop ax
  ret
  moveup2 endp
  
  movedown2 proc
  push ax
  lea di,Yp2   
  mov al,[di]    ;retrieve y of player 2 from memory
  add al,9      ;inc yp1 by 9
  mov [di],al      ;store new value of yp2 in mem.
  pop ax
  ret
  movedown2 endp
  
;--------------------------------------------------------
;------------------------------------------------------------ 
;Proc JumpUp1: clears player1, decrements y by 9 and draws 
;------------------------------------------------------------
jumpup1 proc
  cmp jumpup1state,-1            ;same as jumpup2 
  jz endjumpup1
 cmp jumpup1state,5
 jl dojump
 mov jumpdown1state,0
 jmp endjumpup1
 dojump:
call clearplayer1
  call moveup
  call drawplayer1
  inc jumpup1state  ;check to stop jumping up
  
endjumpup1:  
ret 
jumpup1 endp
;-------------------------------------------------------------
;------------------------------------------------------------ 
;Proc JumpDown1: clears player1, increments y by 9 and draws 
;------------------------------------------------------------
jumpdown1 proc                      ;same as jumpdown2 
 cmp   jumpdown1state,-1
 jz   endjumpdown1
cmp jumpdown1state,5
jl dojumpdown1 
jE Set1
jmp endjumpdown1
Set1:
mov  jumpdown1state,-1
jmp endjumpdown1
dojumpdown1:
 call clearplayer1
  call movedown
  mov jumpup1state,-1 
  call drawplayer1
  inc jumpdown1state 
 
  endjumpdown1:
ret 
jumpdown1 endp
;-------------------------------------------------------------
;------------------------------------------------------------ 
;Proc JumpUp2: clears player1, decrements y by 9 and draws 
;------------------------------------------------------------
jumpup2 proc 
    cmp jumpup2state,-1
jz endjumpup2                   ;if -1 don't jump up  
cmp jumpup2state,5              ;if below 5 jump up and set jumpdown2state by zero to prevent jumping down while 
jl dojump2                      ;the player is jumping up 
mov jumpdown2state,0
jmp endjumpup2
dojump2:
 call clearplayer2             
  call moveup2
  call drawplayer2
  inc jumpup2state  
endjumpup2:  
ret 
jumpup2 endp
;------------------------------------------------------------ 
;Proc JumpDown1: clears player1, increments y by 9 and draws 
;------------------------------------------------------------
jumpdown2 proc   
    cmp jumpdown2state,-1  ;for the first jump to compare with initial condition which is on ground 
jz endjumpdown2              ;if yes don't jumpdown  
cmp jumpdown2state,5    ;if below 5 reset with -1 =ff  to prevent performing jumpdowns while looping on conditions 
jl dojumpdown2 
je Set2              
jmp endjumpdown2
Set2:
mov jumpdown2state,-1
jmp endjumpdown2

dojumpdown2:            ;if the jumpdown is performed 
call clearplayer2       ;clear the player,move it down and re draw it 
  call movedown2
 mov   jumpup2state,-1      
  call drawplayer2  
  inc jumpdown2state  
 
  endjumpdown2:        
ret 
jumpdown2 endp
  ;-------------------------------------------------------------------------
  ;-----------------move bullet of player 1 to the right---------------------
  ;-------------------------------------------------------------------------
  movebullet1 proc
  push ax
  lea di,xb1                ;coordinate of drawing
  mov al,[di]
  add al,18                 ;shifted by 18
  mov [di],al
  lea di,xb12               ;coordinate of drawing
  mov al,[di]
  add al,18
  mov [di],al
  pop ax
  ret
  movebullet1 endp
  ;-------------------------------------------------------------------------
  ;-----------------move bullet of player 2 to the left---------------------
  ;-------------------------------------------------------------------------
  
   movebullet2 proc
  push ax
  lea di,xb2                ;coordinate of drawing
  mov al,[di]
  sub al,18                 ;shifted by 18
  mov [di],al
  lea di,Xb22               ;coordinate of drawing
  mov al,[di]
  sub  al,18
  mov [di],al
  pop ax
  ret
  movebullet2 endp
  ;----------------------- adjusted---------------------------------
  ;-----------------------------------------------------------------
 shootbullet1 proc
  push cx
  cmp Bullet1State,0                   ;if it is a new bullet it must be shooted when the player is on the ground
  jz checkifplayer1isjumping           ;check if the player is on th ground or jumping
  jmp continueshootbullet1             ;if it is an old bullet that was shooted it will contine 
  checkifplayer1isjumping:             ;the check of the player states
  cmp jumpup1state,6                   ;when the player is jumping he can't fire
  jb EndBulletShoot                    ;no bullet
  cmp jumpdown1state,6                 ;when the player is jumping he can't fire
  jb EndBulletShoot                    ;no bullet
  continueshootbullet1:                ;the sequence of shooting an old bullet or a bullet when the player is on the ground
  CMP Bullet1State,0CH                 ;check on the bullet positon
  Jb BulletUpdated                     ;update the bullet position
   je labelsetbullet 
  jmp EndBulletShoot                   ;bullet finished 
BulletUpdated:                         
 ADD Bullet1State ,2                   ;update bullet state
  
  mov cx,2h                            ;distance between 2 players
  bull1:
 
	call clearbullet1                  ;clear old bullet
	   call movebullet1                ;the displacement of the bullet
  call drawbullet1                     ;draw the new bullet
  

;delay 
  loop bull1
 
  CMP Bullet1State,0CH             ;check if this is the last bullet so we clear it
  JL EndBulletShoot                ;if it a no then we go out of this proc
  call clearbullet1                ;if this is the last one than we clear it
  jmp EndBulletShoot               
labelsetbullet:  
 call kill2                        ;check if we killed the other player with the last dispacement of bullet
 add Bullet1State,1                ;update bullet state
 call  setbulletpos1               ;set the right position of the bullet for the new bullet next time
 

EndBulletShoot:
   
  pop cx
  ret
  shootbullet1 endp
;------------------------------------------------------------
shootbullet2 proc
  push cx
  cmp Bullet2State,0                   ;if it is a new bullet it must be shooted when the player is on the ground
  jz checkifplayer2isjumping           ;check if the player is on th ground or jumping
  jmp continueshootbullet2             ;if it is an old bullet that was shooted it will contine 
  checkifplayer2isjumping:             ;the check of the player states
   cmp jumpup2state,6                  ;when the player is jumping he can't fire
  jb EndBulletShoot                    ;no bullet
  cmp jumpdown2state,6                 ;when the player is jumping he can't fire
  jb EndBulletShoot                    ;no bullet
  continueshootbullet2:                ;the sequence of shooting an old bullet or a bullet when the player is on the ground
  CMP Bullet2State,8                   ;check on the bullet positon
  Jb BulletUpdated2                    ;update the bullet position
  je labelsetbullet2
  jmp EndBulletShoot2                  ;bullet finished 
BulletUpdated2:
  ADD Bullet2State ,2                  ;update of bullet state
  
  mov cx,2h                            ;distance between 2 players
  bull2:
 
       call clearbullet2                ;clear old bullet
	   call movebullet2                 ;the displacement of the bullet
       call drawbullet2                 ;draw new bullet
  
 
  loop bull2
 
  CMP Bullet2State,8                    ;check if this is the last bullet so we clear it
  JL EndBulletShoot2                    ;if it a no then we go out of this proc
  call clearbullet2                     ;if this is the last one than we clear it
  jmp EndBulletShoot2
   labelsetbullet2:
   call kill1                           ;check if we killed the other player with the last dispacement of bullet
   add Bullet2State,1                   ;update bullet state
   call setbulletpos2                   ;set the right position of the bullet for the new bullet next time


EndBulletShoot2: 

 
  pop cx
  ret
  shootbullet2 endp

 ;--------------------------------------------------------------------------------------------
 ;--------------------set bullet 1 to its initial pos after every shoot-----------------
 ;--------------------------------------------------------------------------------------------
  setbulletpos1  proc 
  push ax
  mov di,offset xb1 
  mov ax,[di]
  mov ax,39         ;moves 39 to x coordinate and 110 to y coordinate 
  mov [di],ax 
  mov di,offset Xb12
   mov ax,[di]
  mov ax,39
   mov [di],ax
mov di,offset yb1 ; gets initial position
mov ax ,[di]
mov ax,110
mov [di],ax    
  pop ax 
  ret 
 setbulletpos1 endp 
 ;--------------------------------------------------------------------------------------------
 ;--------------------set bullet 2 to its initial pos after every shoot-----------------
 ;--------------------------------------------------------------------------------------------
 setbulletpos2  proc   ;same steps as setbulletpos1 but different coordinates 
  push ax
  mov di,offset xb2 
  mov ax,[di]
  mov ax,273
  mov [di],ax 
  mov di,offset Xb22
   mov ax,[di]
  mov ax,273
   mov [di],ax 
   mov di,offset yb2 ; gets initial position
mov ax ,[di]
mov ax,110
mov [di],ax    
  pop ax 
  ret 
 setbulletpos2 endp 
   ;------------------------------------------------------
   setplayer1pos proc ; return player 1 to initial position
    push ax
  
mov di,offset yp1 ; gets initial position
mov ax ,[di]
mov ax,87
mov [di],ax    
  pop ax 
   
   
   ret
   setplayer1pos endp
   
      setplayer1posup proc ; set player up
    push ax
  
mov di,offset yp1 ; gets initial position
mov ax ,[di]
mov ax,42
mov [di],ax    
  pop ax 
   
   
   ret
   setplayer1posup endp
   
     setplayer2pos proc ; return player 2 to initial position
    push ax
  
mov di,offset yp2 ; gets initial position
mov ax ,[di]
mov ax,87
mov [di],ax    
  pop ax 
   
   
   ret
   setplayer2pos endp
   
      setplayer2posup proc ; set player up
    push ax
  
mov di,offset yp2 ; gets initial position
mov ax ,[di]
mov ax,42
mov [di],ax    
  pop ax 
   
   
   ret
   setplayer2posup endp
;--------------------------------------
 
;--------------------------------------
    ;------------------------------------------------------------ 
;Proc kill2: reduces the lives of player 2 until killed
;----------------------------------------------------
;--------------------------------------
  kill2 proc
  
  ;cmp Bullet1State,0ch ;if bullet didn't reach end we will end proc
  ; jb outkill2
   cmp yp2,61
   jb outkill2                    ;bullet 1  didnt reach p2 
   
  
   cmp life1stateP2,1
   jz clear12                     ;clear first live 2nd player
   cmp life2stateP2,1
   jz clear22
   cmp life3stateP2,1
   jz clear32
   
   jmp outkill2 
   
   clear12:                       ;;1st live 2nd player
   mov XLostLife1,275
   mov XLostlife11,275
   call drawlostlife              ;draws black heart on 1st heart of player 2
   mov life1stateP2,0             ;1st life of player 1 is lost 
call setbulletpos1   
   jmp outkill2
   clear22:                       ;clear 2nd live 2nd player
   mov XLostLife1,290
   mov XLostlife11,290
   call drawlostlife              ;draws black heart on 2nd heart of player 2
   mov life2stateP2,0             ;2nd life of player 2 is lost 
call setbulletpos1   
   jmp outkill2
   clear32:                       ;clears 3rd live 2nd player
   mov XLostLife1,305
   mov XLostlife11,305
   call drawlostlife              ;draws black heart on 3rd heart of player 2
   mov life3stateP2,0             ;3rd life of player 2 is lost 
call setbulletpos1   
                                  ;terminate game winner 1
   jmp outkill2
   
   outkill2:
   
   ret 
   kill2 endp
   ;------------------------------------------------------------------
   ;------------------------------------------------------------ 
;Proc kill1: reduces the lives of player 1 until killed
;----------------------------------------------------
   kill1 proc
  
   cmp Bullet2State,8          ;if bullet didn't reach end we will end proc
   jb outkill1
   cmp yp1,61                  ;check if bullet is going to hit the player  
   jb outkill1
   
  
   cmp life1stateP1,0          ;checks if alive if not clear heart
   jnz clear11                 ;clear first live 1st player
   cmp life2stateP1,0
   jnz clear21
   cmp life3stateP1,0
   jnz clear31
   clear11:                    ;;1st live 1st player
   mov XLostLife1,30
   mov XLostlife11,30
   call drawlostlife           ;draws black heart on 1st heart of player 1
   mov life1stateP1,0          ;1st life of player 1 is lost 

   jmp outkill1
   clear21:                    ; clear 2nd live 1st player
   mov XLostLife1,15
   mov XLostlife11,15
   call drawlostlife           ;draws black heart on 2nd heart of player 1
   mov life2stateP1,0          ;2nd life of player 1 is lost 

   jmp outkill1
   clear31:                    ;clears 3rd live 1st player
      mov XLostLife1,0
   mov XLostlife11,0
   call drawlostlife           ;draws black heart on 3rd heart of player 1
   mov life3stateP1,0          ;3rd life of player 1 is lost 
   
  
   jmp outkill1
   
   outkill1:
   
   ret 
   kill1 endp
;--------------------------------------------------   
 explode proc ;clears the bomb after a player hits it with his bullet !
  cmp bombstate,0   
  jz outofexplode
  
 
  cmp Bullet1State,6
  jnz label1
  
     explode2: 
  call clearbomb               ;clears the bomb
  call clearbullet1            ;clear the bullet after it hits the bomb
  call setbulletpos1           ;set bullet position -yb1- for the next time the players shoot
  mov Bullet1State,-1          ;when it enter shootbullet it will find that the state isn't set to continue shooting so it will stop
  call explodekill2            ;control the lives of the players according to the states
  jmp outofexplode
  
  label1:
  cmp Bullet2State,6
  jnz outofexplode
 
 explode1:
    call clearbomb              ;clears the bomb    
  call clearbullet2             ;clear the bullet after it hits the bomb
  call setbulletpos2            ;set bullet position -yb2- for the next time the players shoot
  mov Bullet2State,-1           ;when it enter shootbullet it will find that the state isn't set to continue shooting so it will stop
  call explodekill1             ;control the lives of the players according to the states
    jmp outofexplode

 
 outofexplode:
 ret 
 explode endp

;--------------------------------------------------------
   ;------------------------------------------------------------ 
;Proc explodekill2: reduces the lives of player 2 when player 1 shoots the bomb
;----------------------------------------------------
;--------------------------------------------------------
explodekill2 proc

 cmp life1stateP2,0
   jnz clear12k                   ;clear first live 2nd player
   cmp life2stateP2,0
   jnz clear22k
   cmp life3stateP2,0
   jnz clear32k
   clear12k:                      ;1st live 2nd player
   mov XLostLife1,275
   mov XLostlife11,275
   call drawlostlife              ;draws black heart on 1st heart of player 2
   mov life1stateP2,0             ;1st life of player 2 is lost 
   jmp outofexplode2
   clear22k:                      ; clear 2nd live 2nd player
   mov XLostLife1,290
   mov XLostlife11,290
   call drawlostlife              ;draws black heart on 2nd heart of player 2
   mov life2stateP2,0             ;2nd life of player 2 is lost 
   jmp outofexplode2
   clear32k:                      ;clears 3rd live 2nd player
      mov XLostLife1,305
   mov XLostlife11,305
   call drawlostlife              ;draws black heart on 3rd heart of player 2
   mov life3stateP2,0             ;3rd life of player 2 is lost 
                                  ;;;; terminate game winner 1
   jmp outofexplode2
   
outofexplode2:
ret
explodekill2 endp
;--------------------------------------------
  ;------------------------------------------------------------ 
;Proc explodekill1: reduces the lives of player 1 when player 2 shoots the bomb
;----------------------------------------------------
   explodekill1 proc
  
   cmp life1stateP1,0
   jnz clear12kk                   ;clear first live 2nd player
   cmp life2stateP1,0
   jnz clear22kk
   cmp life3stateP1,0
   jnz clear32kk
   clear12kk:                      ;;1st live 2nd player
   mov XLostLife1,30
   mov XLostlife11,30
   call drawlostlife               ;draws black heart on 1st heart of player 1
   mov life1stateP1,0              ;1st life of player 1 is lost 
   jmp outofexplode1
   clear22kk:                      ; clear 2nd live 2nd player
   mov XLostLife1,15
   mov XLostlife11,15
   call drawlostlife               ;draws black heart on 2nd heart of player 1
   mov life2stateP1,0              ;2nd life of player 1 is lost 
   jmp outofexplode1
   clear32kk:                      ;clears 3rd live 2nd player
      mov XLostLife1,0
   mov XLostlife11,0
   call drawlostlife               ;draws black heart on 3rd heart of player 1
   mov life3stateP1,0              ;3rd life of player 1 is lost 
                                   ;;;terminate game winner 2
   jmp outofexplode1
   
   outofexplode1:
   
   ret 
   explodekill1 endp
;---------------------------------------- 
endgame proc
cmp life3stateP1,0             ;zero player 1 still alive
jnz checkonp2                  ;check if player 2 is killed
mov winner2,1                  ;the winner is player 2
mov gameon,0                   
jmp continue

checkonp2:                     ;check 2ndplayer
cmp life3stateP2,0             ;zero player 2 still alive
jnz continue
mov winner1,1

mov gameon,0
call drawplayer2
continue:
ret
endgame endp
;------------------------------------------------ 
;Stop game proc: Checks if esc is pressed to clear screen and exit 
;-----------------------------------------------
StopGame proc
mov winner1,0   ;in case esc isn't pressed 
mov winner2,0   ;keep vars zero 

cmp al,1bh
jz doexit
jmp dontexit

doexit:
clearscr 
mov ah,4ch 
int 21h

dontexit:
ret 
StopGame endp 
;-----------------------------------
; Print winner proc: Prints Name+ the word wins 
;--------------------------------------------------
PrintWinner proc  
cmp winner1,1
jz p1wins
cmp winner2,1
jz p2wins
jmp outwin 
p1wins:
printmess plyr1name
printmess wins
jmp quit 
p2wins:
printmess plyr2name
printmess wins
quit:

mov ah,4ch
int 21h 
outwin:
ret 
PrintWinner endp 
;Menu PROC:
;------------------------------

;---------------------

status proc

;dividing the screen to 2/3 and 1/3 for status bar
mov cx,0 ;Column
mov dx,135 ;Row
mov al,5h;Pixel color
mov ah,0ch ;Draw Pixel Command

b: 
int 10h
 inc cx
 cmp cx,320
 jnz b
 
 ret 
status endp
;-----------------------------------------------
nonamecheck proc    ;Checks if no name was entered 
mov si,offset plyr1name
cmp byte ptr [si],24h ;ascii $ compares with it 
jz nop1name
jmp noerror 
nop1name:
mov noname1,1 ;change state variable to 1 as an indication 
jmp endnoname1
noerror:
mov noname1,0  ;if the not zf make sure it's 0
endnoname1:
ret 
nonamecheck endp 
;----------------------------------------------------
noname2check proc   ;same as above for plyr 2 
mov si,offset plyr2name
cmp byte ptr [si],24h ;ascii $
jz nop2name
jmp noerror2 
nop2name:
mov noname2,1
jmp endnoname2
noerror2:
mov noname2,0
endnoname2:
ret 
noname2check endp 

;---------------------------------------------------
end main
