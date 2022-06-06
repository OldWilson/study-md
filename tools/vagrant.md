# Vagrant

## 安装

* 检测vagrant安装成功：

```shell
vagrant version
```

## 基本操作

### 1. 创建虚拟机

```shell
mkdir demo
cd demo
vagrant init centos-7
```

### 2. 启动虚拟机

```shell
vagrant up
```

### 3. 查看虚拟机状态

```shell
vagrant status
```

### 4. 连接虚拟机

```shell
vagrant ssh
```

### 5. 停止虚拟机

```shell
vagrant halt
```

### 6. 暂停虚拟机

```shell
vagrant suspend
```

### 7. 恢复虚拟机

```shell
vagrant resume
```

### 8. 重载虚拟机

```shell
vagrant reload
```

###  9. 删除虚拟机

```shell
vagrant destroy
```

## Vagarntfile

1. Ruby语法的文件

### 1. 配置端口转发

1. 就是把虚拟机的某个端口，映射到主机的端口上，这个就能在宿主机上访问到虚拟机中的服务

2. 默认的端口映射无法直接修改，需要先将默认的端口映射无效化

   ```ruby
   config.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh", disabled: "true"
   config.vm.network "forwarded_port", guest: 22, host: 22222
   ```

### 2. 配置私有网络

```ruby
config.vm.network "private_network", ip: "192.168.0.1"
```

### 3. 配置同步文件夹

```ruby
config.vm.synced_folder "../data", "/vagrant_data", type: "rsync"
```

### 4. Provision

1. provision是指在虚拟机初次创建的时候，vagrant自动去执行的构造任务。

## QA

### 1. VBoxManage: error: Code E_ACCESSDENIED (0x80070005) - Access denied (extended info not available)

* 问题描述

  ```shell
  There was an error while executing `VBoxManage`, a CLI used by Vagrant
  for controlling VirtualBox. The command and stderr is shown below.
  
  Command: ["hostonlyif", "ipconfig", "vboxnet0", "--ip", "192.168.205.1", "--netmask", "255.255.255.0"]
  
  Stderr: VBoxManage: error: Code E_ACCESSDENIED (0x80070005) - Access denied (extended info not available)
  VBoxManage: error: Context: "EnableStaticIPConfig(Bstr(pszIp).raw(), Bstr(pszNetmask).raw())" at line 242 of file VBoxManageHostonly.cpp
  ```

* 解决办法

  * 打开 系统偏好设置 -> 安全性与隐私 -> 通用，解锁

  * 加载vbox驱动

    ```sh
    sudo /Library/Application\ Support/VirtualBox/LaunchDaemons/VirtualBoxStartup.sh restart
    ```

  * 创建/etc/vbox/networks.conf，并添加内容 “* 0.0.0.0/0 ::/0”

    ```sh
    cat /etc/vbox/networks.conf
    * 0.0.0.0/0 ::/0
    ```



### 2. mount: unknown filesystem type 'vboxsf'

* 问题描述

  ```sh
  Vagrant was unable to mount VirtualBox shared folders. This is usually
  because the filesystem "vboxsf" is not available. This filesystem is
  made available via the VirtualBox Guest Additions and kernel module.
  Please verify that these guest additions are properly installed in the
  guest. This is not a bug in Vagrant and is usually caused by a faulty
  Vagrant box. For context, the command attempted was:
  
  mount -t vboxsf -o uid=1000,gid=1000 home_vagrant_labs /home/vagrant/labs
  
  The error output from the command was:
  
  mount: unknown filesystem type 'vboxsf'
  ```

* 解决办法

  ```sh
  vagrant plugin install vagrant-vbguest --plugin-version 0.21
  ```

  

  