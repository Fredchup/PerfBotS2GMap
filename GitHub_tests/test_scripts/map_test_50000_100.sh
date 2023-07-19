../bin/vg sim -n 100 -l 50000 -x ../wor_files/x.xg > ../wor_files/x.sim.txt
perf record --call-graph fp ../bin/vg map -w 50000 -T ../wor_files/x.sim.txt -x ../wor_files/x.xg -g ../wor_files/x.gsca > ../wor_files/x.gam
perf report -g
