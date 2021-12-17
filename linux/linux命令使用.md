# Linux

## 基础命令

* 子目录含义
  * bin：存放二进制可执行文件（ls，cat，mkdir等）
  * boot：存放用于系统引导时使用的各种文件
  * dev：存放设备文件
  * etc：存放系统配置文件
  * home：存放所有用户文件的根目录
  * lib：存放跟系统文件中的程序运行所需要的共享库及内核模块
  * proc：虚拟文件系统，存放当前内存的映射
  * usr：存放系统应用程序，比较重要的目录/usr/local管理员软件安装目录
  * var：存放运行时需要改变数据的文件
  * mnt：挂在目录
  * sbin：存储管理级别的二级制执行文件
  * root：超级用户主目录
  * opt：额外安装的可选应用程序包安装目录
* 文件查看
  * <font>pwd</font>：列出当前目录的路径
  * <font>ls</font>：列出当前目录下的所有文件
    * <font title="green">ls -l</font>：带文件信息
    * <font title="green">ls -a</font>：查看所有文件包含隐藏文件
* 创建、重命名文件文件夹
  * <font>touch filename</font>：创建空文件
    * <font title="green">touch foldername/{file1,file2,file3}</font>：创建多个文件
  * <font>mkidr foldername</font>：创建目录
    * <font title="green">mkdir -p foldername</font>：递归创建目录，即使上级目录不存在，会按目录层级自动创建目录
    * <font title="green">mkdir {folder1,folder2,folder3}/tool</font>：在多个文件夹中中都创建同一个文件夹
    * <font title="green">mkdir -m 777 foldername</font>：创建文件夹同时设置权限
  * <font>mv oldFilename/oldFoldername newFilename/newFoldername</font>：重命名文件或文件夹
    * <font title="green">-b</font>：当目标文件存在时，先进行备份再覆盖
    * <font title="green">-f</font>：当目标文件存在时，强制覆盖
    * <font title="green">-i</font>：默认选项，当目标文件存在时，提示是否覆盖
    * <font title="green">-t</font>：先指定目标，在指定源
    * <font title="green">-v</font>：显示过程
* 链接文件
  * 硬链接和符号（软）链接
  * 软连接类似Windows的快捷方式，主要用于节省硬盘空间
  * 硬链接相当于对原始文件的一个复制，不能对目录使用硬链接
  * <font>ln hello.txt linkname</font>：硬链接
  * <font>ln -s hello.txt linkname</font>：软连接
* 删除文件文件夹
  * <font>rm filename</font>：删除文件，会有提示确认对话
  * <font>rm -r foldername</font>：删除目录，需要确认
  * <font>rm -f</font>：前置删除
* 复制粘贴剪切
  * <font>cp test1.txt test2.txt</font>：复制test1.txt，复制后文件名为test2.txt
  * <font>cp -r folder1 folder2</font>：复制文件夹
* 远程复制
  * <font>scap /tmp/hello.txt 192.168.10.1:/tmp</font>：从本地复制文件到远程主机上
  * <font title="green">-v</font>：显示进度
  * <font title="green">-r</font>：复制文件夹
  * <font title="green">-q</font>：静默复制模式，关闭进度信息以及警告和诊断信息
* 文件属性
  * `-rw-r--r--.  1  root  root  0  Mar20 10:10 hello.txt`
  * 第一段：权限
    * 第一个字符代表文件（-）、目录（d）、链接（l）
    * 其余字符每3个一组。
      * 第一组：文件所有者的权限是读、写和执行
      * 第二组：与文件所有者同一组的用户的权限
      * 第三组：不与文件所者同组的其他用户的权限
  * 第二段：目录/链接个数
    * 对于目录文件，表示它的第一级子目录的个数。此处的值要减2才等与该目录下的子目录的实际个数（目录下默认包含.和...这两个目录）
    * 对于其他文件，默认是1
  * 第三段：所属用户
  * 第四段：所属组
  * 第五段：文件大小（字节）
  * 第六段：最后修改时间
  * 第七段：文件/文件夹名称
* chmod 分配权限
  * <font>chmod u+x filename</font>：给当前所有者添加执行权限
  * <font>chmod 777 filename</font>：给文件添加777权限
  * <font>chmod -R 777 foldername</font>：给指定目录递归添加777权限
* 文件内容查看
  * <font>cat filename</font>：显示文本内容
  * <font>cat -b filename</font>：显示行号输出
  * <font>more filename</font>：分屏显示文件
