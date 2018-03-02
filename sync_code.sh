#!/bin/bash
#set -e


UPDATE_DIR="bootable device kernel-4.4 mephone vendor"

for dir in $UPDATE_DIR; do
echo -e "\e[0;32mupdating $dir/\e[0m"
if [[ ! -d $dir ]]; then
repo sync $dir -j4
else
(cd $dir; git clean -df; git reset --hard HEAD; repo sync . -j4)
fi
done
