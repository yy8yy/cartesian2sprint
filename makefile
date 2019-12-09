FC = ifort
LIB= -L/work1/soft/intel2015/composer_xe_2015.2.164/mkl/lib/intel64 -lmkl_rt -Wl,-rpath /work1/soft/intel2015/composer_xe_2015.2.164/mkl/lib/intel64
SRC = $(wildcard *)
OBJf90 = $(patsubst %.f90, %.o, $(filter %.f90, $(SRC)))
OBJmod = $(patsubst %.F90, %.m.o, $(filter %.F90, $(SRC)))
EXE = spint.exe

all: $(EXE)  

$(EXE): $(patsubst %.o, %.o, $(OBJmod) $(OBJf90))
	$(FC) $(LIB) \
	$+ -o $@ 
%.o : %.f90
	$(FC) -c $< -o $@
%.m.o : %.F90
	$(FC) -c $< -o $@
clean:
	rm -f *.o *.mod $(EXE) ; ctags -R
