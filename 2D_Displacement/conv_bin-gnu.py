import sys
import os

path_LBM = repr(os.popen('echo $LBM_DIR').readline())
path_LBM = str(path_LBM[1:len(path_LBM)-3]) + '/src/testing'
sys.path.append(path_LBM)

import solution_reader3

sr = solution_reader3.SolutionReader('input_data')

for base, dirs, files in os.walk('bin_output'):
	print ''

for Num in range((len(files)-2)/8):
	File_den = 'rho'+str(Num).rjust(3,'0')+'.dat'
	File_vel =   'u'+str(Num).rjust(3,'0')+'.dat'
	File_pre = 'prs'+str(Num).rjust(3,'0')+'.dat'
	File_wal =                  'walls000'+'.dat'
	File_out = 'RES-'+str(Num).rjust(3,'0')+'.dat'
	den = sr.loadVec(File_den)
	vel = sr.loadVec(File_vel)
	pre = sr.loadVec(File_pre)
	wal = sr.loadVec(File_wal)
	D = wal.shape
	zoo = open(File_out,'w')
	zoo.write('# Sytem: pos_x , pos_y , den_1 , den_2 , vel_x , vel_y , pressure , walls')
	zoo.write('\n')
	for i in range(D[0]):
        	for j in range(D[1]):
                	zoo.write(str(i+1))
                	zoo.write('  ')
                	zoo.write(str(j+1))
                	zoo.write('  ')
                	zoo.write('{0:.9f}'.format(den[i][j][0]))
                	zoo.write('  ')
                	zoo.write('{0:.9f}'.format(den[i][j][1]))
			zoo.write('  ')
                        zoo.write('{0:.9f}'.format(vel[i][j][0]))
			zoo.write('  ')
                        zoo.write('{0:.9f}'.format(vel[i][j][1]))
			zoo.write('  ')
                        zoo.write('{0:.9f}'.format(pre[i][j][0]))
			zoo.write('  ')
                        zoo.write('{0:1d}'.format(int(wal[i][j][0])))
               	 	zoo.write('\n')
        	zoo.write('\n')
	zoo.close()

os.system('mkdir gnu_output')
os.system('mv RES-*.dat gnu_output')
