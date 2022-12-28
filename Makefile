
MD5 := /home/jiang/repos/md5/md5.rv

#  --cpu-type {AtomicSimpleCPU,BaseAtomicSimpleCPU,BaseMinorCPU,BaseNonCachingSimpleCPU,BaseO3CPU,BaseTimingSimpleCPU,DerivO3CPU,MinorCPU,NonCachingSimpleCPU,O3CPU,RiscvAtomicSimpleCPU,RiscvMinorCPU,RiscvNonCachingSimpleCPU,RiscvO3CPU,RiscvTimingSimpleCPU,TimingSimpleCPU,TraceCPU}
#  --bp-type {BiModeBP,LTAGE,LocalBP,MultiperspectivePerceptron64KB,MultiperspectivePerceptron8KB,MultiperspectivePerceptronTAGE64KB,MultiperspectivePerceptronTAGE8KB,TAGE,TAGE_SC_L_64KB,TAGE_SC_L_8KB,TournamentBP}

CPU_TYPE := DerivO3CPU
BP_TYPE := BiModeBP
L1D := 4096
L1I := 4096
CACHELINE := 64

OUTDIR := m5out_$(CPU_TYPE)_$(BP_TYPE)_$(L1I)_$(L1D)_$(shell date +%N)

run:
	./build/RISCV/gem5.opt  --outdir $(OUTDIR) configs/example/se.py -c $(MD5) -o hello \
		--cpu-type $(CPU_TYPE) \
		--caches --l1d_size $(L1D) --l1i_size $(L1I) --cacheline_size $(CACHELINE) \
		--bp-type $(BP_TYPE)


	
