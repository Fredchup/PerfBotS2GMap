../bin/vg sim -n 1000000 -l 200 -x ../wor_files/x.xg > ../wor_files/x.sim.txt
perf record --call-graph fp ../bin/vg map -w 200 -T ../wor_files/x.sim.txt -x ../wor_files/x.xg -g ../wor_files/x.gsca > ../wor_files/x.gam
perf report -g
