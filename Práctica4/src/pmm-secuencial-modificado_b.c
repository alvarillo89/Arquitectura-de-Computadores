#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char* argv[]){

	struct timespec cgt1,cgt2; 
	double ncgt;

	if(argc < 2){
		printf("Modo de empleo: %s, N\n", argv[0]);
		exit(-1);
	}

	int N = atoi(argv[1]);
	
	//Reservar memoria dinámica:
	//Alineación de los datos y modificación de la matriz por un vector:
	double *A, *B, *C;

	double *Atmp = (double *) malloc(N*N*sizeof(double)+63);
	double *Btmp = (double *) malloc(N*N*sizeof(double)+63);
	double *Ctmp = (double *) malloc(N*N*sizeof(double)+63);

	A = (double *) (((long int)Atmp+63)&~(63));
	B = (double *) (((long int)Btmp+63)&~(63));
	C = (double *) (((long int)Ctmp+63)&~(63));

	if(A == NULL || B == NULL || C == NULL){
		printf("No se ha podido reservar memoria\n");
		exit(-1);
	}

	//Inicializar elementos:

	for(int i = 0; i<N; ++i)
		for(int j = 0; j<N; ++j){
			A[i*N+j] = 0.0;
			B[i*N+j] = N*0.1 + i*0.1;
			C[i*N+j] = N*0.1 - i*0.1;
		}

	//Realizar R = M * V y medir tiempo:

	clock_gettime(CLOCK_REALTIME, &cgt1);

	for(int i = 0; i<N; ++i)
		for(int k = 0; k<N; ++k)
			for(int j = 0; j<N; ++j)
				A[i*N+j] += B[i*N+k] * C[k*N+j];
		
	clock_gettime(CLOCK_REALTIME, &cgt2);
	ncgt= (double) (cgt2.tv_sec - cgt1.tv_sec) + (double) ((cgt2.tv_nsec - cgt1.tv_nsec)/(1.e+9));

	//Imprimir resultados:
	
	if(N<12){
		printf("Tiempo transcurrido (seg): %11.9f \n\nMatriz 1 generada:\n", ncgt);
		for(int i = 0; i<N; ++i){
			for(int j = 0; j<N; ++j)
				printf("[%.1f]", B[i*N+j]);
			printf("\n");
		}
		printf("\n\nMatriz 2 generada:\n");
		for(int i = 0; i<N; ++i){
			for(int j = 0; j<N; ++j)
				printf("[%.1f]", C[i*N+j]);
			printf("\n");
		}
		
		printf("\n\nResultado:\n");
		for(int i = 0; i<N; ++i){
			for(int j = 0; j<N; ++j)
				printf("[%.2f]", A[i*N+j]);
			printf("\n");
		}			

		printf("\n");
	}
	else
		printf("Tiempo(seg.): %11.9f \nTamaño: %u \nB[0][0]*C[0][0]=A[0][0] = %.1f \nB[%d][%d]*C[%d][%d]=A[%d][%d] = %.2f \n",ncgt,N, A[0], N-1, N-1,N-1, N-1,N-1, N-1, A[N*N-1]);

	//Liberar memoria:

	free(Atmp);
	free(Btmp);
	free(Ctmp);
			
	exit(0);
}
