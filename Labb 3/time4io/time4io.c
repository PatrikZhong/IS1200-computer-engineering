#include <stdint.h>
#include <pic32mx.h>
#include  "mipslab.h"

int getsw(){

int switchall = (PORTD >> 8) & 0xF;
  return switchall;
}

int getbtns(){
int btns = (PORTD >> 5) & 0x7;
return btns;
  //int btnall = btn2|btn3|btn4;

  //return btnall;

}
