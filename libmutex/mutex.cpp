#include <pthread.h>
#include <iostream>

#include "mutex.h"

#define MEMORY_FENCE __sync_synchronize()

bool choosing [MAX_THREADS];
int ticket [MAX_THREADS];

void lamport_mutex_init () {
	for (int i = 0; i < MAX_THREADS; i++) {
		choosing[i] = false;
		ticket[i] = 0;
	}
}

int max(int arr [MAX_THREADS]) {
	int max = arr[0];
	for (int i = 0; i < MAX_THREADS; i++)
		max = arr[i] > max ? arr[i] : max;
	return max;
}

void lamport_mutex_lock (int thread_id) {
	int i = thread_id-1;
	MEMORY_FENCE;
	choosing[i] = true;
	MEMORY_FENCE;
	ticket[i] = max(ticket) + 1;
	MEMORY_FENCE;
	choosing[i] = false;
	MEMORY_FENCE;
	for (int j = 0; j < MAX_THREADS; j++) {
		MEMORY_FENCE;
		while (choosing[j]) {sched_yield();};
		MEMORY_FENCE;
		while (ticket[j] != 0 && (
			ticket[j] < ticket[i] ||
			(ticket[j] == ticket[i] && j < i)
		)) {sched_yield();};
	}
}

void lamport_mutex_unlock (int thread_id) {
	int i = thread_id-1;
	ticket[i] = 0;
}