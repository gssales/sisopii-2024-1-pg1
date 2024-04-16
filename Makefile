CXX=g++
CXXFLAGS=-std=c++23 -Wall -Wextra -g
LIB=liblamport_mutex.so

CC=gcc
CFLAGS=-Wall -Wextra -g -lpthread
BIN=race_condition

SRC=$(wildcard *.cpp)
OBJ=$(SRC:%.cpp=%.o)

default: lib main.c
	$(CC) $(CFLAGS) -L . -o $(BIN) main.c

lib: liblamport_mutex/liblamport_mutex.cpp
	$(CXX) $(CXXFLAGS) -fPIC -shared -o $(LIB) $^

no-lib: main.c
	$(CC) $(CFLAGS) -o $(BIN) main.c

clean:
	rm -f *.o *.so $(BIN)

