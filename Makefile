
# payload info
PLD_BIN := tests/test-progs/progs/md5.rv
PLD_OPT := 100 hello

# output
OUTDIR := 
POSTFIX := 

ifeq ($(OUTDIR), )
OUTDIR_FINAL := --outdir m5out
else
OUTDIR_FINAL := --outdir $(OUTDIR)/m5out_$(BP_TYPE)_$(L1I)_$(L1D)_$(OUT_TIME)$(POSTFIX_F) 
endif

ifeq ($(POSTFIX), )
POSTFIX_F := 
else
POSTFIX_F := _$(POSTFIX)
endif

OUT_TIME := $(shell date +%y%m%d%H%M%S)

ifeq ($(DEBUG), 1)
DEBUG_OPTS = --debug-flags=O3PipeView --debug-file=trace.out
else
DEBUG_OPTS = 
endif

#{opt/fast/debug}
BUILD_TYPE:=debug

#  --cpu-type {AtomicSimpleCPU,BaseAtomicSimpleCPU,BaseMinorCPU,BaseNonCachingSimpleCPU,BaseO3CPU,BaseTimingSimpleCPU,DerivO3CPU,MinorCPU,NonCachingSimpleCPU,O3CPU,RiscvAtomicSimpleCPU,RiscvMinorCPU,RiscvNonCachingSimpleCPU,RiscvO3CPU,RiscvTimingSimpleCPU,TimingSimpleCPU,TraceCPU}
#  --bp-type {BiModeBP,LTAGE,LocalBP,MultiperspectivePerceptron64KB,MultiperspectivePerceptron8KB,MultiperspectivePerceptronTAGE64KB,MultiperspectivePerceptronTAGE8KB,TAGE,TAGE_SC_L_64KB,TAGE_SC_L_8KB,TournamentBP}

CPU_TYPE := DerivO3CPU
BP_TYPE := BiModeBP
L1D := 4096
L1I := 4096
CACHELINE := 64

#OUTDIR := m5out_$(CPU_TYPE)_$(BP_TYPE)_$(L1I)_$(L1D)_$(shell date +%N)

testargs:
	@echo ./build/RISCV/gem5.$(BUILD_TYPE)  $(OUTDIR_FINAL) configs/example/se_bp.py -c $(PLD_BIN) -o '$(PLD_OPT)' \
		--cpu-type $(CPU_TYPE) \
		--caches --l1d_size $(L1D) --l1i_size $(L1I) --cacheline_size $(CACHELINE) \
		--bp-type $(BP_TYPE)
	echo $(DEBUG_OPTS)

ooo:
	./build/RISCV/gem5.$(BUILD_TYPE) $(DEBUG_OPTS)  $(OUTDIR_FINAL)_o3 configs/example/se_bp.py -c $(PLD_BIN) -o '$(PLD_OPT)' \
		--cpu-type $(CPU_TYPE) \
		--caches --l1d_size $(L1D) --l1i_size $(L1I) --cacheline_size $(CACHELINE) \
		--bp-type $(BP_TYPE)

m0:
	./build/RISCV/gem5.$(BUILD_TYPE) $(DEBUG_OPTS)  $(OUTDIR_FINAL)_m0 configs/example/se_bp.py -c $(PLD_BIN) -o '$(PLD_OPT)' \
		--cpu-type DerivMODEL0CPU \
		--caches --l1d_size $(L1D) --l1i_size $(L1I) --cacheline_size $(CACHELINE) \
		--bp-type $(BP_TYPE)

timing_simple:
	./build/RISCV/gem5.$(BUILD_TYPE) $(OUTDIR_FINAL)_ts configs/example/se_bp.py -c $(PLD_BIN) -o '$(PLD_OPT)' \
		--cpu-type TimingSimpleCPU \
		--caches --l1d_size $(L1D) --l1i_size $(L1I) --cacheline_size $(CACHELINE) \
		--bp-type $(BP_TYPE)


pipeview:
	python3 util/o3-pipeview.py -c 500 -o pipeview.out --color out/o3_vis/trace.out
	less -r pipeview.out

list:
	@echo '######################################################################################'
	./build/RISCV/gem5.$(BUILD_TYPE) configs/example/se_bp.py --list-bp-types
	@echo '######################################################################################'
	./build/RISCV/gem5.$(BUILD_TYPE) configs/example/se_bp.py --list-indirect-bp-types
	@echo '######################################################################################'
	./build/RISCV/gem5.$(BUILD_TYPE) configs/example/se_bp.py --list-cpu-types

# debug or opt
TARGET_PLAT:=riscv

UPPER := $(shell echo $(TARGET_PLAT) | tr a-z A-Z)

build:
	python3 `which scons` -j 32 build/$(UPPER)/gem5.$(BUILD_TYPE)


#CPU=$(shell expr \(`cat /proc/cpuinfo | grep 'core id'|tail -n 1| awk '{print $4}'` + 1\) / 2 )
#CPU:=$(shell cat /proc/cpuinfo | grep 'core id'| tail -n 1 )

help:
	@echo "TARGET_PLAT = $(TARGET_PLAT)"
	@echo "BUILD_TYPE= $(BUILD_TYPE)"
	@echo "PLD_BIN= $(PLD_BIN)"
	@echo "Targets: ooo/timing_simple/pipeview/build"


.PHONY: build help
