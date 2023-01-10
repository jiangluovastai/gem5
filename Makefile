
# payload info
PLD_BIN := tests/test-progs/progs/md5.rv
PLD_OPT := 100 hello

# output
OUTDIR := 
POSTFIX := 

ifeq ($(OUTDIR), )
OUTDIR_FINAL := 
else
OUTDIR_FINAL := $(OUTDIR)/
endif

ifeq ($(POSTFIX), )
POSTFIX_F := 
else
POSTFIX_F := $(POSTFIX)/
endif

ifeq ($(DEBUG), 1)
DEBUG_OPTS = --debug-flags=O3PipeView --debug-file=trace.out
else
DEBUG_OPTS = 
endif

#  --cpu-type {AtomicSimpleCPU,BaseAtomicSimpleCPU,BaseMinorCPU,BaseNonCachingSimpleCPU,BaseO3CPU,BaseTimingSimpleCPU,DerivO3CPU,MinorCPU,NonCachingSimpleCPU,O3CPU,RiscvAtomicSimpleCPU,RiscvMinorCPU,RiscvNonCachingSimpleCPU,RiscvO3CPU,RiscvTimingSimpleCPU,TimingSimpleCPU,TraceCPU}
#  --bp-type {BiModeBP,LTAGE,LocalBP,MultiperspectivePerceptron64KB,MultiperspectivePerceptron8KB,MultiperspectivePerceptronTAGE64KB,MultiperspectivePerceptronTAGE8KB,TAGE,TAGE_SC_L_64KB,TAGE_SC_L_8KB,TournamentBP}

CPU_TYPE := DerivO3CPU
BP_TYPE := BiModeBP
L1D := 4096
L1I := 4096
CACHELINE := 64

#OUTDIR := m5out_$(CPU_TYPE)_$(BP_TYPE)_$(L1I)_$(L1D)_$(shell date +%N)

testargs:
	@echo ./build/RISCV/gem5.opt  --outdir $(OUTDIR_FINAL)/m5out_DerivO3CPU_$(BP_TYPE)_$(L1I)_$(L1D)_$(shell date +%N)_$(POSTFIX_F) configs/example/se_bp.py -c $(PLD_BIN) -o '$(PLD_OPT)' \
		--cpu-type $(CPU_TYPE) \
		--caches --l1d_size $(L1D) --l1i_size $(L1I) --cacheline_size $(CACHELINE) \
		--bp-type $(BP_TYPE)
	echo $(DEBUG_OPTS)

ooo:
	./build/RISCV/gem5.opt $(DEBUG_OPTS)  --outdir $(OUTDIR_FINAL)m5out_DerivO3CPU_$(BP_TYPE)_$(L1I)_$(L1D)_$(shell date +%N)_$(POSTFIX_F) configs/example/se_bp.py -c $(PLD_BIN) -o '$(PLD_OPT)' \
		--cpu-type $(CPU_TYPE) \
		--caches --l1d_size $(L1D) --l1i_size $(L1I) --cacheline_size $(CACHELINE) \
		--bp-type $(BP_TYPE)

timing_simple:
	./build/RISCV/gem5.opt  --outdir m5out_TimingSimpleCPU_$(BP_TYPE)_$(L1I)_$(L1D)_$(shell date +%N)_$(POSTFIX_F) configs/example/se_bp.py -c $(PLD_BIN) -o hello \
		--cpu-type TimingSimpleCPU \
		--caches --l1d_size $(L1D) --l1i_size $(L1I) --cacheline_size $(CACHELINE)
		#--bp-type $(BP_TYPE)


pipeview:
	python3 util/o3-pipeview.py -c 500 -o pipeview.out --color out/o3_vis/trace.out
	less -r pipeview.out

list:
	@echo '######################################################################################'
	./build/RISCV/gem5.opt configs/example/se_bp.py --list-bp-types
	@echo '######################################################################################'
	./build/RISCV/gem5.opt configs/example/se_bp.py --list-indirect-bp-types
	@echo '######################################################################################'
	./build/RISCV/gem5.opt configs/example/se_bp.py --list-cpu-types