* 压缩、解压
  * 压缩
    * <font>tar -zcvf 压缩后的文件名 源文件/文件夹</font>：压缩源目录的内容，gzip方式
    * <font>tar -rvf 压缩文件 源文件/文件夹</font>：将源目录中的文件追加到压缩文件中
  * 解压
    * <font>tar -zxvf 压缩文件</font>：解压文件，gzip方式
    * <font>tar -tvf 压缩文件</font>：查看压缩文件里面的内容
  * 参数
    * <font title="green">-z</font>：是否同时具有gzip的属性，以及是否需要用gzip压缩
    * <font title="green">-c</font>：创建一个压缩文件的参数指令（create的意思）
    * <font title="green">-x</font>：解开一个压缩文件的参数指令
    * <font title="green">-v</font>：解压缩的过程中显示文件信息
    * <font title="green">-f</font>：要操作的文件名
    * <font title="green">-r</font>：表示增加文件，将文件追加到压缩文件的末尾
* 输出及显示
  * <font>echo "hello world"</font>
  * <font title="green">-n</font>：不换行输出
  * <font title="green">-e</font>：输出转义字符
* 软件安装和卸载
  * 压缩包安装方式
  * yum
    * <font>yum install -y package_name</font>：无询问方式安装
    * <font>update</font>：
      * <font>yum update package_name</font>：更新单个包
      * <font>yum update</font>：更新所有包及依赖项
      * <font>yum check-update</font>：检查系统上已安装的软件包是否有可用的更新
    * <font>yum info package_name</font>：显示包信息
    * <font>list</font>：
      * <font>yum list all</font>：列出所有已安装和可用的包信息
      * <font>yum list installed</font>：列出所有已安装的包
      * <font>yum list available</font>：列出所有可安装的已启用存储库中的包
      * <font>yum deplist package_name</font>：显示包的依赖关系以及什么软件可以提供这些依赖关系
* 查看操作历史
  * history保留了最近执行的命令记录，默认可以保留1000
  * <font>history N</font>：显示最近N条命令
  * <font>history -c</font>：清除所有的历史记录
  * <font>hstory -w backup.txt</font>：保存历史记录到文本backup.txt
* 磁盘使用情况
  * <font>df -h</font>
* 清屏：<font>clear</font>
* 查看内存使用情况
  * <font>free -m</font>：显示内存单位为MB
  * <font>free -h</font>：根据值的大小，显示易于识别的单位
* 关机重启快捷命令
  * <font>shutdown -h now</font>：关机
  * <font>reboot -h now</font>：重启

## 高级命令

* vi
  * 查找字符串：<font>/字符串</font>
  * 显示行号：<font>set nu</font>
  * 复制粘贴：连按<font>yy</font>复制，按<font>p</font>粘贴
  * 快速跳到文件首行：命令模式输入<font>gg</font>
  * 快速跳到文件末行：命令模式输入<font>G</font>
* 日期
  * date命令默认获取系统当前时间
  * <font>date +"%Y-%m-%d %H:%M:%S"</font>：格式化 2026-03-29 21:06:45
  * <font>date +%s</font>：获取时间戳，秒数
  * <font>date +%s"000"</font>：获取毫秒数
  * <font>date --date="2026-01-01 00:00:00" +%s</font>：获取指定时间的时间戳
  * <font>date --date="1 days ago"</font>：获取昨天的日期
  * <font>date --date="1 days ago" +%Y-%m-%d</font>：获取昨天的日期
  * <font>date --date="2021-03-01 1 days ago" +%d</font>：获取2月份的天数
* 进程相关
  * ps：显示进程信息
    * <font>ps -ef | grep java</font>
  * netstat：显示端口信息
    * 安装：<font>yum install -y net-tools</font>
    * <font>netstat -anp</font>
  * jps：显示java进程信息
  * top：动态监视进程信息。包括进程ID、内存占用、CPU占用等
* ip、hostname
  * 设置静态ip地址：<font>/etc/sysconfig/network-scripts/ifcfg-ens33</font>
  * 查看hostname：<font>hostname</font>
  * 设置hostname：
    * 立即生效，重启后就失效了：<font>hostname test</font>
    * 永久 生效：<font>vi /etc/hostname</font>
* 防火墙
  * 查看防火墙状态：<font>status firewalld</font>
  * 关闭防火墙：
    * 临时关闭，重启失效：<font>systemctl stop firewalld</font>
    * 重启生效，永久有效：<font>systemctl disable firewalld</font>
    * 查看开机启动项：<font>systemctl list-unit-files | grep firewalld</font>