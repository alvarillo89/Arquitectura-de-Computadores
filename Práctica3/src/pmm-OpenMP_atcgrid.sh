#!/bin/bash

#PBS -N pmm-OpenMP
#PBS -q ac

#Alguna información:
echo "Id. usuario del trabajo: $PBS_O_LOGNAME"
echo "Id. del trabajo: $PBS_JOBID"
echo "Nombre del trabajo especificado por usuario: $PBS_JOBNAME"
echo "Nodo que ejecuta qsub: $PBS_O_HOST"
echo "Directorio en el que se ha ejecutado qsub: $PBS_O_WORKDIR"
echo "Cola: $PBS_QUEUE"

echo "N=1000"
for((T=1;T<13;T=T+1))
do
	export OMP_NUM_THREADS=$T
	$PBS_O_WORKDIR/pmm 1000
done

echo "N=1100"
for((T=1;T<13;T=T+1))
do
	export OMP_NUM_THREADS=$T
	$PBS_O_WORKDIR/pmm 1100
done
