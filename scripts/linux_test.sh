#!/bin/bash
#######################################################################
#
#  Project......: linux_test.sh
#  Creator......: matteyeux
#  Description..: build and install busybox + initrd to test a new Linux kernel
#  Type.........: Public
#
######################################################################
# Language :
#               bash
# Version : 0.1
#
#  Change Log
#  ==========
#
#   ===============================================================
#    Date     |       Who          |      What
#   ---------------------------------------------------------------
#    19/12/17 |     matteyeux      | Script creation
#   ---------------------------------------------------------------
#linux-stuff/linux-4.14.8/arch/x86_64/boot/bzImage
bzImage="/home/mathieu/Documents/linux-stuff/linux-4.14.8/arch/x86_64/boot/bzImage"

if [[ $1 == "qemu" ]];then 
	qemu-system-x86_64 -snapshot -m 1GB -serial stdio -kernel ~/Documents/linux-stuff/linux-4.14.8/arch/x86_64/boot/bzImage -initrd kernel_tests/initramfs/initrd_x86_64.gz  -append "root=/dev/sda1 ignore_loglevel"
	exit 0
fi
mkdir kernel_tests && cd kernel_tests
# build busybox
sudo apt-get install libncurses5-dev qemu-system-x86 -y 
wget https://busybox.net/downloads/busybox-1.27.2.tar.bz2 -O busybox.tar.bz2
tar jxvf busybox.tar.bz2
mv busybox-1.27.2 busybox
cp ../../resources/config.busybox busybox/.config
cd busybox/
make && sudo make install

# build initrd
cd ..
mkdir -p initramfs
cd initramfs
mkdir -pv {bin,sbin,etc,proc,sys,usr/{bin,sbin}}
cp -av ../busybox/_install/* .


# init script
echo "#!/bin/sh" > init
echo "mount -t proc none /proc" >> init
echo "mount -t sysfs none /sys" >> init
echo "exec /bin/sh" >> init
# end init script

chmod +x init

# create an archive that will be initrd
find . -print0 | cpio --null -ov --format=newc | gzip -9 > initrd_x86_64.gz 
cd ..

# whatever, in French you call it "flemme"
if [[ $# == 1 ]]; then
	qemu-system-x86_64 -snapshot -m 1GB -serial stdio -kernel $bzImage -initrd initramfs/initrd_x86_64.gz -append "root=/dev/sda1 ignore_loglevel"
fi
