#!/bin/bash

echo "N=1000" >> local_1000.txt
for((T=1;T<5;T=T+1))
do
	export OMP_NUM_THREADS=$T
	./pmm 1000 >> local_1000.txt
done

echo "N=1100" >> local_1100.txt
for((T=1;T<5;T=T+1))
do
	export OMP_NUM_THREADS=$T
	./pmm 1100 >> local_1100.txt
done
