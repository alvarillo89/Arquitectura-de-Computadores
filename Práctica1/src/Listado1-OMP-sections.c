#include <stdlib.h> // biblioteca con funciones atoi(), malloc() y free()
#include <stdio.h>  // biblioteca donde se encuentra la función printf()
#include <omp.h>

int main ( int argc,  char ** argv){
	int i;
	double cgt1,cgt2;
	double ncgt; //para tiempo de ejecución

	//Leer argumento de entrada (nº de componentes del vector)
	if(argc<2){
		printf("Faltan nº componentes del vector\n");
		exit(-1);
	}

	unsigned int N = atoi(argv[1]); // Máximo N = 2*32-1 (sizeof(unsigned int) = 4B)

	double *v1, *v2, *v3;
	v1 = (double*) malloc(N*sizeof(double));
	v2 = (double*) malloc(N*sizeof(double));
	v3 = (double*) malloc(N*sizeof(double));
	if( (v1 == NULL) || (v1 == NULL) || (v1 == NULL)){
		printf("Error en la reserva del espacio para los vecores\n");
		exit(-2);
	}

	int num_it = N / 4; //Repartir las iteraciones entre las cuatro secciones.

	#pragma omp parallel
	{
		// Inicializar vectores
		#pragma omp sections private(i)
		{
			#pragma omp section
			for(i = 0; i < num_it; i++){
				v1[i] = N*0.1 + i*0.1;
				v2[i] = N*0.1 - i*0.1;
			}	
			#pragma omp section
			for(i = num_it; i < num_it*2; i++){
				v1[i] = N*0.1 + i*0.1;
				v2[i] = N*0.1 - i*0.1;
			}
			#pragma omp section
			for(i = num_it*2; i < num_it*3; i++){
				v1[i] = N*0.1 + i*0.1;
				v2[i] = N*0.1 - i*0.1;
			}
			#pragma omp section
			for(i = num_it*3; i < N; i++){
				v1[i] = N*0.1 + i*0.1;
				v2[i] = N*0.1 - i*0.1;
			}
		}
		
		#pragma omp single
		{ cgt1 = omp_get_wtime();}

		// Calcular la suma de vectores
		#pragma omp sections private(i)
		{
			#pragma omp section
			for(i = 0; i < num_it; i++){
				v3[i] = v1[i] + v2[i];
			}
			#pragma omp section
			for(i = num_it; i < num_it*2; i++){
				v3[i] = v1[i] + v2[i];
			}
			#pragma omp section
			for(i = num_it*2; i < num_it*3; i++){
				v3[i] = v1[i] + v2[i];
			}
			#pragma omp section
			for(i = num_it*3; i < N; i++){
				v3[i] = v1[i] + v2[i];
			}
		}

		#pragma omp single
		{cgt2 = omp_get_wtime();}

	}
	ncgt = cgt2 - cgt1;

	// Imprimir
	printf("Tiempo(seg.):%11.9f\t / Tamaño Vectores:%u\t/ V1[0]+V2[0]=V3[0](%8.6f+%8.6f=%8.6f) / / V1[%d]+V2[%d]=V3[%d](%8.6f+%8.6f=%8.6f) /\n",ncgt,N,v1[0],v2[0],v3[0],N-1,N-1,N-1,v1[N-1],v2[N-1],v3[N-1]);

	free(v1); // libera el espacio reservado para v1
	free(v2); // libera el espacio reservado para v2
	free(v3); // libera el espacio reservado para v3

	return 0;
}
