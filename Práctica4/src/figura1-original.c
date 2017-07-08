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

		for(int i=0; i<5000;i++) X1+=2*s[i].a+ii;

		for(int i=0; i<5000;i++) X2+=3*s[i].b-ii;

		if (X1<X2) 
			R[ii]=X1; 
		else 
			R[ii]=X2;
	}

	clock_gettime(CLOCK_REALTIME, &cgt2);
	ncgt= (double) (cgt2.tv_sec - cgt1.tv_sec) + (double) ((cgt2.tv_nsec - cgt1.tv_nsec)/(1.e+9));
	
	//Imprimir resultados:
	printf("Tiempo transcurrido (seg): %11.9f // R[0] = %d // R[39999] = %d\n", ncgt, R[0], R[39999]);

	free(R);

}
