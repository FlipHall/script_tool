#! /bin/bash
# dtc is needed, dtc path is **/obj/KERNEL_OBJ/scripts/dtc/dtc.

if [[ $# != 1  ]]; then
echo "Wrong parameter, Please input dtb name."
fi

filename="${1%.*}"
dtc -I dtb -O dts $filename.dtb -o $filename.dts && echo -e "dts: $filename.dts"
