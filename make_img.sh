#!/bin/bash

platform=$1

make $platform

# 定义变量
SRC_DIR="sdcard/$platform"
IMG="sdcard-$platform.img"
dd if=/dev/zero of=$IMG count=128 bs=1M
mkfs.ext4 $IMG

find "$SRC_DIR" -type f | while read -r src_file; do
    # 计算相对路径（兼容绝对路径格式）
    rel_path="${src_file#$SRC_DIR}"
    rel_path="${rel_path#/}"  # 去除可能的前导斜杠
    # 在镜像中递归创建目录
    dir_in_img=$(dirname "/$rel_path")
    # echo "dir_in_img: $dir_in_img"
    e2mkdir "$IMG:$dir_in_img"
    e2cp "$src_file" "$IMG:$dir_in_img" || echo "Failure: $src_file"
done