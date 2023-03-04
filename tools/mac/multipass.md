# multipass

## 安装

1. brew安装

   ```bash
   brew install --cask multipass
   ```

2. 官方下载地址

   > [How to install Multipass on macOS | Multipass documentation](https://multipass.run/docs/installing-on-macos)



## 命令

### 1. 查看可供下载的Ubuntu镜像

```bash
multipass find
```

### 2. 创建Ubuntu虚拟机

```bash
multipass launch -n vm01 -c 1 -m 1G -d 10G

# -n, --name: 名称
# -c, --cpus: cpu核心数，默认1
# -m, --mem: 内存大小，默认1G
# -d, --disk: 硬盘大小，默认5G
```

### 查看安装的虚拟机列表

```bash
multipass list
```

### 外部操作虚拟机

```bash
multipass exec vm01 pwd
```

### 查看虚拟机信息

``` bash
multipass info vm01
```

### 进入虚拟机

```bash
multipass shell vm01

sudo passwd # 设置密码
su root

apt-get update
apt-get install nginx

```

### 挂载数据卷

```bash
multipass mount 主机目录 vm01:虚拟机目录
```

### 卸载数据卷

```bash
multipass unmount vm01
```

### 传输文件

```bash
multipass transfer 主机文件 vm01:虚拟机目录
```

### 管理实例

```bash
multipass start vm01 # 启动实例
multipass stop vm01 # 停止实例
multipass delete vm01 # 删除实例，（删除后，还会存在）
multipass purge # 彻底删除，释放实例
```

### 容器配置自动化

> config.yaml文件参考：[Cloud config examples - cloud-init 23.1 documentation (cloudinit.readthedocs.io)](https://cloudinit.readthedocs.io/en/latest/reference/examples.html#including-users-and-groups)

```bash
multipass launch --name vm01 --cloud-init config.yaml
```

* config.yaml文件

  ```yaml
  #cloud-config
  runcmd:
    - curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
    - sudo apt-get install -y nodejs
  ```