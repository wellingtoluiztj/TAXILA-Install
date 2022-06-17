!!! ====================================================================
!!!  Fortran-90-file
!!!     author:          Ethan T. Coon
!!!     filename:        initialize_walls.F90
!!!     version:         
!!!     created:         14 January 2011
!!!       on:            17:26:22 MST
!!!     last modified:   08 August 2011
!!!       at:            15:41:04 MDT
!!!     URL:             http://www.ldeo.columbia.edu/~ecoon/
!!!     email:           ecoon _at_ lanl.gov
!!!  
!!! ====================================================================
#define PETSC_USE_FORTRAN_MODULES 1
#include "finclude/petscsysdef.h"
#include "finclude/petscvecdef.h"
#include "finclude/petscdmdef.h"

  subroutine initialize_walls(walls, info, options)
    use petsc
    use LBM_Options_module
    use LBM_Info_module
    implicit none

#include "lbm_definitions.h"
!   input variables
    type(info_type) info
    type(options_type) options
    PetscScalar,dimension(info%rgxs:info%rgxe,info%rgys:info%rgye):: walls
    PetscScalar,dimension(1:info%NX,1:info%NY):: works
    PetscInt i , j , ver , u , v
    
    WRITE(*,*)'ENTRADA a: walls'

    works(:,:) = 0

    OPEN(007, FILE = 'obst-wall.d90' , ACTION = 'READ')
    ver = 0
    DO WHILE (ver >= 0)
       READ(007 , * , IOSTAT = ver) u , v 
       IF (ver == 0) THEN
          works(u,v) = 1
       END IF
    END DO
    CLOSE(007)

    walls(:,:) = 0

    DO i = info%xs , info%xe
       DO j = info%ys , info%ye
          DO u = 1 , info%NX , 1
             DO v = 1 , info%NY , 1 
                IF ((i == u).AND.(j == v).AND.(works(u,v) /= 0)) THEN
                   walls(i,j) = 1
                END IF
             END DO
          END DO
       END DO
    END DO

    WRITE(*,*)'SALIDA de: walls'

    return
  end subroutine initialize_walls
