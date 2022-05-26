# virtual-box

## QA

### 1. mount: unknown filesystem type 'vboxsf'

1. 问题描述

   ```powershell
   Vagrant was unable to mount VirtualBox shared folders. This is usuallybecause the filesystem "vboxsf" is not available. This filesystem is
   made available via the VirtualBox Guest Additions and kernel module.
   Please verify that these guest additions are properly installed in the
   guest. This is not a bug in Vagrant and is usually caused by a faulty
   Vagrant box. For context, the command attempted was:
   mount -t vboxsf -o uid=1000,gid=1000,_netdev home_vagrant_labs /home/vagrant/labs
   The error output from the command was:
   mount: unknown filesystem type 'vboxsf'
   ```

2. 解决办法

   ```powershell
   > vagrant plugin install vagrant-vbguest
   ```

   

