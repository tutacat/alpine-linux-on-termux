# Install Alpine Linux VM on Termux using QEMU System

> For this case, we will install ** Alpine Linux architecture x86_64 in the Virtual version **. Download the latest version of the virtual ISO from the Alpine Linux website. Go to the official website https://alpinelinux.org/downloads/

> Note: You can run the script ```install-alpine.sh``` to skip most commands.
Just remember you must have git installed to do ```git clone``` to the repository

> Full OS VMs are more fully-featured since they run the full linux kernel, but compiled programs, or proot container will be faster and have better access to GPU.


## Steps before installing Alpine Linux:

**Termux:**  
* **Download and install F-Droid** or Neo Store: https://f-droid.org/F-Droid.apk
* Install Termux from F-Droid Repo
* Open Termux


* **Install/upgrade needed packages:**
```
pkg upgrade -y curl qemu-system-x86-64-headless qemu-utils
```

> Make a directory to store installer and storage disk.
```
mkdir -p "$HOME/alpine-linux"
cd "$HOME/alpine-linux"
```

> Download Alpine or your OS of choice
```
curl -LO <VIRTUAL_ISO_URL>
ls
```
```
curl -L -o ./alpine-virt-x86-64.iso https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/x86_64/alpine-virt-3.18.0-x86_64.iso
```

## Install Alpine Linux using Qemu  
* Create the Virtual Machine disk 
```
qemu-img create -f qcow2 alpine.qcow2 15G
```

## Run the installer
```
qemu-system-x86_64 -smp 1,cores=2 -m 2048 \
  -accel tcg,thread=multi \
  -drive file=alpine.qcow2,if=virtio \
  -netdev user,id=n1,hostfwd=tcp::2222-:22 \
  -device virtio-net,netdev=n1 \
  -cdrom <VIRTUAL_ISO_NAME.iso> -boot d \
  -nographic
```

```
qemu-system-x86_64 -smp 1,cores=2 -m 2048 \
  -accel tcg,thread=multi \
  -drive file=alpine.qcow2,if=virtio \
  -netdev user,id=n1,hostfwd=tcp::2222-:22 \
  -device virtio-net,netdev=n1 \
  -cdrom alpine-virt-x86_64.iso -boot d \
  -nographic
```

> * This install the **non-graphical version**, this means that we will only use the terminal

* #### Log in as ```root``` (no password) and run:
```
setup-alpine
```
> Follow the setup-alpine installation steps.
> Use ```poweroff``` to shut down the machine.

* #### Booting the Virtual Machine
After the installation QEMU can be started from disk image ```(-boot c)``` without CDROM.
```
qemu-system-x86_64 -smp 1,cores=2 -m 2048 \
  -accel tcg,thread=multi \
  -drive file=alpine.qcow2,if=virtio \
  -netdev user,id=n1,hostfwd=tcp::2222-:22 \
  -device virtio-net,netdev=n1 \
  -nographic
```

## For more information about the commands seen here, have a look at documentation, such as https://wiki.archlinux.org/title/QEMU
