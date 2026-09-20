CC = mpicc
CFLAGS = -Wall -O2

PROGRAMS = sum_scatter sum_gather sum_reduce sum_allreduce sum_scan

all: $(PROGRAMS)

sum_scatter: Exercise02/sum_scatter.c
    $(CC) $(CFLAGS) -o $@ $<

sum_gather: Exercise03/sum_gather.c
    $(CC) $(CFLAGS) -o $@ $<

sum_reduce: Exercise04/sum_reduce.c
    $(CC) $(CFLAGS) -o $@ $<

sum_allreduce: Exercise05/sum_allreduce.c
    $(CC) $(CFLAGS) -o $@ $<

sum_scan: Exercise06/sum_scan.c
    $(CC) $(CFLAGS) -o $@ $<

run: all
    mpirun -np 4 ./sum_scatter
    mpirun -np 4 ./sum_gather
    mpirun -np 4 ./sum_reduce
    mpirun -np 4 ./sum_allreduce
    mpirun -np 4 ./sum_scan

clean:
    del /Q sum_scatter.exe sum_gather.exe sum_reduce.exe sum_allreduce.exe sum_scan.exe 2>NUL || exit 0