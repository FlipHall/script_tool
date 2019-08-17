#! /bin/bash

# "-p dir " or "-p file"
# step1. 加密压缩
# step2. 分卷 每个5M
# 处理结果存储在 $2_encrypt/ 目录下
#              $2.tar.gz.aa $2.tar.gz.ab $2.tar.gz.ac ...
#              $2.tar.gz.ba $2.tar.gz.bb $2.tar.gz.bc ...

# "-up dir"
# step1. 合并分卷
# step2. 解密解压缩
# 处理结存储在 $2_decrypt/ 目录下

if [[ $# != 2 ]]; then
  echo "uasge:"
  echo "$0 -p dir or $0 -p file"
  echo "$0 -up dir"
  exit
fi

if [[ $1 == "-p" ]]; then
  [[ -d $2_encrypt ]] && echo "error: direction $2_encrypt exists" && exit
  # step1
  mkdir $2_encrypt/
  tar -czvf - $2  | openssl des3 -salt -k 'kernel123_[{@#$%' | dd of=$2_encrypt/$2.tar.gz
  # step2
  split -b 5M $2_encrypt/$2.tar.gz "$2_encrypt/$2.tar.gz."
  rm -rf $2_encrypt/$2.tar.gz
fi

if [[ $1 == "-up" ]]; then
  [[ -d $2_decrypt ]] && echo "error: direction $2_decrypt exists" && exit
  # step1
  mkdir $2_decrypt/
  cat $2/*.tar.gz.* > $2_decrypt/$2.tar.gz
  # step2
  dd if=$2_decrypt/$2.tar.gz | openssl des3 -d -k 'kernel123_[{@#$%' | tar xzvf - -C $2_decrypt/
  rm -rf $2_decrypt/$2.tar.gz
fi

echo "success"
