
SRCS := $(wildcard *.c)

TARGETS := $(patsubst %.c, %.rv, $(SRCS))

all: $(TARGETS) Makefile
	@echo $(SRCS)
	@echo $(TARGETS)
#	riscv64-linux-gnu-gcc md5.c -o md5 --static
#	riscv64-linux-gnu-gcc fibo.c -o fibo --static
#	riscv64-linux-gnu-gcc hello.c -o hello --static

%.rv: %.c
	riscv64-linux-gnu-gcc $< -o $@ --static -g

Makefile:
	touch Makefile

clean:
	rm $(TARGETS)

