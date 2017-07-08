#include <stdio.h>
#include <stdlib.h>

#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_get_thread_num() 0
#endif

int main(int argc, char **argv){

	int i, n=200,chunk,a[n],suma=0, dv, ntv, m;
	omp_sched_t kind, knd;
	int modifier;
	
	if(argc < 7) {
		fprintf(stderr,"\nUso: <Iteraciones> <chunk> <dyn-var> <nthreads-var> <kind,modifier>\n");
		exit(-1);
	}

	n = atoi(argv[1]); if (n>200) n=200; chunk = atoi(argv[2]);
	dv = atoi(argv[3]);
	ntv = atoi(argv[4]);
	knd = atoi(argv[5]);
	m = atoi(argv[6]);

	printf("Valores antes de modificarlos:\n");
	omp_get_schedule(&kind, &modifier);
	printf("dyn-var=%d; nthreads-var=%d; run-sched-var=<%d,%d>;\n", omp_get_dynamic(), omp_get_max_threads(),kind, modifier);

	omp_set_dynamic(dv);
	omp_set_num_threads(ntv);
	omp_set_schedule(knd,m);

	printf("Valores después de modificarlos:\n");
	omp_get_schedule(&kind, &modifier);
	printf("dyn-var=%d; nthreads-var=%d; run-sched-var=<%d,%d>;\n", omp_get_dynamic(), omp_get_max_threads(),kind, modifier);

	for (i=0; i<n; i++) a[i] = i;

	#pragma omp parallel for firstprivate(suma) lastprivate(suma) schedule(dynamic,chunk)
	for (i=0; i<n; i++){ 
		suma = suma + a[i];
		printf(" thread %d suma a[%d]=%d suma=%d \n", omp_get_thread_num(),i,a[i],suma);
	}

	printf("Fuera de 'parallel for' suma=%d\n",suma);
}
