echo "This script uses some default memory values, you should tailor them to your system and use-case."
pkg upgrade -y curl qemu-system-x86-64-headless qemu-utils
BASE='~/alpine-linux'
eval set BASEDIR="$BASE"
[ ! -d "$BASEDIR" ] && mkdir -p "$BASEDIR" || (echo 'Failed to create $BASE.'; exit 1)
curl -LCZo alpine-virt-x86_64.iso https://dl-cdn.alpinelinux.org/alpine/v3.14/releases/x86_64/alpine-virt-3.14.0-x86_64.iso
qemu-img create -f qcow2 alpine.qcow2 15G
qemu-system-x86_64 -smp 1,cores=2 -m 2048 \
  -accel tcg,thread=multi
  -drive file=alpine.qcow2,if=virtio \
  -netdev user,id=n1,hostfwd=tcp::2222-:22 \
  -device virtio-net,netdev=n1 \
  -cdrom alpine-virt-x86_64.iso -boot d \
  -nographic

