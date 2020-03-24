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
//volatile int* trd = (volatile int*) 0x860C0;

char textstring[] = "text, more text, and even more text!";

/* Interrupt Service Routine */
void user_isr( void )
{
  return;
}

/* Lab-specific initialization goes here */
void labinit( void )
{

  *tr = *tr|0xFF80; //TRISE porten som vi gjorde själva

  TRISDSET = 0xFE0;

  T2CON = 0x70; // Stop timer and clear control register, //prescale för 256
          // set prescaler at 1:1, internal clock source
  TMR2 = 0x0; // Clear timer registe
  PR2 = 0x7A12; // Load period register (80.000.000/256) /10, 80 mil för tick, 256 för prescale, inte inom intervall så 10 för 10 flaggor lol.
  T2CONSET = 0x8000; // Start timer
  return;
}

/* This function is called repetitively from the main program */
void labwork( void )
{

if((IFS(0) & 0x100) == 0x100){
    //delay( 1000 );
  display_image(96, icon);

  //IFS(0) = (IFS(0) & 0xFFFFFEFF); //clear bit 8 lol

  timeoutcount++;

}
if(timeoutcount == 10){

  time2string( textstring, mytime );
  display_string( 3, textstring );
  display_update();
  tick( &mytime );
  *b = i;
  i++;
  timeoutcount = 0;
}

  //if (getbtns() != 0){

      if(getbtns() & 0x1){ //button 2
        mytime = mytime & 0xFF0F;
        mytime = (getsw() << 4) | mytime;
      //  mytime = 0xFFFF;
      }

      if((getbtns() & 0x2) == 2){ //button 3
        mytime = mytime & 0xF0FF;
        mytime = (getsw() << 8) | mytime;
        //mytime = 0x0000;
      }

      if((getbtns() & 0x4) == 4){ //rumppå 4
        mytime = mytime & 0x0FFF;
        mytime = (getsw() << 12) | mytime;
      //  mytime = 0x00FF;
      }

  //}

 //port E pekare inkrementeras



}
