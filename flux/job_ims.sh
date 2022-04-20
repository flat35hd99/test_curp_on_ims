#!/bin/bash
#PBS -l select=1:ncpus=40:mpiprocs=40:ompthreads=1:jobtype=small
#PBS -l walltime=48:00:00

prefix=$PREFIX_TEST_CURP

source $prefix/util/load_curp_ims

set -xeu

output=$prefix/flux/output/$PBS_JOBID
# faster directory
tmp=/ramd/users/$USER/$PBS_JOBID
# tmp=/work/users/$USER/$PBS_JOBID
mkdir -p $output
# mkdir -p $tmp
cd $tmp

echo "job start time" `date +'%Y%m%d %H:%M:%S'` >> $output/time.log

cp $0 $output
cp $prefix/config/system.dry.prmtop .
cp $prefix/config/atom_group.dat .
ln -s $prefix/config/md.crd.nc .
ln -s $prefix/config/md.vel.nc .
cp $prefix/config/flux.cfg .
cp $prefix/config/group_pair.dat .

echo "copy end time " `date +'%Y%m%d %H:%M:%S'` >> $output/time.log

mpirun -np 40 curp compute flux.cfg > $output/flux.log

echo "flux end time " `date +'%Y%m%d %H:%M:%S'` >> $output/time.log

cp flux_grp.nc $output/flux.nc

echo "copy end time " `date +'%Y%m%d %H:%M:%S'` >> $output/time.log

