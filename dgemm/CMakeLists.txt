cmake_minimum_required(VERSION 3.9)
project(lr1 C)

set(CMAKE_C_STANDARD 11)

add_executable(lr1 dgemm.c hpctimer.h hpctimer.c)