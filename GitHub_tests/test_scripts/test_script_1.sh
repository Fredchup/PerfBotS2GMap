#!/bin/sh
srun hostname
srun pwd

echo dir:
rm -r out_files
rm -r wor_files
mkdir out_files
mkdir wor_files

echo index/sim:
srun vg index -x wor_files/x.xg -g wor_files/x.gsca -k 16 vgrep/test/graphs/not-simple.vg
srun vg sim -n 1000 -l 150 -x wor_files/x.xg > wor_files/x.sim.txt

echo map0:
srun vg map -T wor_files/x.sim.txt -x wor_files/x.xg -g wor_files/x.gsca > wor_files/x.gam
srun vg surject -x wor_files/x.xg -b wor_files/x.gam > wor_files/x.bam
srun vg pack -x wor_files/x.xg -g wor_files/x.gam -Q 5 -s 5 -o wor_files/x.pack
srun vg call wor_files/x.xg -k wor_files/x.pack > out_files/v0.vcf

echo map1:
srun vg map -T wor_files/x.sim.txt -x wor_files/x.xg -g wor_files/x.gsca -q 1 -z 100 -o 101 -y 100 > wor_files/x.gam
srun vg surject -x wor_files/x.xg -b wor_files/x.gam > wor_files/x.bam
srun vg pack -x wor_files/x.xg -g wor_files/x.gam -Q 5 -s 5 -o wor_files/x.pack
srun vg call wor_files/x.xg -k wor_files/x.pack > out_files/v1.vcf

echo map2:
srun vg map -T wor_files/x.sim.txt -x wor_files/x.xg -g wor_files/x.gsca -q 1 -z 1 -o 0 -y 2 > wor_files/x.gam
srun vg surject -x wor_files/x.xg -b wor_files/x.gam > wor_files/x.bam
srun vg pack -x wor_files/x.xg -g wor_files/x.gam -Q 5 -s 5 -o wor_files/x.pack
srun vg call wor_files/x.xg -k wor_files/x.pack > out_files/v2.vcf

echo map3:
srun vg map -T wor_files/x.sim.txt -x wor_files/x.xg -g wor_files/x.gsca -q 1 -z 1 -o 2 -y 1 > wor_files/x.gam
srun vg surject -x wor_files/x.xg -b wor_files/x.gam > wor_files/x.bam
srun vg pack -x wor_files/x.xg -g wor_files/x.gam -Q 5 -s 5 -o wor_files/x.pack
srun vg call wor_files/x.xg -k wor_files/x.pack > out_files/v3.vcf

echo map4:
srun vg map -T wor_files/x.sim.txt -x wor_files/x.xg -g wor_files/x.gsca -q 1 -z 2 -o 1 -y 1 > wor_files/x.gam
srun vg surject -x wor_files/x.xg -b wor_files/x.gam > wor_files/x.bam
srun vg pack -x wor_files/x.xg -g wor_files/x.gam -Q 5 -s 5 -o wor_files/x.pack
srun vg call wor_files/x.xg -k wor_files/x.pack > out_files/v4.vcf

echo map5:
srun vg map -T wor_files/x.sim.txt -x wor_files/x.xg -g wor_files/x.gsca -q 2 -z 1 -o 1 -y 1 > wor_files/x.gam
srun vg surject -x wor_files/x.xg -b wor_files/x.gam > wor_files/x.bam
srun vg pack -x wor_files/x.xg -g wor_files/x.gam -Q 5 -s 5 -o wor_files/x.pack
srun vg call wor_files/x.xg -k wor_files/x.pack > out_files/v5.vcf

echo map6:
srun vg map -T wor_files/x.sim.txt -x wor_files/x.xg -g wor_files/x.gsca -q 2 -z 2 -o 2 -y 1 > wor_files/x.gam
srun vg surject -x wor_files/x.xg -b wor_files/x.gam > wor_files/x.bam
srun vg pack -x wor_files/x.xg -g wor_files/x.gam -Q 5 -s 5 -o wor_files/x.pack
srun vg call wor_files/x.xg -k wor_files/x.pack > out_files/v6.vcf

echo map7:
srun vg map -T wor_files/x.sim.txt -x wor_files/x.xg -g wor_files/x.gsca -q 2 -z 2 -o 1 -y 2 > wor_files/x.gam
srun vg surject -x wor_files/x.xg -b wor_files/x.gam > wor_files/x.bam
srun vg pack -x wor_files/x.xg -g wor_files/x.gam -Q 5 -s 5 -o wor_files/x.pack
srun vg call wor_files/x.xg -k wor_files/x.pack > out_files/v7.vcf

echo map8:
srun vg map -T wor_files/x.sim.txt -x wor_files/x.xg -g wor_files/x.gsca -q 2 -z 1 -o 2 -y 2 > wor_files/x.gam
srun vg surject -x wor_files/x.xg -b wor_files/x.gam > wor_files/x.bam
srun vg pack -x wor_files/x.xg -g wor_files/x.gam -Q 5 -s 5 -o wor_files/x.pack
srun vg call wor_files/x.xg -k wor_files/x.pack > out_files/v8.vcf

echo map9:
srun vg map -T wor_files/x.sim.txt -x wor_files/x.xg -g wor_files/x.gsca -q 1 -z 2 -o 2 -y 2 > wor_files/x.gam
srun vg surject -x wor_files/x.xg -b wor_files/x.gam > wor_files/x.bam
srun vg pack -x wor_files/x.xg -g wor_files/x.gam -Q 5 -s 5 -o wor_files/x.pack
srun vg call wor_files/x.xg -k wor_files/x.pack > out_files/v9.vcf

echo done!
