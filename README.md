# TAXILA Installation on Clusters (Josephson and Bernal)

## You will need to install 
---
- **gcc-7.3.0**: Gnu Compile Collection is a compiler that support a large number of programming languages, hardware architectures and operating systems
- **valgrid-3.13.0**: programming tool for memory debugging, memory leak detection, and profiling.
- **Openmpi-3.1.2**: Message Passing Interface implementation used to parallelize calculations on clusters 
- **OpenBlas**: 
---



## Previous Installations 
---
Some dependences required before start to install TAXILA on debian

<pre>
sudo apt-get update
sudo apt-install git
sudo apt-install build-essential
sudo apt-install -y fftw3
sudo apt-install libblas-dev
sudo apt-install liblapack-dev
sudo apt-install textinfo
</pre>
---
## Main Directory
---
Make a diretory to install Taxila: 
<pre>
mkdir LBM_NEW
</pre>
---
## Install gcc-7.3.0
---

*1.* Download gcc-7.3.0
<pre>
wget https://ftp.gnu.org/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.gz
</pre>
*2.* Unpack gcc
<pre>
tar -xvf gcc-7.3.0.tar.gz
</pre>
*3.* Make a *bin* diretory into the folder gcc-7.3.0
<pre>
mkdir bin
</pre>
*4.* Clear loaded libraries
<pre>
module purge
</pre>
*5.* Download the prerequisites
<pre>
./contrib/download_prerequisites
</pre>
*6.* Configure the build (all the times you find name wsantos, replace by your diretory name on scratch)
<pre>
./configure --enable-languages=c,c++,fortran,objc,obj-c++ --prefix=/scratch/wsantos/LBM_NEW/gcc-7.3.0/bin --disable-multilib
</pre>
*7.* Compile using the maximum number of processors (64 for AMD nodes and 28 dor Intel nodes)
<pre>
make -j64
</pre>
*8.* Install
<pre>
make install
</pre>
*9.* Go to file .bashrc in your home
<pre>
cd; vim .bashrc
</pre>
*10.* Past the following lines
<pre>
export PATHLD_LIBRARY_PATH=$LD_LIBRARY_PATH:/scratch/wsantos/LBM_NEW/gcc-7.3.0/bin/lib64
export PATH=$PATH:/scratch/wsantos/LBM_NEW/gcc-7.3.0/bin/lib64
</pre>
*11.* Update bashrc file
<pre>
source .bashrc
</pre>
---
