qemu-system-x86_64 -enable-kvm -machine q35 -device amd-iommu -m 2048 -cpu host\
    -smp cores=4,threads=3,sockets=1\
    -boot menu=on -drive file=/mnt/myPassport/virtual/kali-linux,format=raw -drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2/x64/OVMF_CODE.4m.fd \
    -drive if=pflash,format=raw,file=/mnt/myPassport/virtual/UEFI/OVMF_VARS.4m.fd
