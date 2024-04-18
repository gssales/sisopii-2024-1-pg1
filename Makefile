CXX=g++
CXXFLAGS=-std=c++23 -Wall -Wextra -g
LIB=libmutex.so
BIN=race_condition

default: libmutex.so main.cpp
	$(CXX) $(CXXFLAGS) -o $(BIN) main.cpp -L. -lmutex

libmutex.so: libmutex/mutex.cpp
	$(CXX) $(CXXFLAGS) -fpic -shared -o $(LIB) libmutex/mutex.cpp

clean:
	rm -f *.o *.so $(BIN) thread_mutex

thread_mutex: thread_mutex.c
	gcc -o thread_mutex thread_mutex.c -lpthread

run: $(BIN)
	LD_LIBRARY_PATH=. ./race_condition

test: thread_mutex
	time -p ./thread_mutex |& sed -Enr 's/real (.*)/\1/p'