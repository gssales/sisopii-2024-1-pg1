#ifndef _MUTEX_H
#define _MUTEX_H

#define MAX_THREADS 3

void lamport_mutex_init ();
void lamport_mutex_lock (int thread_id);
void lamport_mutex_unlock (int thread_id);

#endif // _MUTEX_H