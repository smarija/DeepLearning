#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l walltime=01:00:00
#PBS -l mem=20GB
#PBS -N jobname
#PBS -M marija.stankova@nyu.edu
#PBS -j oe
 
module purge
module load matlab/2014a
RUNDIR=$SCRATCH/my_project/run-${PBS_JOBID/.*}
mkdir -p $RUNDIR
 
DATADIR=$SCRATCH/Datasets
cd $RUNDIR
stata -b do $DATADIR/data_0706.do
 
# leave a blank line at the end


