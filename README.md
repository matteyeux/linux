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
