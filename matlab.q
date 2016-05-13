#!/bin/csh -f
#PBS -V
#PBS -S /bin/tcsh
#PBS -N Matlab-test
#PBS -l nodes=1:ppn=1
#PBS -l walltime=01:00:00
#PBS -l mem=20GB
#PBS -M ms10007@nyu.edu
#PBS -m abe

cd /home/ms10007/DeepLearning/
module load matlab/2015b
matlab < untitled4.m 

