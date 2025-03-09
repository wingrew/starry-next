#!/bin/bash

platform=$1
if [ ! -d "../testcases-25" ]; then
  apt install e2tools
  cd ..
  git clone https://github.com/oscomp/testsuits-for-oskernel.git testcases-25
  cd testcases-25 && git checkout pre-2025  
  cd ../starry-next
fi

if [ -f "Makefile_testcases" ]; then
  mv Makefile_testcases ../testcases-25/Makefile
fi

if [ -f "make_img.sh" ]; then
  chmod +x make_img.sh
  mv make_img.sh ../testcases-25/
fi

cd ../testcases-25
./make_img.sh $platform
cd ../starry-next
mv ../testcases-25/sdcard-$platform.img ./
