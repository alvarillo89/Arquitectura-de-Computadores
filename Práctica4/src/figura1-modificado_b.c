#include <stdio.h>
#include <stdlib.h>
#include <time.h>

struct{
	int a;
	int b;
} s[5000];


int main(){

	struct timespec cgt1,cgt2; 
	double ncgt;
	int* R = (int*) malloc(40000*sizeof(int));
	int X1, X2;

	clock_gettime(CLOCK_REALTIME, &cgt1);

	for(int ii=0; ii<40000;ii++){
		X1=0; 
		X2=0;

		for(int i = 0; i < 5000; i+=4){
            X1 += 2*s[i].a+ii;
            X2 += 3*s[i].b-ii;
            X1 += 2*s[i+1].a+ii;
            X2 += 3*s[i+1].b-ii;
            X1 += 2*s[i+2].a+ii;
            X2 += 3*s[i+2].b-ii;
            X1 += 2*s[i+3].a+ii;
            X2 += 3*s[i+3].b-ii;
        }

		R[ii]= (X1<X2)? X1 : X2;
	}

	clock_gettime(CLOCK_REALTIME, &cgt2);
	ncgt= (double) (cgt2.tv_sec - cgt1.tv_sec) + (double) ((cgt2.tv_nsec - cgt1.tv_nsec)/(1.e+9));
	
	//Imprimir resultados:
	printf("Tiempo transcurrido (seg): %11.9f // R[0] = %d // R[39999] = %d\n", ncgt, R[0], R[39999]);

	free(R);

}
