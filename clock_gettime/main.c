#include <stdint.h>
#include <stdio.h>
#include <time.h>

#define NSEC_IN_SEC 100000000

uint64_t gettimeLatencyNs() {
    struct timespec ts1;
    struct timespec ts2;
    clock_gettime(CLOCK_MONOTONIC, &ts1);
    clock_gettime(CLOCK_MONOTONIC, &ts2);
    return ((ts2.tv_sec - ts1.tv_sec) * NSEC_IN_SEC + ts2.tv_nsec -
            ts1.tv_nsec);
}

int main(void) {
    int runs = 1000;
    uint64_t sum = 0;
    for (int i = 0; i < runs; i++) {
        uint64_t delta = gettimeLatencyNs();
        printf("%lu ", delta);
        sum += delta;
    }
    printf("\n\nSum: %lu, Avg: %lu\n", sum, sum / runs);
}