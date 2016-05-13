#!/bin/csh -f
#PBS -V
#PBS -S /bin/tcsh
#PBS -N Matlab-test
#PBS -l nodes=1:ppn=1
#PBS -l walltime=01:00:00
#PBS -l mem=20GB
#PBS -M ms10007@nyu.edu
#PBS -m e

cd /home/ms10007/DeepLearning/liblinear-2.1/matlab
/share/apps/matlab/2015b/bin/matlab < untitled4.m
