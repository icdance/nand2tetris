// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// (LOOP)
//     @i
//     M=0
//     @KBD
//     D=M     // if M(kbd) > 0
//     @FILL
//     D;JNE   // goto FILL
//     @WIPE
//     D;JEQ   // goto Back

// (FILL)
// (INLOOP)
//     @i
//     D=M
//     @8191
//     D=D-A
//     @LOOP   // for i = addr to 8192
//     D;JGT
//     @i
//     D=M
//     M=M+1
//     @SCREEN
//     A=D+A
//     M=-1    // M(i) = -1
//     @INLOOP
//     0;JMP

// (WIPE)
// (WIPELOOP)
//     @i
//     D=M
//     @8191
//     D=D-A
//     @LOOP   // for i = addr to 8192
//     D;JGT
//     @i
//     D=M
//     M=M+1
//     @SCREEN
//     A=D+A
//     M=0    // M(i) = -1
//     @WIPELOOP
//     0;JMP



//     @black
//     M=0

// (LOOP)
//     @KBD
//     D=M
//     @KEYPRESS
//     D;JNE
//     @NOKEYPRESS
//     D;JEQ

// (KEYPRESS)
//     @black
//     D=M
//     @FILL
//     D;JEQ   // if key&!black then fill
//     @LOOP
//     D;JGT   // if key&black then pass

// (NOKEYPRESS)
//     @black
//     D=M
//     @LOOP   // if !key&black then wipe
//     D;JEQ
//     @WIPE
//     D;JGT   // if !key&!black then pass

// (FILL)      // i=0, black=1
//     @i
//     M=0
//     @black
//     M=1
// (INLOOP)
//     @i
//     D=M
//     @8191
//     D=D-A   // for i = addr to 8192
//     @LOOP   
//     D;JGT
//     @i
//     D=M
//     M=M+1
//     @SCREEN
//     A=D+A
//     M=-1    // M(i) = -1
//     @INLOOP
//     0;JMP

// (WIPE)
//     @i
//     M=0
//     @black
//     M=0
// (WIPELOOP)
//     @i
//     D=M
//     @8191
//     D=D-A
//     @LOOP   // for i = addr to 8192
//     D;JGT
//     @i
//     D=M
//     M=M+1
//     @SCREEN
//     A=D+A
//     M=0    // M(i) = -1
//     @WIPELOOP
//     0;JMP


    @black
    M=0
    @prekey
    M=0
(LOOP)
    @KBD
    D=M
    @curkey
    M=D
    @prekey
    D=M-D
    @ACTION
    D;JNE
    @LOOP
    0;JMP

(ACTION)
    @i
    M=0
    @black
    M=!M
    @curkey
    D=M
    @prekey
    M=D

(INLOOP)
    @i
    D=M
    @8191
    D=D-A   // for i = addr to 8192
    @LOOP   
    D;JGT
    @i
    D=M
    M=M+1
    @SCREEN
    A=D+A
    M=!M    // M(i) = -1
    @INLOOP
    0;JMP
