#! /bin/bash

COMPILE_TARGET=full_wtk6737t_66_n-eng      # lunch target, add here

if [[ $# == 0 ]]; then
echo -e "\e[0;32m### lack of parameter(s) ###\e[0m"
cat  << EOF
    pl (preloader)
    lk (bootloader)
    bootimage
    remake
    new (clobber+make)
EOF
echo -e "\e[0;32m############################\e[0m"
exit 0
fi

echo

if [[ ! -d log_build ]]; then
mkdir log_build
fi

echo -e "\e[0;32m### source && lunch ... start ###\e[0m"
source build/envsetup.sh && lunch $COMPILE_TARGET
echo -e "\e[0;32m### source && lunch ... done ###\e[0m"


echo
for((n=1;n<=$#;n++))
do
# echo "\$$n"
# echo ${!n}
if [[ ${!n} == "pl" ]]; then
echo -e "\e[0;32m### compile preloader ... start ###\e[0m"
make -j16 pl 2>&1 | tee log_build/pl_build_log_`date +"%Y%m%d%H%M"`
echo -e "\e[0;32m### compile preloader ... done ###\e[0m"

elif [[ ${!n} == "lk" ]]; then
echo -e "\e[0;32m### compile lk ... start ###\e[0m"
make -j16 lk 2>&1 | tee log_build/lk_build_log_`date +"%Y%m%d%H%M"`
echo -e "\e[0;32m### compile lk ... done ###\e[0m"

elif [[ ${!n} == "bootimage" ]]; then
echo -e "\e[0;32m### compile bootimage ... start ###\e[0m"
make -j16 kernel bootimage 2>&1 | tee log_build/bootimage_build_log_`date +"%Y%m%d%H%M"`
echo -e "\e[0;32m### compile bootimage ... done ###\e[0m"

elif [[ ${!n} == "remake" ]]; then
echo -e "\e[0;32m### compile remake ... start ###\e[0m"
make -j16  2>&1 | tee log_build/remake_build_log_`date +"%Y%m%d%H%M"`
echo -e "\e[0;32m### compile remake ... done ###\e[0m"

elif [[ ${!n} == "new" ]]; then
echo -e "\e[0;32m### compile new ... start ###\e[0m"
make -j16 clobber && make -j16  2>&1 | tee log_build/new_build_log_`date +"%Y%m%d%H%M"`
echo -e "\e[0;32m### compile new ... done ###\e[0m"

elif [[ ${!n} == "clobber" ]]; then
echo -e "\e[0;32m### compile clobber ... start ###\e[0m"
make -j16 clobber 2>&1 | tee log_build/clobber_build_log_`date +"%Y%m%d%H%M"`
echo -e "\e[0;32m### compile clobber ... done ###\e[0m"

else
echo -e "\e[1;31m### wrong parameter(s) ###\e[0m"
fi

done
