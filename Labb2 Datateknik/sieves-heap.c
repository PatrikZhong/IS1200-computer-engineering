
#include <stdio.h>
#include <stdlib.h>

#define COLUMNS 6
int OLD_COLUMNS = COLUMNS;

void print_number (int n){

    printf("%10d", n);
    OLD_COLUMNS = OLD_COLUMNS - 1;
    if(OLD_COLUMNS == 0){
      printf("\n");
      OLD_COLUMNS = COLUMNS;
    }
}

void print_sieves(int n){
  int * primes = malloc(sizeof(int)*(n-1));;

  for(int i = 0; i < n - 1; i++){ //Fyller med ettor
    primes[i] = 1;

  }

  for(int i = 0; i < n - 1; i++){ //hittar primtalen
    int k = 2;
    if (primes[i] == 1) {
      for (int j = 0; j < n - 1 ; j++){
        if(((i + 2)) * k <= (n + 2)) { //stryka alla mina icke-primtal
        primes[ ( (i + 2) * k) - 2] = 0;
        k++;
        }

      }
    }
  }

  for(int i = 0; i < n - 1; i++){
    if(primes[i] == 1){

      print_number(i + 2);
    }
  }
    free (primes);
}


int main(int argc, char *argv[]){
  if(argc == 2)
    print_sieves(atoi(argv[1]));
  else
    printf("Please state an integer number.\n");
  return 0;


}
