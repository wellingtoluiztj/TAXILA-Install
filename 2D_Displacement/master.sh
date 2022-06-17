
gfortran -Wall obst-wall.f90
./a.out

make
mpirun -np 5 ./runSimulation input_data
python conv_bin-gnu.py

rm *.o
rm runSimulation
rm bin_output/*
rm a.out

gnuplot anim-gnu.plt
gwenview anim-gnu.gif

