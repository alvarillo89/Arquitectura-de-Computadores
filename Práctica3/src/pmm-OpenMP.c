#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#ifdef _OPENMP
	#include <omp.h>
#endif

int main(int argc, char* argv[]){

	struct timespec cgt1,cgt2; 
	double ncgt;
	int i,j,k;

	if(argc < 2){
		printf("Modo de empleo: %s, N\n", argv[0]);
		exit(-1);
	}

	int N = atoi(argv[1]);
	
	//Reservar memoria dinámica:

	double** A = (double**) malloc(N*sizeof(double*));
	double** B = (double**) malloc(N*sizeof(double*));
	double** C = (double**) malloc(N*sizeof(double*));
	for(i = 0; i<N; ++i){
		A[i] = (double*) malloc(N*sizeof(double));
		B[i] = (double*) malloc(N*sizeof(double));
		C[i] = (double*) malloc(N*sizeof(double));
	}

	if(A == NULL || B == NULL || C == NULL){
		printf("No se ha podido reservar memoria\n");
		exit(-1);
	}

	//Inicializar elementos:

	#pragma omp parallel for private(j)
	for(i = 0; i<N; ++i)
		for(j = 0; j<N; ++j){
			A[i][j] = 0.0;
			B[i][j] = N*0.1 + i*0.1;
			C[i][j] = N*0.1 - i*0.1;
		}

	//Realizar R = M * V y medir tiempo:

	clock_gettime(CLOCK_REALTIME, &cgt1);

	double res = 0.0; 
	#pragma omp parallel private(j,i)
	{
		for(i =0 ; i<N; ++i) 
			for(j=0; j<N; ++j){
				#pragma omp for reduction(+:res)
				for(k=0; k<N; ++k)
					res += B[i][k] * C[k][j];
				#pragma omp single 
				{		
					A[i][j] = res;
					res = 0;
				}
			}
	}
		
	clock_gettime(CLOCK_REALTIME, &cgt2);
	ncgt= (double) (cgt2.tv_sec - cgt1.tv_sec) + (double) ((cgt2.tv_nsec - cgt1.tv_nsec)/(1.e+9));

	//Imprimir resultados:

	if(N<12){
		printf("Tiempo transcurrido (seg): %11.9f \n\nMatriz 1 generada:\n", ncgt);
		for(i = 0; i<N; ++i){
			for(j = 0; j<N; ++j)
				printf("[%.1f]", B[i][j]);
			printf("\n");
		}
		printf("\n\nMatriz 2 generada:\n");
		for(i = 0; i<N; ++i){
			for(j = 0; j<N; ++j)
				printf("[%.1f]", C[i][j]);
			printf("\n");
		}
		
		printf("\n\nResultado:\n");
		for(i = 0; i<N; ++i){
			for(j = 0; j<N; ++j)
				printf("[%.2f]", A[i][j]);
			printf("\n");
		}			

		printf("\n");
	}
	else
		printf("Tiempo(seg.): %11.9f \nTamaño: %u \nB[0][0]*C[0][0]=A[0][0] = %.1f \nB[%d][%d]*C[%d][%d]=A[%d][%d] = %.2f \n",ncgt,N, A[0][0], N-1, N-1,N-1, N-1,N-1, N-1, A[N-1][N-1]);

	//Liberar memoria:
	for(i = 0; i<N; ++i){
		free(A[i]);
		free(B[i]);
		free(C[i]);
	}

	free(A);
	free(B);
	free(C);
			
	exit(0);
}
