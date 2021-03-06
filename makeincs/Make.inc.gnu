## ##############################################################################################
##
## Copyright 2012 CNRS, INPT
##  
## This file is part of qr_mumps.
##  
## qr_mumps is free software: you can redistribute it and/or modify
## it under the terms of the GNU Lesser General Public License as 
## published by the Free Software Foundation, either version 3 of 
## the License, or (at your option) any later version.
##  
## qr_mumps is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU Lesser General Public License for more details.
##  
## You can find a copy of the GNU Lesser General Public License
## in the qr_mumps/doc directory.
##
## ##############################################################################################


## -*- Makefile -*-
##
## $Date: 2016-06-30 12:48:57 +0200 (Thu, 30 Jun 2016) $
## $Author: abuttari $
## $Version: 2.0 $
## $Revision: 2248 $
##


# write here the path to the qr_mumps top directory
topdir=$(HOME)/path/to/here

LINK    = $(FC)

# compilers
CC      = gcc
FC      = gfortran

# compiler options
FCFLAGS = -O3
CFLAGS  = -O3

# link options
LDFLAGS  = $(FCFLAGS) 

INCLUDES = -I.  -I../include
CINCLUDES= $(IMETIS) $(ICOLAMD) $(ISTARPU)
FINCLUDES= $(ISCOTCH)

# this variable is for compilers that need a prefix before the -D flag (i.e., xlf)
DEFINE_PREPEND = 

# you can specify here what ordering tools you have and if you want or not StarPU parallelism
CDEFS = -Dhave_metis -Dhave_scotch -Dhave_colamd -Dhave_starpu 
FDEFS = -Dhave_metis -Dhave_scotch -Dhave_colamd -Dhave_starpu 

AR = ar -cr
RANLIB = ranlib

# your BLAS and LAPACK libraries
LBLAS    = -L/path/to/blas -lblas
LLAPACK  = -L/path/to/lapack -llapack

# your StarPU library
# LSTARPU = -L/path/to/starpu -lstarpu
# ISTARPU = -I/path/to/starpu/include

# your COLAMD library
# LCOLAMD  = -L/path/to/colamd -lcolamd
# ICOLAMD	 = -I/path/to/colamd/include

# your METIS library
# LMETIS   = -L/path/to/metis -lmetis
# IMETIS   = -I/path/to/metis/include

# your scotch library
# LSCOTCH  = -L/path/to/scotch/lib -lscotch -lscotcherr
# ISCOTCH  = -I/path/to/scotch/include

LIBS =	$(LLAPACK) $(LBLAS) \
        $(LCOLAMD) $(LMETIS) \
	$(LSCOTCH) $(LSTARPU) -lpthread

%.mod: %.o
	@true

%.o: %.c
	$(CC)  $(CFLAGS)  $(CINCLUDES) $(INCLUDES) $(CDEFS) $(PREC) -c $<
%.o: %.f
	$(FC)  $(FCFLAGS) $(FINCLUDES) $(INCLUDES) $(FDEFS) $(DEFINE_PREPEND)$(PREC) -c $<
%.o: %.f90				       
	$(FC)  $(FCFLAGS) $(FINCLUDES) $(INCLUDES) $(FDEFS) $(DEFINE_PREPEND)$(PREC) -c $<
%.o: %.F
	$(FC)  $(FCFLAGS) $(FINCLUDES) $(INCLUDES) $(FDEFS) $(DEFINE_PREPEND)$(PREC) -c $<
%.o: %.F90
	$(FC)  $(FCFLAGS) $(FINCLUDES) $(INCLUDES) $(FDEFS) $(DEFINE_PREPEND)$(PREC) -c $<
