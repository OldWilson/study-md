# JAVA

## 1. JDK

1. yum安装

   ```sh
   $ sudo yum install java-17-openjdk
   $ java -version
   openjdk version "17.0.11" 2024-04-16 LTS
   OpenJDK Runtime Environment (Red_Hat-17.0.11.0.9-3) (build 17.0.11+9-LTS)
   OpenJDK 64-Bit Server VM (Red_Hat-17.0.11.0.9-3) (build 17.0.11+9-LTS, mixed mode, sharing)
   ```

2. zip安装

   ```shell
   # https://developers.redhat.com/products/openjdk/download
   $ mkdir ~/jdks
   $ cd ~/jdks
   $ tar -xf java-17-openjdk-17.0.5.0.8-2.portable.jre.el7.x86_64.tar.xz -C ~/jdks
   $ ln -s ~/jdks/java-17-openjdk-17.0.5.0.8-2.portable.jdk.el7.x86_64 ~/jdks/java-17
   
   $ vim /etc/profile
   export JAVA_HOME=/usr/soft/java/jdk1.8.0_271  #指定自己的jdk文件路径
   export CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
   export PATH=$PATH:$JAVA_HOME/bin
   
   $ source /etc/profile
   ```
   
   

## 2. TOMCAT

```sh
# https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.26/bin/apache-tomcat-10.1.26.tar.gz

mkdir /usr/local/tomcat
# 解压
$ tar -xvf apache-tomcat-10.1.26.tar.gz
mv apache-tomcat-10.1.26 /usr/local/tomcat/tomcat10

# 创建用户
$ useradd -r tomcat
chown -R tomcat:tomcat /usr/local/tomcat/

# tomcat服务
$ vim /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Server
After=syslog.target network.target

[Service]
Type=forking
User=tomcat
Group=tomcat

Environment=JAVA_HOME=/usr/local/jdks/openjdk17
Environment=CATALINA_PID=/usr/local/tomcat/tomcat10/temp/tomcat.pid
Environment=CATALINA_HOME=/usr/local/tomcat/tomcat10
Environment=CATALINA_BASE=/usr/local/tomcat/tomcat10

ExecStart=/usr/local/tomcat/tomcat10/bin/catalina.sh start
ExecStop=/usr/local/tomcat/tomcat10/bin/catalina.sh stop

RestartSec=10
Restart=always
[Install]
WantedBy=multi-user.target

# 服务加载
$ systemctl daemon-reload
$ systemctl start tomcat.service
$ systemctl enable --now tomcat.service
$ systemctl status tomcat.service
$ systemctl stop tomcat.service

# 查看HTTP监听端口
$ netstat -tlpn # netstat - net-tool

# 开放HTTP访问权限
# 1. 普通Linux服务器
$ firewall-cmd --zone=public --permanent --add-port=8080/tcp
$ firewall-cmd --zone=public --permanent --add-port=8443/tcp
$ firewall-cmd --reload
# 2. AWSLinux服务器
# 添加安全组TCP-8080规则
```

