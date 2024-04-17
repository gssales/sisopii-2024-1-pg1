CXX=g++
CXXFLAGS=-std=c++23 -Wall -Wextra -g
LIB=libmutex.so

CC=gcc
CFLAGS=-Wall -Wextra -g -lpthread
BIN=race_condition

default: libmutex.so main.c
	$(CC) $(CFLAGS) -o $(BIN) main.c -L. -lmutex

libmutex.so: mutex.o
	$(CXX) $(CXXFLAGS) -shared -o $(LIB) mutex.o

mutex.o: libmutex/mutex.cpp
	$(CXX) $(CXXFLAGS) -fpic -shared -c libmutex/mutex.cpp

clean:
	rm -f *.o *.so $(BIN)

