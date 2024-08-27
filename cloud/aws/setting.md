# SETTING

## 1. 开启ROOT用户远程登录

1. 设置root用户密码

   ```sh
   $ sudo passwd root
   $ su root
   ```

2. 启用密码登录

   ```sh
   $ vi /etc/ssh/sshd_config
   # 修改以下配置
   PasswordAuthentication yes
   PermitRootLogin yes
   
   $ vi /etc/ssh/sshd_config.d/50-cloud-init.conf
   # 修改以下配置
   PasswordAuthentication yes
   
   # 重启sshd服务
   $ sudo service sshd restart
   ```

   