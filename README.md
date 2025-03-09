# StarryOS

[![CI](https://github.com/arceos-org/starry-next/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/arceos-org/starry-next/actions/workflows/ci.yml)

A monolithic kernel based on [ArceOS](https://github.com/arceos-org/arceos).

## Quick Start

 
This is a repository specifically designed for cloud development, so it is recommended to have some understanding of **starryos** beforehand.

### About the testcases:
By executing `./config.sh platform`, the challenge will be automatically fetched, and the corresponding image file will be generated in the current directory. The `platform` can be set to either `riscv` or `loongarch`, depending on which architecture you want to test for the challenge.

### About execution:
You can directly execute `make all` in the current directory to compile the OS. Then, execute one of the following commands:

For **RISC-V**:
```bash
qemu-system-riscv64 -machine virt -kernel ./kernel-rv -m 2G -nographic -smp 2 -bios default -drive file=sdcard-riscv.img,if=none,format=raw,id=x0 \
                    -device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0 -no-reboot -device virtio-net-device,netdev=net -netdev user,id=net \
                    -rtc base=utc
```

For **LoongArch**:
```bash
qemu-system-loongarch64 -m 1G -smp 1 -kernel ./kernel-la -device virtio-blk-pci,drive=disk0 -drive id=disk0,if=none,format=raw,file=sdcard-loongarch.img -no-reboot -device virtio-net-pci,netdev=net0 -netdev user,id=net0,hostfwd=tcp::5555-:5555,hostfwd=udp::5555-:5555 -nographic
```

These commands will run the respective virtual machines for either **RISC-V** or **LoongArch** platforms.

The specific testcase to test can be specified through `apps/oscomp/testcase_list`.

