#!/bin/bash
 
#  更改root用户密码
echo "root:!QAZ2wsx" | sudo chpasswd
echo "!QAZ2wsx" |su root
 
#  启用密码身份验证
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/50-cloud-init.conf
sudo service sshd restart