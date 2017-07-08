#!/bin/bash

#PBS -N pmtv-OpenMP
#PBS -q ac

#Alguna información:
echo "Id. usuario del trabajo: $PBS_O_LOGNAME"
echo "Id. del trabajo: $PBS_JOBID"
echo "Nombre del trabajo especificado por usuario: $PBS_JOBNAME"
echo "Nodo que ejecuta qsub: $PBS_O_HOST"
echo "Directorio en el que se ha ejecutado qsub: $PBS_O_WORKDIR"
echo "Cola: $PBS_QUEUE"

#Asegurarnos de que el número de threads concide con el número de cores:
export OMP_NUM_THREADS=12

#STATIC
	#Chunk = default
	export OMP_SCHEDULE="static"
	$PBS_O_WORKDIR/pmtv 15360
	#Chunk = 1
	export OMP_SCHEDULE="static,1"
	$PBS_O_WORKDIR/pmtv 15360
	#Chunk = 64
	export OMP_SCHEDULE="static,64"
	$PBS_O_WORKDIR/pmtv 15360
#DYNAMIC
	#Chunk = default
	export OMP_SCHEDULE="dynamic"
	$PBS_O_WORKDIR/pmtv 15360
	#Chunk = 1
	export OMP_SCHEDULE="dynamic,1"
	$PBS_O_WORKDIR/pmtv 15360
	#Chunk = 64
	export OMP_SCHEDULE="dynamic,64"
	$PBS_O_WORKDIR/pmtv 15360
#GUIDED
	#Chunk = default
	export OMP_SCHEDULE="guided"
	$PBS_O_WORKDIR/pmtv 15360
	#Chunk = 1
	export OMP_SCHEDULE="guided,1"
	$PBS_O_WORKDIR/pmtv 15360
	#Chunk = 64
	export OMP_SCHEDULE="guided,64"
	$PBS_O_WORKDIR/pmtv 15360
