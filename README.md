# TAXILA Installation on Clusters (Josephson and Bernal)
## How to install TAXILA from scratch

### You will need to install 
---
- **gcc-7.3.0**: Gnu Compile Collection is a compiler that support a large number of programming languages, hardware architectures and operating systems
- **valgrid-3.13.0**: programming tool for memory debugging, memory leak detection, and profiling.
- **Openmpi-3.1.2**: Message Passing Interface implementation used to parallelize calculations on clusters 
- **OpenBlas**: 
---
### Previous Installations 

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

### First Step

<pre>
Make a diretory to install Taxila: mkdir LBM_NEW
</pre>
