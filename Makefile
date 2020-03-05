CXX ?= g++

BTROOT ?= /n/data1/hms/dbmi/park/jluquette/meerkat_bwa_mem/Meerkat/src/mybamtools
BTINC = $(BTROOT)/src
BTLIB = $(BTROOT)/lib

INSTALL_DIR ?= /usr
# Use this for profiling with gprof
#PROFILE =  -pg

# Use this for debugging
#CXXFLAGS = -Wall -c -g $(PROFILE) -I $(BTINC)
CXXFLAGS = -c -O3 -I $(BTINC)

all: dre

install : all
	mv ./dre $(INSTALL_DIR)/

dre: dre.o Group.o gzstream.o
	$(CXX) -L $(BTLIB) $(PROFILE) -o dre dre.o gzstream.o Group.o -lbamtools -lbamtools-utils

dre.o: dre.cpp
	$(CXX) $(CXXFLAGS) dre.cpp
Group.o: Group.cpp Group.h PCRDups.h
	$(CXX) $(CXXFLAGS) Group.cpp
gzstream.o: gzstream.cpp gzstream.h
	$(CXX) $(CXXFLAGS) gzstream.cpp

clean:
	rm *.o dre
