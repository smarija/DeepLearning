#!/bin/csh -f
#PBS -V
#PBS -S /bin/tcsh
#PBS -N Matlab-test
#PBS -l nodes=1:ppn=1
#PBS -l walltime=05:00:00
#PBS -l mem=30GB
#PBS -M ms10007@nyu.edu
#PBS -m e

cd /home/ms10007/DeepLearning/liblinear-2.1/matlab
/share/apps/matlab/2015b/bin/matlab < untitled8.m
