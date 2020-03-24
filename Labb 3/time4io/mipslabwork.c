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
int i = 0;
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

  *tr = *tr&0xFFFFFF00; //TRISE porten som vi gjorde själva
  TRISDSET = 0xFE0;
  return;
}

/* This function is called repetitively from the main program */
void labwork( void )
{
  delay( 1000 );
  time2string( textstring, mytime );
  display_string( 3, textstring );
  display_update();
  tick( &mytime );
  display_image(96, icon);

  //if (getbtns() != 0){

      if(getbtns() & 0x1){ //button 2
        mytime = mytime & 0xFF0F;
        mytime = (getsw() << 4) | mytime;
      //  mytime = 0xFFFF;
      }

      if(getbtns() & 0x2){ //button 3
        mytime = mytime & 0xF0FF;
        mytime = (getsw() << 8) | mytime;
        //mytime = 0x0000;
      }

      if((getbtns() & 0x4) == 4){ //rumppå 4
        mytime = mytime & 0x0FFF;
        mytime = (getsw() << 12) | mytime;
      //  mytime = 0x00FF;
      }

//  }

  volatile int* b = (volatile int*) 0xbf886110;
  *b = i;
  i++;


}
