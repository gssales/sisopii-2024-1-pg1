CXX=g++
CXXFLAGS=-std=c++23 -Wall -Wextra -g
LIB=libmutex.so
BIN=race_condition

default: libmutex.so main.cpp
	$(CXX) $(CXXFLAGS) -o $(BIN) main.cpp -L. -lmutex

libmutex.so: mutex.o
	$(CXX) $(CXXFLAGS) -shared -o $(LIB) mutex.o

mutex.o: libmutex/mutex.cpp
	$(CXX) $(CXXFLAGS) -fpic -shared -c libmutex/mutex.cpp

clean:
	rm -f *.o *.so $(BIN)

run: $(BIN)
	LD_LIBRARY_PATH=. ./race_condition