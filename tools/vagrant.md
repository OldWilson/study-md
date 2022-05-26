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