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
   $ export JAVA_HOME=~/jdks/java-17
   ```

   

## 2. TOMCAT

