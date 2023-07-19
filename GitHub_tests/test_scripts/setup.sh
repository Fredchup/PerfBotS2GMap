http_proxy=http://proxy.ethz.ch:3128 apt-get install linux-tools-generic
http_proxy=http://proxy.ethz.ch:3128 apt-get install linux-tools-5.15.0-43-generic

cd ..
. ./source_me.sh
make -j48
cd test_scripts
../bin/vg index -x ../wor_files/x.xg -g ../wor_files/x.gsca -k 16 ../chr20_HG001_002_003_004_005_006_007_v3.3.2_chopped.vg
