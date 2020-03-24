/* mipslabwork.c

   This file written 2015 by F Lundevall
   Updated 2017-04-21 by F Lundevall

   This file should be changed by YOU! So you must
   add comment(s) here with your name(s) and date(s):

   This file modified 2017-04-31 by Ture Teknolog

   For copyright and licensing, see file COPYING */

#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "mipslab.h"  /* Declatations for these labs */

int mytime = 0x5957;
volatile int* tr = (volatile int*) 0xbf886100;
volatile int* b = (volatile int*) 0xbf886110; //portE pekare
int i = 0;
int timeoutcount = 0;
int prime = 1234567;
//volatile int* trd = (volatile int*) 0x860C0;

char textstring[] = "text, more text, and even more text!";

/* Interrupt Service Routine */
void user_isr( void ) {

if((IFS(0) & 0x100) == 0x100){
 timeoutcount++;
 IFSCLR(0) = 0x100;

 if(timeoutcount == 10){
 time2string( textstring, mytime );
 display_string( 3, textstring );
 display_update();
 tick( &mytime );

 timeoutcount = 0;
 }
}

if((IFS(0) & 0x80) == 0x80){
  IFSCLR(0) = 0x80;
  *b = i;
  i++;
}

}
/* Lab-specific initialization goes here */
void labinit( void )
{

  *b = 0; //ASSÅ, typ output zero to portE?
  *tr = *tr|0xFF80; //TRISE porten som vi gjorde själva
  TRISDSET = 0xFE0;

  T2CON = 0x70; // Stop timer and clear control register, //prescale för 256
  TMR2 = 0x0; // Clear timer registe
  PR2 = 0x7A12; // Load period register (80.000.000/256) /10, 80 mil för tick, 256 för prescale, inte inom intervall så 10 för 10 flaggor lol.

//interrupt for vanliga assignment
  IECSET(0) = 0x100; //enable the interrupt
  IPCSET(2) = 0x4; //set the priority
  IPCSET(2) = 0x0; //set subpriority

  //suprise assignment
  IECSET(0) = 0x80;
  IPCSET(1) = 0x10000000;

  T2CONSET = 0x8000; // Start timer
  enable_interrupt();


  return;
}

/* This function is called repetitively from the main program */
void labwork( void ) {
 prime = nextprime( prime );
 display_string( 0, itoaconv( prime ) );
 display_update();
}
