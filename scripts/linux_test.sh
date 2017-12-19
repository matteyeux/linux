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

busybox_v="1.27.2"
bzImage="/home/mathieu/Documents/linux-4.14.5/arch/x86_64/boot/bzImage"

mkdir kernel_tests && cd kernel_tests
# build busybox
sudo apt-get install libncurses5-dev qemu-system-x86 -y 
wget https://busybox.net/downloads/busybox-$busybox_v.tar.bz2
tar jxvf busybox-1.27.2.tar.bz2
cp config.busybox busybox-$busyboxv/.config
cd busybox-$busyboxv/
make && sudo make install

# build initrd
cd ..
mkdir -p initramfs
cd initramfs
mkdir -pv {bin,sbin,etc,proc,sys,usr/{bin,sbin}}
cp -av ../busybox-$busyboxv/_install/* .


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