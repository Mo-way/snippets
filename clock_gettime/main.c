#include <stdint.h>
#include <stdio.h>
#include <time.h>

#define NSEC 100000000

uint64_t getTimeLatencyNs() {
    struct timespec ts1;
    struct timespec ts2;
    clock_gettime(CLOCK_MONOTONIC_RAW, &ts1);
    clock_gettime(CLOCK_MONOTONIC_RAW, &ts2);
    return ((ts2.tv_sec - ts1.tv_sec) * NSEC + ts2.tv_nsec - ts1.tv_nsec);
}

int main(void) {
    uint64_t runs = 1000;
    uint64_t sum = 0;
    uint64_t max = 0;
    for (int i = 0; i < runs; i++) {
        uint64_t delta = getTimeLatencyNs();
        // printf("%lu ", delta);
        sum += delta;
        if (delta > max) {
            max = delta;
        }
    }
    printf("\n\nSum: %lu, Avg: %lu, Max: %lu\n", sum, sum / runs, max);
    return 0;
}