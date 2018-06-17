# linux
pic.patch : used to fix this error when building kernel with GCC 5+(?):
```
$ make
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CC      kernel/bounds.s
kernel/bounds.c:1:0: error: code model kernel does not support PIC mode
 /*

Kbuild:44: recipe for target 'kernel/bounds.s' failed
make[1]: *** [kernel/bounds.s] Error 1
Makefile:987: recipe for target 'prepare0' failed
make: *** [prepare0] Error 2
```
To apply patch : `patch Makefile pic.patch` <br> 
It forces no-pie for distro compilers that enable pie by default

## cutter
[Cutter](https://github.com/radareorg/cutter) is a [radare2](https://github.com/radareorg/radare2) GUI.

#### Build from sources : 
Install some packages :
- cmake 
- qt5-default 
- libqt5svg5-dev 
- git

To build we first need to install radare2 :
- clone radare2 : `git clone https://github.com/radareorg/radare2`
- cd to radare2 directory then run install script : `cd radare2; ./sys/install.sh; cd ..`

Once r2 is built we can now build cutter :
- clone cutter : `git clone https://github.com/radareorg/cutter`
- cd to src and create a new dir then run `cmake` from this dir, like this : `cd src; mkdir build && cd build`
- run cmake and make : `cmake ..; make`

