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

	double** M = (double**) malloc(N*sizeof(double*));
	for(int i = 0; i<N; ++i)
		M[i] = (double*) malloc(N*sizeof(double));

	double* V = (double*) malloc(N*sizeof(double));

	double* R = (double*) malloc(N*sizeof(double));

	if(M == NULL || V == NULL || R == NULL){
		printf("No se ha podido reservar memoria\n");
		exit(-1);
	}

	//Inicializar elementos:

	#pragma omp parallel
	{
		#pragma omp for
		for(int i = 0; i<N; ++i)
			for(int j = 0; j<N; ++j)				
				M[i][j] = i+j;

		#pragma omp for
		for(int i = 0; i<N; ++i){
			V[i] = N*0.1 + i*0.1;
			R[i] = 0;
		}
	}
		
	//Realizar R = M * V y medir tiempo:
		
	clock_gettime(CLOCK_REALTIME, &cgt1);
		
	for(int i = 0; i<N; ++i)
		#pragma omp parallel for		
		for(int j = 0; j<N; ++j)
			#pragma omp atomic
			R[i] += (M[i][j] * V[j]);
		
	clock_gettime(CLOCK_REALTIME, &cgt2);
	ncgt= (double) (cgt2.tv_sec - cgt1.tv_sec) + (double) ((cgt2.tv_nsec - cgt1.tv_nsec)/(1.e+9));

	//Imprimir resultados:
	if(N<12){
		printf("Tiempo transcurrido (seg): %11.9f \n\nMatriz generada:\n", ncgt);
		for(int i = 0; i<N; ++i)
			printf("[%.0f]", M[0][i]);
		printf("...");
		for(int i = 0; i<N; ++i)
			printf("[%.0f]", M[N-1][i]);

		printf("\n\nVector generado:\n");
		for(int i = 0; i<N; ++i)
			printf("[%.1f]", V[i]);
		
		printf("\n\nResultado:\n");
		for(int i = 0; i<N; ++i)
			printf("[%.1f]", R[i]);			

		printf("\n\n");
	}
	else
		printf("Tiempo(seg.): %11.9f \nTamaño: %u \nM[0][-]*V=R[0] = %.1f \nM[%d][-]*V=R[%d] = %.1f \n",ncgt,N, R[0], N-1, N-1, R[N-1]);



	//Liberar memoria:
	for(int i = 0; i<N; ++i)
		free(M[i]);

	free(M);
	free(V);
	free(R);
			
	exit(0);
}
