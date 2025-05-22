#!/bin/bash
clang-format -i main.c
clang-tidy -extra-arg=-std=gnu23 main.c

