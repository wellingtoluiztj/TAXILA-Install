#!/bin/bash 

# Change this module
#_______________________________________________________#
#SBATCH --job-name "teste"
#SBATCH --nodes 1
#SBATCH --ntasks 10
#SBATCH --partition nanopetro-intel                   ## short, medium, long, verylon, nanopetro, nanopetro-intel 
#SBATCH --output slurm.log
#SBATCH --error slurm.err
#_______________________________________________________#


# Optional configurations
#_______________________________________________________#
##SBATCH --cpus-per-task 1
##SBATCH --ntasks-per-node 64
##SBATCH --mem 5000               ## MB
##SBATCH --mem-per-cpu 4096      ## MB
##SBATCH --time 165:00:00          ## min, min:sec, h:min:sec, d-h:min:sec
##SBATCH --mail-type END          ## BEGIN, END and FAIL
##SBATCH --mail-user user@gmail.com
##SBATCH --nodelist=n030 
##SBATCH --exclude=n[16,11]
##SBATCH --contiguous
##SBATCH --exclusive
##SBATCH --dependency=afterany:job_id[:jobid...]
#_________________________________________________________#


#cd ${SCRATCH}
cd $SLURM_SUBMIT_DIR

#########################################################################
# Setup environment.                                                    #
#########################################################################

ulimit -s unlimited
ulimit -l unlimited

export OMP_NUM_THREADS=1

module load py-numpy-1.16.5-gcc-8.3.0-adpkgnr
module load python-2.7.16-gcc-8.3.0-df5cs35
module load gnuplot-5.2.5-gcc-8.3.0-ydd2jks

export PETSC_DIR=/scratch/wsantos/LBM_NEW/petsc-3.4.4
export LBM_DIR=/scratch/wsantos/LBM_NEW/taxila-font-Mar14
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/scratch/wsantos/LBM_NEW/lapack-3.8.0:/usr/lib/x86_64-linux-gnu:/lib/x86_64-linux-gnu:/lib64
export PATH=$PATH:/scratch/wsantos/LBM_NEW/openmpi-3.1.2/bin:/usr/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/scratch/wsantos/LBM_NEW/gcc-7.3.0/bin/lib/../lib64

rm -rf gnu_output 2>/dev/null
#rm -rf bin_output 2>/dev/null
#mkdir bin_output

#module load  gcc-9.2.0-gcc-8.3.0-p7qd55y
#gfortran  obst-wall.f90
#./a.out
# make
# ldd ./runSimulation 

/scratch/wsantos/LBM_NEW/openmpi-3.1.2/bin/mpirun -np ${SLURM_NTASKS} ./runSimulation input_data > follow.out 

python conv_bin-gnu.py

#gnuplot anim_gnu-gif.plt 

rm *.o
rm runSimulation
rm bin_output/*
rm slurm.err  
rm slurm.log
rm follow.out

date
 
