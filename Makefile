CXX=g++
CXXFLAGS=-std=c++23 -Wall -Wextra -g
BIN=race_condition

SRC=$(wildcard *.cpp)
OBJ=$(SRC:%.cpp=%.o)

default: bin/lib_lamport_mutex.so src/main.c
	gcc -Wall -Wextra -g -L bin -lpthread -o race_condition src/main.c

lib: libs/lamport_mutex/src/main.cpp
	$(CXX) $(CXXFLAGS) -fPIC -shared -o bin/lib_lamport_mutex.so $^

no-lib: src/main.c
	gcc -Wall -Wextra -g -lpthread -o race_condition src/main.c

%.o: %.c
	$(CXX) $@ -c $<

clean:
	rm -f **/*.o **/*.so $(BIN)

