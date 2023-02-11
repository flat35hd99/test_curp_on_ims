#!/bin/bash
#PBS -l select=1:ncpus=40:mpiprocs=5:ompthreads=8:jobtype=small
#PBS -l walltime=00:59:00

prefix=$PREFIX_TEST_CURP

source $prefix/util/load_curp_ims

set -xeu

output=$prefix/conductivity/output/$PBS_JOBID
# faster directory
tmp=/ramd/users/$USER/$PBS_JOBID
mkdir -p $output
cd $tmp

echo "job start time" `date +'%Y%m%d %H:%M:%S'` >> $output/time.log

cp $0 $output/job.sh
cp $prefix/flux/output/flux.nc .

echo "copy end time " `date +'%Y%m%d %H:%M:%S'` >> $output/time.log

mpirun -np 5 \
  curp cal-tc --frame-range 1 100000 2 --average-shift 4 \
  --dt 0.0005 \
  -a acf.nc \
  -o $output/conductivity.dat \
  flux.nc > $output/conductivity.log

echo "cond end time " `date +'%Y%m%d %H:%M:%S'` >> $output/time.log

cp acf.nc $output

echo "copy end time " `date +'%Y%m%d %H:%M:%S'` >> $output/time.log

