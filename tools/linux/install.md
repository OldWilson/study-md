# INSTALL

## 1. Node.JS

* 安装wget

  ```sh
  $ yum -y install wget
  ```

* 官网下载nodejs

  ```sh
  $ wget https://npmmirror.com/mirrors/node/v20.17.0/node-v20.17.0-linux-x64.tar.xz
  ```

* 解压

  ```sh
  $ tar xf node-v20.17.0-linux-x64.tar.xz 
  ```

* 添加软连接

  ```sh
  $ ln -s /usr/dev/node/bin/node /usr/local/bin/
  $ ln -s /usr/dev/node/bin/npm /usr/local/bin/
  ```

* 验证

  ```sh
  $ node -v
  $ npm -v
  ```

  

