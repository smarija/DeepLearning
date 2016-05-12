#!/bin/csh -f
#PBS -V
#PBS -S /bin/tcsh
#PBS -N Matlab-test
#PBS -l nodes=1:ppn=1
#PBS -l walltime=01:00:00
#PBS -l mem=20GB
#PBS -M ms10007@nyu.edu
#PBS -m abe

cd /scratch/ms10007/matlab-workdir
module load matlab/2014a
matlab < $SCRATCH/Datasets 

