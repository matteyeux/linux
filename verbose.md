# Verbose 
Get verbose boot on Debian 9

Edit /etc/default/grub as root. <br>
Remove the `GRUB_CMDLINE_LINUX` parameter which is "quiet".
```
[...]
GRUB_DEFAULT=0
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT=""
GRUB_CMDLINE_LINUX=""
[...]
```
Then run `sudo update-grub` : 

```
$ sudo update-grub
Generating grub configuration file ...
Found background image: /usr/share/images/desktop-base/desktop-grub.png
Found linux image: /boot/vmlinuz-4.4.17
Found initrd image: /boot/initrd.img-4.4.17
Found linux image: /boot/vmlinuz-4.4.17.old
Found initrd image: /boot/initrd.img-4.4.17
done
```
