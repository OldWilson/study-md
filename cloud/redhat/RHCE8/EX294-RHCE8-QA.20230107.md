## 重要配置信息

在考试期间，除了您就坐位置的台式机之外，还将使用多个虚拟系统。您不具有台式机系统的 root 访问权，但具有对虚拟系统的完整 root 访问权。

#### 系统信息

在本考试期间，您将操作下列虚拟系统：

|  系统   |    IP 地址     |     Ansible 角色     |
| :-----: | :------------: | :------------------: |
| control | 172.25.250.254 | ansible control node |
|  node1  |  172.25.250.9  | ansible managed node |
|  node2  | 172.25.250.10  | ansible managed node |
|  node3  | 172.25.250.11  | ansible managed node |
|  node4  | 172.25.250.12  | ansible managed node |
|  node5  | 172.25.250.13  | ansible managed node |

这些系统的 IP 地址采用静态设置。请勿更改这些设置。

主机名称解析已配置为解析上方列出的完全限定主机名，同时也解析主机短名称。

#### 帐户信息

所有系统的 root 密码是 `flectrag`。

请勿更改 root 密码。除非另有指定，否则这将是用于访问其他系统和服务的密码。此外，除非另有指定，否则此密码也应用于您创建的所有帐户，或者任何需要设置密码的服务。

为方便起见，所有系统上已预装了 SSH 密钥，允许在不输入密码的前提下通过 SSH 进行 root 访问。请勿对系统上的 root SSH 配置文件进行任何修改。

Ansible 控制节点上已创建了用户帐户 greg。此帐户预装了 SSH 密钥，允许在 Ansible 控制节点和各个 Ansible 受管节点之间进行 SSH 登录。请勿对系统上的 greg SSH 配置文件进行任何修改。您可以从 root 帐户使用 su 访问此用户帐户。

<div style="background: #ffedcc; padding: 12px; line-height: 24px; margin-bottom: 24px;"><b>重要信息</b><br>
除非另有指定，否则您的所有工作（包括 Ansible playbook、配置文件和主机清单等）应当保存在控制节点上的目录 <font style="color: red">/home/greg/ansible</font> 中，并且应当归 greg 用户所有。所有 Ansible 相关的命令应当由 <font style="color: red">greg</font> 用户从 Ansible 控制节点上的这个目录运行。
</div>


#### 其他信息

一些考试项目可能需要修改 Ansible 主机清单。您要负责确保所有以前的清单组和项目保留下来，与任何其他更改共存。您还要有确保清单中所有默认的组和主机保留您进行的任何更改。

`考试系统上的防火墙默认为不启用，SELinux 则处于强制模式。`

如果需要安装其他软件，您的物理系统和 Ansible 控制节点可能已设置为指向 `content` 上的下述存储库：

- http://content/rhel8.0/x86_64/dvd/BaseOS

- http://content/rhel8.0/x86_64/dvd/AppStream

一些项目需要额外的文件，这些文件已在以下位置提供：

- http://materials

产品文档可从以下位置找到：

- http://materials/docs

其他资源也进行了配置，供您在考试期间使用。关于这些资源的具体信息将在需要这些资源的项目中提供。

<div style="background: #ffedcc; padding: 12px; line-height: 24px; margin-bottom: 24px;"><b>重要信息</b><br>
请注意，在评分之前，您的 Ansible 受管节点系统将重置为考试开始时的初始状态，您编写的 Ansible playbook 将通过以 <font style="color: red">greg</font> 用户身份从控制节点上的目录 <font style="color: red">/home/greg/ansible</font> 目录运行来应用。在 playbook 运行后，系统会对您的受管节点进行评估，以判断它们是否按照规定进行了配置。
</div>


<h2>考试要求</h2>
在您的系统上执行以下所有步骤。

[toc]

## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 安装和配置 Ansible
> **安装和配置 Ansible**
>
> 按照下方所述，在控制节点 `control` 上安装和配置 Ansible：
>
> - [ ] 安装所需的软件包
> - [ ] 创建名为 `/home/greg/ansible/inventory` 的静态清单文件，以满足以下要求：
>   - [ ] `node1` 是 `dev` 主机组的成员
>   - [ ] `node2` 是 `test` 主机组的成员
>   - [ ] `node3` 和 `node4` 是 `prod` 主机组的成员
>   - [ ] `node5` 是 `balancers` 主机组的成员
>   - [ ] `prod` 组是 `webservers` 主机组的成员
> - [ ] 创建名为 `/home/greg/ansible/ansible.cfg` 的配置文件，以满足以下要求：
>   - [ ] 主机清单文件为 `/home/greg/ansible/inventory`
>   - [ ] playbook 中使用的角色的位置包括 `/home/greg/ansible/roles`

<div style="background: #dbfaf4; padding: 12px; line-height: 24px; margin-bottom: 24px;">
<dt style="background: #1abc9c; padding: 6px 12px; font-weight: bold; display: block; color: #fff; margin: -12px; margin-bottom: -12px; margin-bottom: 12px;" >Hint - 提示</dt>
  <li> 考试时，给的是主机名
  <li> <b>vars</b>, <b>children</b> 在网页中查
  <li> <b>roles_path</b>, 使用RHEL系统角色
  <li> <b>host_key_checking</b>, ssh ignore yes*5
</div>


<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/vmware.png">**[foundation]**

```bash
$ ssh root@control
```

<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
# su - greg
$ sudo yum -y install ansible
$ rpm -qc ansible
/etc/ansible/ansible.cfg
/etc/ansible/hosts

$ mkdir -p /home/greg/ansible/roles

$ cd /home/greg/ansible
$ cp /etc/ansible/ansible.cfg .
$ vim ansible.cfg
```
```ini
[defaults]
#inventory     = /etc/ansible/hosts
inventory      = /home/greg/ansible/inventory
#host_key_checking = False
host_key_checking = False

#vault_password_file = /path/to/vault_password_file
#vault_password_file = /home/greg/ansible/secret.txt

#roles_path    = /etc/ansible/roles
#roles_path     = /home/greg/ansible/roles
roles_path    = /home/greg/ansible/roles:/usr/share/ansible/roles
...
```
```bash
$ ansible --version
ansible 2.8.0
  config file = `/home/greg/ansible/ansible.cfg`
  ...
$ ansible-galaxy list

$ ansible-doc -l -t inventory
$ ansible-doc -t inventory ini
$ vim /home/greg/ansible/inventory
```
```ini
[dev]
node1 

[test]
node2

[prod]
node3
node4

[balancers]
node5

[webservers:children]
prod 
```

```bash
$ ansible-inventory --graph
$ ansible all -a id
```

> 方法一：greg（当前环境和考试环境ssh免密，sudo免密）
>
> ```bash
> $ vim ansible.cfg
> ```
>
> ```ini
> ...
> [privilege_escalation]
> #become=True
> become=True
> ```
>
> 方法二：root（当前环境 ssh 免密。考试环境，ssh root**不免密**）
>
> ```bash
> $ vim /home/greg/ansible/inventory
> ```
> ```ini
> ...
> [all:vars]
> ansible_user=root
> ansible_password=flectrag
> ```
>
> 方法三：root（当前环境 ssh 免密。考试环境，ssh root**不免密**）
>
> ```bash
> $ vim ansible.cfg
> ```
>
> ```ini
> ...
> [defaults]
> #remote_user = root
> remote_user = root
> ```
>
> ```bash
> $ vim /home/greg/ansible/inventory
> ```
>
> ```ini
> ...
> [all:vars]
> ansible_password=flectrag
> ```

```bash
$ ansible all -a id
```




## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 创建和运行 Ansible 临时命令

> **创建和运行 Ansible 临时命令**
>
> 作为系统管理员，您需要在受管节点上安装软件。
>
> 请按照正文所述，创建一个名为 `/home/greg/ansible/adhoc.sh` 的 shell 脚本，该脚本将使用 Ansible 临时命令在各个受管节点上安装 yum 存储库：
>
> 存储库1：
>
> - [ ] 存储库的名称为 `EX294_BASE`
> - [ ] 描述为 `EX294 base software`
> - [ ] 基础 URL 为 `http://content/rhel8.4/x86_64/dvd/BaseOS`
> - [ ] GPG 签名检查为`启用状态`
> - [ ] GPG 密钥 URL 为 `http://content/rhel8.4/x86_64/dvd/RPM-GPG-KEY-redhat-release`
> - [ ] 存储库为`启用状态`
>
> 存储库2：
>
> - [ ] 存储库的名称为 `EX294_STREAM`
> - [ ] 描述为 `EX294 stream software`
> - [ ] 基础 URL 为 `http://content/rhel8.4/x86_64/dvd/AppStream`
> - [ ] GPG 签名检查为`启用状态`
> - [ ] GPG 密钥 URL 为 `http://content/rhel8.4/x86_64/dvd/RPM-GPG-KEY-redhat-release`
> - [ ] 存储库为`启用状态`

<div style="background: #dbfaf4; padding: 12px; line-height: 24px; margin-bottom: 24px;">
<dt style="background: #1abc9c; padding: 6px 12px; font-weight: bold; display: block; color: #fff; margin: -12px; margin-bottom: -12px; margin-bottom: 12px;" >Hint - 提示</dt>
  <li> 注意 <b>=</b> 等号前后无空格
  <li> 参数表示整体，使用引号
  <li> key对应value的值，存在空格，使用引号
  <li> 参数之间，多个参数使用空格分隔
  <li> <b>gpgkey</b> 查找此参数，<kbd>g</kbd><kbd>g</kbd>, <kbd>/</kbd><strong>key</strong>, <kbd>n</kbd>
</div>


<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ ansible-inventory --graph

$ ansible-doc -l | grep yum
$ ansible-doc yum_repository
/EX
$ ansible-doc setup

$ vim /home/greg/ansible/adhoc.sh
```
```bash
#!/bin/bash

ansible all -m yum_repository -a 'file=EX294_BASE name=EX294_BASE description="EX294 base software" baseurl=http://content/rhel8.4/x86_64/dvd/BaseOS gpgcheck=yes gpgkey=http://content/rhel8.4/x86_64/dvd/RPM-GPG-KEY-redhat-release enabled=yes'

ansible all -m yum_repository -a \
'file=EX294_STREAM \
name=EX294_STREAM \
description="EX294 stream software" \
baseurl=http://content/rhel8.4/x86_64/dvd/AppStream \
gpgcheck=yes \
gpgkey=http://content/rhel8.4/x86_64/dvd/RPM-GPG-KEY-redhat-release \
enabled=yes'

```
```bash
$ chmod +x /home/greg/ansible/adhoc.sh
$ ll /home/greg/ansible/adhoc.sh
$ /home/greg/ansible/adhoc.sh
```

```bash
$ ansible all -a 'yum -y install dnf-utils ftp'
$ ansible all -a 'rpm -q dnf-utils ftp'
...
node1 | CHANGED | rc=0 >>
dnf-utils-4.0.2.2-3.el8.noarch
ftp-0.17-78.el8.x86_64
```



## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 安装软件包
> **安装软件包**
>
> 创建一个名为 `/home/greg/ansible/packages.yml` 的 playbook :
>
> - [ ] 将 `php` 和 `mariadb` 软件包安装到 `dev`、`test` 和 `prod` 主机组中的主机上
> - [ ] 将 `RPM Development Tools` 软件包组安装到 `dev` 主机组中的主机上
> - [ ] 将 `dev` 主机组中主机上的`所有软件包更新为最新版本`

<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ ansible-doc yum

$ vim /home/greg/ansible/packages.yml
```
- 方法一
```yaml
---
- name: 安装软件包1
  hosts: dev,test,prod
  tasks:
  - name: ensure a list of packages installed
    yum:
      name: "{{ packages }}"
    vars:
      packages:
      - php
      - mariadb

- name: 安装软件包2
  hosts: dev
  tasks:
  - name: install the package group
    yum:
      name: "@RPM Development Tools"
      state: present
  - name: upgrade all packages
    yum:
      name: '*'
      state: latest
```
- 方法二
```yaml
---
- name: 安装软件包
  hosts: all 
  tasks:
  - name: install the latest version
    yum:
      name: "{{ item }}"
      state: latest
    loop:
    - php
    - mariadb
    when: inventory_hostname in groups.dev or inventory_hostname in groups.test or inventory_hostname in groups.prod
  - block:
    - name: install the 'Development tools' package group
      yum:
        name: "@RPM Development Tools"
        state: present
    - name: upgrade all packages
      yum:
        name: '*' 
        state: latest
    when: inventory_hostname in groups.dev
```

```bash
$ ansible-playbook packages.yml
```

```bash
$ ansible dev,test,prod -a 'rpm -q php mariadb'
$ ansible dev -a 'yum grouplist'
...
Installed Groups:
   RPM Development Tools
$ ansible dev -a 'yum update'
...
Nothing to do.
```



## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 使用 RHEL 系统角色（NEW）

> **使用 RHEL 系统角色**
>
> 安装 RHEL 系统角色软件包，并创建符合以下条件的 playbook `/home/greg/ansible/selinux.yml` ：
>
> - [ ] 在`所有受管节点`上运行
> - [ ] 使用 `selinux` 角色
> - [ ] 配置该角色，配置被管理节点的selinux为`enforcing`

<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ yum search role

$ sudo yum -y install rhel-system-roles
$ rpm -ql rhel-system-roles 

$ vim ansible.cfg
```

```ini
...
roles_path    = /home/greg/ansible/roles:/usr/share/ansible/roles
```

```bash
$ ansible-galaxy list

$ rpm -ql rhel-system-roles | grep example
$ cp /usr/share/doc/rhel-system-roles/selinux/example-selinux-playbook.yml /home/greg/ansible/selinux.yml

$ vim /home/greg/ansible/selinux.yml
```

```yaml
---
- hosts: all
  vars:
    selinux_policy: targeted
    selinux_state: enforcing
  tasks:
    - name: execute the role and catch errors
      block:
        - include_role:
            name: rhel-system-roles.selinux
      rescue:
        - name: handle errors
          fail:
            msg: "role failed"
          when: not selinux_reboot_required

        - name: restart managed host
          shell: sleep 2 && shutdown -r now "Ansible updates triggered"
          async: 1
          poll: 0
          ignore_errors: true

        - name: wait for managed host to come back
          wait_for_connection:
            delay: 10
            timeout: 300

        - name: reapply the role
          include_role:
            name: rhel-system-roles.selinux
```

```bash
$ ansible-playbook /home/greg/ansible/selinux.yml
```

```bash
$ ansible all -a 'grep ^SELINUX= /etc/selinux/config'
node5 | CHANGED | rc=0 >>
SELINUX=enforcing
node4 | CHANGED | rc=0 >>
SELINUX=enforcing
node2 | CHANGED | rc=0 >>
SELINUX=enforcing
node3 | CHANGED | rc=0 >>
SELINUX=enforcing
node1 | CHANGED | rc=0 >>
SELINUX=enforcing
```



## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 使用 RHEL 系统角色（OLD）

> **使用 RHEL 系统角色**
>
> 安装 RHEL 系统角色软件包，并创建符合以下条件的 playbook `/home/greg/ansible/timesync.yml` ：
>
> - [ ]  在`所有受管节点`上运行
> - [ ]  使用 `timesync` 角色
> - [ ]  配置该角色，以使用当前有效的 NTP 提供商
> - [ ]  配置该角色，以使用时间服务器 `172.25.254.254`
> - [ ]  配置该角色，以启用 `iburst` 参数

<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ yum search role

$ sudo yum -y install rhel-system-roles
$ rpm -ql rhel-system-roles

$ vim ansible.cfg
```
```ini
...
roles_path    = /home/greg/ansible/roles:/usr/share/ansible/roles
```
```bash
$ ansible-galaxy list

$ rpm -ql rhel-system-roles | grep example
$ cp /usr/share/doc/rhel-system-roles/timesync/example-timesync-playbook.yml /home/greg/ansible/timesync.yml

$ vim /home/greg/ansible/timesync.yml
```
```yaml
---
- hosts: all
  vars:
    timesync_ntp_servers:
      - hostname: 172.25.254.254
        iburst: yes
  roles:
    - rhel-system-roles.timesync
```
```bash
$ ansible-playbook /home/greg/ansible/timesync.yml
```
```bash
$ ansible all -m shell -a 'chronyc sources -v | grep classroom'

$ ansible all -m shell -a 'grep ^server /etc/chrony.conf'
$ ansible all -m shell -a 'timedatectl | grep -B 1 NTP'
```



## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 使用 Ansible Galaxy 安装角色
> **使用 Ansible Galaxy 安装角色**
>
> 使用 Ansible Galaxy 和要求文件 `/home/greg/ansible/roles/requirements.yml` 。从以下 URL 下载角色并安装到 `/home/greg/ansible/roles` ：
>
> - [ ] `http://materials/haproxy.tar` 此角色的名称应当为 `balancer`
> - [ ] `http://materials/phpinfo.tar` 此角色的名称应当为 `phpinfo`

<div style="background: #dbfaf4; padding: 12px; line-height: 24px; margin-bottom: 24px;">
<dt style="background: #1abc9c; padding: 6px 12px; font-weight: bold; display: block; color: #fff; margin: -12px; margin-bottom: -12px; margin-bottom: 12px;" >Hint - 提示</dt>
  <li> <b>requirements.yml</b> 格式直接查网页
</div>
<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ vim /home/greg/ansible/roles/requirements.yml
```

```yaml
---
- src: http://materials/haproxy.tar
  name: balancer
- src: http://materials/phpinfo.tar
  name: phpinfo
```

```bash
$ ansible-galaxy install -r /home/greg/ansible/roles/requirements.yml
```

```bash
$ ansible-galaxy list
# /home/greg/ansible/roles
...
- balancer, (unknown version)
- phpinfo, (unknown version)
...
```



## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 创建和使用角色
> **创建和使用角色**
>
> 根据下列要求，在 `/home/greg/ansible/roles` 中创建名为 `apache` 1的角色：
>
> - [ ] httpd 软件包已安装，设为在`系统启动时启用`并`启动`
>
> - [ ] `防火墙`已启用并正在运行，并使用允许访问 `Web` 服务器的规则
>
> - [ ] 模板文件 `index.htmlw.j2` 已存在，用于创建具有以下输出的文件 `/var/www/html/index.html` ：
>
>     ```
>   Welcome to HOSTNAME on IPADDRESS
>   ```
>
>   其中，HOSTNAME 是受管节点的`完全限定域名`，`IPADDRESS` 则是受管节点的 IP 地址。
>
> 创建一个名为 `/home/greg/ansible/apache.yml` 的 playbook：
>
> - [ ] 该 play 在 `webservers` 主机组中的主机上运行并将使用 `apache` 角色

<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ cd roles/
$ ansible-galaxy init apache
$ cd ..
$ ansible-galaxy list

$ vim roles/apache/tasks/main.yml
```
```yaml
---
- name: Start service httpd, if not started
  service:
    name: httpd
    state: started
    enabled: yes
- name: Start service firewalld, if not started
  service:
    name: firewalld
    state: started
    enabled: yes
- firewalld:
    service: http
    permanent: yes
    state: enabled
    immediate: yes
- name: Template a file
  template:
    src: index.html.j2
    dest: /var/www/html/index.html
```
```bash
$ ansible all -m setup | grep node1
$ ansible all -m setup -a 'filter=*ip*'

$ vim roles/apache/templates/index.html.j2
```
```bash
Welcome to {{ ansible_fqdn }} on {{ ansible_default_ipv4.address }}
#Welcome to {{ ansible_nodename }} on {{ ansible_default_ipv4.address }}
```

```bash
$ vim /home/greg/ansible/apache.yml
```

```yaml
---
- name: 创建和使用角色
  hosts: webservers
  roles:
  - apache
```

```bash
$ ansible-playbook /home/greg/ansible/apache.yml
```

<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/vmware.png">**[foundation]**

```bash
$ ansible webservers --list-hosts
  hosts (2):
    node3
    node4

$ curl http://172.25.250.11
Welcome to node3.lab.example.com on 172.25.250.11

$ curl http://172.25.250.12
Welcome to node4.lab.example.com on 172.25.250.12
```




## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 从 Ansible Galaxy 使用角色
> **从 Ansible Galaxy 使用角色**
>
> 根据下列要求，创建一个名为 `/home/greg/ansible/roles.yml` 的 playbook ：
>
> - [x] playbook 中包含一个 play， 该 play 在 `balancers` 主机组中的主机上运行并将使用 `balancer` 角色。
>
>   - [ ] 此角色配置一项服务，以在 `webservers` 主机组中的主机之间平衡 Web 服务器请求的负载。
>
>   - [ ] 浏览到 `balancers` 主机组中的主机（例如 `http://172.25.250.13` ）将生成以下输出：
>
>     ```
>     Welcome to node3.lab.example.com on 172.25.250.11
>     ```
>
>   - [ ] 重新加载浏览器将从另一 Web 服务器生成输出：
>
>     ```
>     Welcome to node4.lab.example.com on 172.25.250.12
>     ```
>
> - [x] playbook 中包含一个 play， 该 play 在 `webservers` 主机组中的主机上运行并将使用 `phpinfo` 角色。
>
>   - [ ] 请通过 URL `/hello.php` 浏览到 `webservers` 主机组中的主机将生成以下输出：
>
>     ```
>     Hello PHP World from FQDN
>     ```
>
>    - [ ] 其中，FQDN 是主机的完全限定名称。
>
>      ```
>      Hello PHP World from node3.lab.example.com
>      ```
>   
>
> 另外还有 PHP 配置的各种详细信息，如安装的 PHP 版本等。
>
> - [x] 同样，浏览到 `http://172.25.250.12/hello.php` 会生成以下输出：
>
>      ```
>      Hello PHP World from node4.lab.example.com
>      ```
>
>
>  另外还有 PHP 配置的各种详细信息，如安装的 PHP 版本等。

<div style="background: #dbfaf4; padding: 12px; line-height: 24px; margin-bottom: 24px;">
<dt style="background: #1abc9c; padding: 6px 12px; font-weight: bold; display: block; color: #fff; margin: -12px; margin-bottom: -12px; margin-bottom: 12px;" >Hint - 提示</dt>
  <li> <b>roles</b> 角色关键词直接查网页
</div>
<div style="background: #f0f0f0; padding: 12px; line-height: 24px; margin-bottom: 24px;">
<dt style="background: #ee0000; padding: 6px 12px; font-weight: bold; display: block; color: #fff; margin: -12px; margin-bottom: -12px; margin-bottom: 12px;" >Important - 重要</dt>
1. 第一个play, webservers；第二个play, balancers<br>
2. apache已经启动，安装php后，需要重启
</div>


<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ vim /home/greg/ansible/roles.yml
```
```yaml
---
- name: 从 Ansible Galaxy 使用角色 1
  hosts: webservers
  roles:
  - phpinfo

- name: 从 Ansible Galaxy 使用角色 2
  hosts: balancers
  roles:
  - balancer
```
```bash
$ ansible-playbook roles.yml
```
<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/vmware.png">**[foundation]**

```bash
$ curl http://172.25.250.13
Welcome to node3.lab.example.com on 172.25.250.11

$ curl http://172.25.250.13
Welcome to node4.lab.example.com on 172.25.250.12
```

<kbd>🦊firefox</kbd>

- `http://172.25.250.11/hello.php`
- `http://172.25.250.12/hello.php`



## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 创建和使用分区（NEW）

> **创建和使用分区**
>
> 创建一个名为 `/home/greg/ansible/partition.yml` 的 playbook ，它将在`所有受管节点`上创建分区：
>
> - [ ] 在`vdb`创建一个`1500M`主分区，分区号`1`，并格式化`ext4`
>   - [ ] `prod`组将分区永久挂载到`/data`
> - [ ] 如果磁盘空间不够，
>   - [ ] 给出提示信息`Could not create partition of that size`
>   - [ ] 创建`800MiB`分区
> - [ ] 如果 vdb不存在，则给出提示信息`this disk is not exist`

<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ vim /home/greg/ansible/partition.yml
```

```yaml
---
- name: 创建和使用分区
  hosts: all 
  tasks:
  - block:
    - name: Create a new primary partition
      parted:
        device: /dev/vdb
        number: 1
        state: present
        part_end: 1500MiB
    - name: Create a ext4 filesystem
      filesystem:
        fstype: ext4
        dev: /dev/vdb1
    - block:
      - name: Create a directory if it does not exist
        file:
          path: /data
          state: directory
      - name: Mount and bind a volume
        mount:
          path: /data
          src: /dev/vdb1
          fstype: ext4
          state: mounted
      when: inventory_hostname in groups.prod
    rescue:
    - debug:
        msg: Could not create partition of that size
    - name: Create a new primary partition
      parted:
        device: /dev/vdb
        number: 1
        state: present
        part_end: 800MiB
    when: ansible_devices.vdb is defined
  - debug:
      msg: this disk is not exist
    when: ansible_devices.vdb is not  defined
    
    
 方法二：
---
- name: 创建和使用分区
  hosts: all 
  tasks:
  - block:
    - name: 在vdb创建一个1500M主分区，分区号1，并格式化ext4
      parted:
        device: /dev/vdb
        number: 1
        state: present
        part_end: 1500MiB
    - name: Create a ext4
      filesystem:
        fstype: ext4
        dev: /dev/vdb1
    - name: prod组将分区永久挂载到/data
      mount:
        path: /mnt/data
        src: /dev/vdb1
        fstype: ext4
        state: mounted
      when: inventory_hostname in groups.prod
    rescue:
    - debug:
        msg: Could not create partition of that size
    - name: 创建800MiB分区
      parted:
        device: /dev/vdb
        number: 1
        state: present
        part_end: 800MiB
    when: ansible_devices.vdb is defined
  - name: 如果 vdb不存在，则给出提示信息this disk is not exist
    debug:
      msg: this disk is not exist
    when: ansible_devices.vdb is undefined

```

```bash
$ ansible-playbook /home/greg/ansible/partition.yml
```

```bash
$ ansible all -m shell -a 'lsblk'
$ ansible all -m shell -a 'blkid'
$ ansible dev -m shell -a 'cat /etc/fstab'
```



## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 创建和使用逻辑卷（OLD）

> **创建和使用逻辑卷**
>
> 创建一个名为 `/home/greg/ansible/lv.yml` 的 playbook ，它将在`所有受管节点`上运行以执行下列任务：
>
> - [ ] 创建符合以下要求的逻辑卷：
>
>   - [x] 逻辑卷创建在 `research` 卷组中
>   - [x] 逻辑卷名称为 `data`
>   - [x] 逻辑卷大小为 `1500 MiB`
>
> - [ ] 使用 `ext4` 文件系统格式化逻辑卷
>
> - [x] 如果无法创建请求的逻辑卷大小，应显示错误信息
>
>     ```
>     Could not create logical volume of that size
>     ```
>
>      ，并且应改为使用大小 `800 MiB`。
>
> - [x] 如果卷组 `research` 不存在，应显示错误信息
>
>     ```
>     Volume group done not exist
>     ```
>
>     。
>
> - [ ] 不要以任何方式挂载逻辑卷

<div style="background: #dbfaf4; padding: 12px; line-height: 24px; margin-bottom: 24px;">
<dt style="background: #1abc9c; padding: 6px 12px; font-weight: bold; display: block; color: #fff; margin: -12px; margin-bottom: -12px; margin-bottom: 12px;" >Hint - 提示</dt>
  <li> <b>block</b>, <b>rescue</b>; <b>ignore_errors</b> 关键词查网页
  <li> <b>setup</b> 模块查变量名
  <li> 最后注意看输出提示，是否符合题意
</div>
<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ ansible-doc lvol
$ ansible-doc filesystem
$ ansible-doc debug

$ ansible-doc stat
$ ansible all -m setup -a 'filter=*lvm*'

$ vim /home/greg/ansible/lv.yml
```
```yaml
---
- name: 创建和使用逻辑卷
  hosts: all 
  tasks:
  - block:
    - name: Create a logical volume
      lvol:
        vg: research
        lv: data
        size: 1500
    - name: Create a ext4 filesystem
      filesystem:
        fstype: ext4
        dev: /dev/research/data
    rescue:
    - debug:
        msg: Could not create logical volume of that size
    - name: Create a logical volume
      lvol:
        vg: research
        lv: data
        size: 800 
    when: ansible_lvm.vgs.research is defined
  - debug:
      msg: Volume group done not exist
    when: ansible_lvm.vgs.research is not defined
```
```bash
$ ansible-playbook /home/greg/ansible/lv.yml

PLAY [创建和使用逻辑卷] *************************************************************************

TASK [Gathering Facts] ******************************************************************
ok: [node2]
ok: [node5]
ok: [node4]
ok: [node3]
ok: [node1]

TASK [Create a logical volume] **********************************************************
skipping: [node1]
 [WARNING]: The value 1500 (type int) in a string field was converted to '1500' (type string). If this does not look like what you expect, quote the entire value to ensure it does not change.

fatal: [node3]: FAILED! => {"changed": false, "err": "  Volume group \"research\" has insufficient free space (255 extents): 375 required.\n", "msg": "Creating logical volume 'data' failed", "rc": 5}
changed: [node2]
changed: [node4]
changed: [node5]

TASK [Create a ext4 filesystem] *********************************************************
skipping: [node1]
changed: [node2]
changed: [node4]
changed: [node5]

TASK [debug] ****************************************************************************
ok: [node3] => {
    "msg": "Could not create logical volume of that size"
}

TASK [Create a logical volume] **********************************************************
 [WARNING]: The value 800 (type int) in a string field was converted to '800' (type string). If this does not look like what you expect, quote the entire value to ensure it does not change.

changed: [node3]

TASK [debug] ****************************************************************************
ok: [node1] => {
    "msg": "Volume group done not exist"
}
skipping: [node2]
skipping: [node5]
skipping: [node3]
skipping: [node4]

PLAY RECAP ******************************************************************************
node1 : ok=2    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
node2 : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   
node3 : ok=3    changed=1    unreachable=0    failed=0    skipped=1    rescued=1    ignored=0   
node4 : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   
node5 : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0 
```

```bash
$ ansible all -m shell -a 'lvs'
$ ansible all -m shell -a 'blkid /dev/research/data'
```



## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 生成主机文件
> **生成主机文件**
>
> - [ ] 将一个初始模板文件从 `http://materials/hosts.j2` 下载到 `/home/greg/ansible`
> - [ ] 完成该模板，以便用它生成以下文件：针对每个清单主机包含一行内容，其格式与 `/etc/hosts` 相同
> - [ ] 创建名为 `/home/greg/ansible/hosts.yml` 的 playbook ，它将使用此模板在 `dev` 主机组中的主机上生成文件 `/etc/myhosts` 。
>
> 该 playbook 运行后， `dev` 主机组中主机上的文件 `/etc/myhosts` 应针对每个受管主机包含一行内容：
>
> ```
> 127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4
> ::1 localhost localhost.localdomain localhost6 localhost6.localdomain6
> 
> 172.25.250.9    node1.lab.example.com node1
> 172.25.250.10   node2.lab.example.com node2
> 172.25.250.11   node3.lab.example.com node3
> 172.25.250.12   node4.lab.example.com node4
> 172.25.250.13   node5.lab.example.com node5
> ```
>
> **注：清单主机名称的显示顺序不重要。**

<div style="background: #dbfaf4; padding: 12px; line-height: 24px; margin-bottom: 24px;">
<dt style="background: #1abc9c; padding: 6px 12px; font-weight: bold; display: block; color: #fff; margin: -12px; margin-bottom: -12px; margin-bottom: 12px;" >Hint - 提示</dt>
  <li> 网页查 <b>endfor</b>, <b>filter</b>
  <li> 第一次要通过具体的数值查 <b>变量名</b>
</div>
<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ ansible dev -m debug -a 'var=groups'
$ ansible dev -m debug -a "var=groups['all']"

$ wget http://materials/hosts.j2
$ vim hosts.j2
```
- 第一次
```jinja2
{% for host in groups['all'] %}
{{ hostvars[host]['ansible_facts'] | to_nice_yaml }}
{% endfor %}
```
```bash
$ vim hosts.yml
```
```yaml
---
- name: 生成主机文件
  hosts: all 
  tasks:
  - name: Template a file to /etc/myhosts
    template:
      src: /home/greg/ansible/hosts.j2
      dest: /etc/myhosts
    when: inventory_hostname in groups.dev
#   when: '"dev" in group_names'
```
```bash
$ ansible-playbook hosts.yml 
```

<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[root@node1]**

```bash
# vim /etc/myhosts
/172.25.250.9
/node1.lab.example.com
/node1
```
<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ vim host.j2
```
- 第二次
```jinja2
127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4
::1 localhost localhost.localdomain localhost6 localhost6.localdomain6
{% for host in groups['all'] %}
{{ hostvars[host]['ansible_facts']['default_ipv4']['address'] }} {{ hostvars[host]['ansible_facts']['fqdn'] }} {{ hostvars[host]['ansible_facts']['hostname'] }}
{% endfor %}
```
```bash
$ ansible-playbook hosts.yml 
```
```bash
$ ansible dev -m shell -a 'cat /etc/myhosts'
```



## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 修改文件内容
> **修改文件内容**
>
> 按照下方所述，创建一个名为 `/home/greg/ansible/issue.yml` 的 playbook ：
>
> - [ ] 该 playbook 将在`所有清单主机`上运行
> - [ ] 该 playbook 会将 `/etc/issue` 的内容替换为下方所示的一行文本：
>   - [ ] 在 `dev` 主机组中的主机上，这行文本显示 为：`Development`
>   - [ ] 在 `test` 主机组中的主机上，这行文本显示 为：`Test`
>   - [ ] 在 `prod` 主机组中的主机上，这行文本显示 为：`Production`

<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ ansible dev -m debug -a 'var=inventory_hostname'
$ ansible dev -m debug -a 'var=groups'
$ ansible dev -m debug -a 'var=groups.dev'

$ ansible-doc copy
$ ansible-doc stat

$ vim /home/greg/ansible/issue.yml
```
```yaml
---
- name: 修改文件内容
  hosts: all
  tasks:
  - name: Copy using inline content 1
    copy:
      content: 'Development'
      dest: /etc/issue
    when: inventory_hostname in groups.dev
  - name: Copy using inline content 2
    copy:
      content: 'Test'
      dest: /etc/issue
    when: inventory_hostname in groups.test
  - name: Copy using inline content 3
    copy:
      content: 'Production'
      dest: /etc/issue
    when: inventory_hostname in groups.prod
```
```bash
$ ansible-playbook /home/greg/ansible/issue.yml
```
```bash
$ ansible dev -a 'cat /etc/issue'
$ ansible test -a 'cat /etc/issue'
$ ansible prod -a 'cat /etc/issue'
```



## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 创建 Web 内容目录
> **创建 Web 内容目录**
>
> 按照下方所述，创建一个名为 `/home/greg/ansible/webcontent.yml` 的 playbook ：
>
> - [ ] 该 playbook 在 `dev` 主机组中的受管节点上运行
>
> - [ ] 创建符合下列要求的目录` /webdev `：
>
>   - [ ] 所有者为 `webdev` 组
>   - [ ] 具有常规权限：`owner=read+write+execute， group=read+write+execute，other=read+execute`
>   - [ ] 具有`特殊权限`：设置组 ID
>
> - [ ] 用符号链接将 `/var/www/html/webdev` 链接到 `/webdev`
>
> - [ ] 创建文件 `/webdev/index.html` ，其中包含如下所示的单行文件： `Development`
>
> - [ ] 在 `dev` 主机组中主机上浏览此目录（例如 `http://172.25.250.9/webdev/` ）将生成以下输出：
>
>     ```
>     Development
>     ```

<div style="background: #dbfaf4; padding: 12px; line-height: 24px; margin-bottom: 24px;">
<dt style="background: #1abc9c; padding: 6px 12px; font-weight: bold; display: block; color: #fff; margin: -12px; margin-bottom: -12px; margin-bottom: 12px;" >Hint - 提示</dt>
  <li> 隐藏考点，文件的上下文关系
</div>
<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ ansible-doc file
$ ansible-doc copy

$ ansible dev -a 'ls -ldZ /var/www/html'
-rw-r--r--. 1 root root system_u:object_r:`httpd_sys_content_t`:s0 11 Apr 14 07:11 /var/www/html
```

```bash
$ vim /home/greg/ansible/webcontent.yml
```
```yaml
---
- name: 创建 Web 内容目录
  hosts: dev
  roles:
  - apache
  tasks:
  - name: Create a directory if it does not exist
    file:
      path: /webdev
      state: directory
      group: webdev
      mode: u=rwx,g=rwxs,o=rx
#     mode: '2775'
  - name: Create a symbolic link
    file:
      src: /webdev
      dest: /var/www/html/webdev
      state: link
  - name: Copy using inline content
    copy:
      content: 'Development'
      dest: /webdev/index.html
      group: webdev
      setype: httpd_sys_content_t
#  - name: Start service httpd, if not started
#    service:
#      name: httpd
#      state: started
#      enabled: yes
```
```bash
$ ansible-playbook /home/greg/ansible/webcontent.yml
```

<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.9|workstation]**

```bash
$ curl http://172.25.250.9/webdev/

$ ansible node1 -a 'systemctl status httpd'
$ ansible node1 -a 'cat /webdev/index.html'
$ ansible node1 -a 'ls -l /var/www/html'
```



## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 生成硬件报告
> **生成硬件报告**
>
> 创建一个名为 `/home/greg/ansible/hwreport.yml` 的 playbook ，它将在所有受管节点上生成含有以下信息的输出文件 `/root/hwreport.txt` ：
>
> - [ ] `清单主机名称`
> - [ ] 以 `MB` 表示的`总内存大小`
> - [ ] `BIOS 版本`
> - [ ] 磁盘设备 `vda 的大小`
> - [ ] 磁盘设备 `vdb 的大小`
> - [ ] 输出文件中的每一行含有一个 key=value 对
>
> 您的 playbook 应当：
>
> - [ ] 从 `http://materials/hwreport.empty` 下载文件，并将它保存为 `/root/hwreport.txt`
> - [ ] 使用`正确的值`改为 /root/hwreport.txt
> - [ ] 如果硬件项不存在，相关的值应设为 `NONE`

<div style="background: #dbfaf4; padding: 12px; line-height: 24px; margin-bottom: 24px;">
<dt style="background: #1abc9c; padding: 6px 12px; font-weight: bold; display: block; color: #fff; margin: -12px; margin-bottom: -12px; margin-bottom: 12px;" >Hint - 提示</dt>
  <li> 网页查 <b>清单主机名</b>，<b>default</b>
</div>
<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ ansible all -m setup | grep mem
$ ansible all -m setup | grep bios
$ ansible all -m setup -a 'filter=*device*'

$ ansible-doc -l | grep -i download
$ ansible-doc get_url
$ ansible-doc lineinfile

$ vim /home/greg/ansible/hwreport.yml
```
- 方法一
```yaml
---
- name: 生成硬件报告
  hosts: all 
  tasks:
  - name: Download foo.conf
    get_url:
      url: http://materials/hwreport.empty
      dest: /root/hwreport.txt
  - name: Ensure 1
    lineinfile:
      path: /root/hwreport.txt
      regexp: '^HOST='
      line: HOST={{ inventory_hostname }}
  - name: Ensure 2
    lineinfile:
      path: /root/hwreport.txt
      regexp: '^MEMORY='
      line: MEMORY={{ ansible_memtotal_mb }}
  - name: Ensure 3
    lineinfile:
      path: /root/hwreport.txt
      regexp: '^BIOS='
      line: BIOS={{ ansible_bios_version }}
  - name: Ensure 4
    lineinfile:
      path: /root/hwreport.txt
      regexp: '^DISK_SIZE_VDA='
      line: DISK_SIZE_VDA={{ ansible_devices.vda.size }}
  - name: Ensure 5
    lineinfile:
      path: /root/hwreport.txt
      regexp: '^DISK_SIZE_VDB='
      line: DISK_SIZE_VDB={{ ansible_devices.vdb.size | default('NONE', true) }}
```
- 方法二
```yaml
---
- name: 生成硬件报告
  hosts: all 
  vars:
    hw_all:
    - hw_name: HOST
      hw_cont: "{{ inventory_hostname }}"
    - hw_name: MEMORY
      hw_cont: "{{ ansible_memtotal_mb }}"
    - hw_name: BIOS
      hw_cont: "{{ ansible_bios_version }}"
    - hw_name: DISK_SIZE_VDA
      hw_cont: "{{ ansible_devices.vda.size }}"
    - hw_name: DISK_SIZE_VDB
      hw_cont: "{{ ansible_devices.vdb.size | default('NONE', true) }}"
  tasks:
  - name: 1
    get_url:
      url: http://materials/hwreport.empty
      dest: /root/hwreport.txt 
  - name: 2
    lineinfile:
      path: /root/hwreport.txt
      regexp: '^{{ item.hw_name }}='
      line: "{{ item.hw_name }}={{ item.hw_cont }}"
    loop: "{{ hw_all }}"
```
```bash
$ ansible-playbook /home/greg/ansible/hwreport.yml
```
```bash
$ ansible all -a 'cat /root/hwreport.txt'
```



## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 创建密码库
> **创建密码库**
>
> 按照下方所述，创建一个 Ansible 库来存储用户密码：
>
> - [ ] 库名称为 `/home/greg/ansible/locker.yml`
> - [ ] 库中含有两个变量，名称如下：
>   - [ ] `pw_developer`，值为 `Imadev`
>   - [ ] `pw_manager`，值为 `Imamgr`
> - [ ] 用于加密和解密该库的密码为 `whenyouwishuponastar`
> - [ ] 密码存储在文件 `/home/greg/ansible/secret.txt` 中

<div style="background: #dbfaf4; padding: 12px; line-height: 24px; margin-bottom: 24px;">
<dt style="background: #1abc9c; padding: 6px 12px; font-weight: bold; display: block; color: #fff; margin: -12px; margin-bottom: -12px; margin-bottom: 12px;" >Hint - 提示</dt>
  <li> 做完最后一题，再做这个题
</div>
<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ vim ansible.cfg
```

```ini
...
vault_password_file = /home/greg/ansible/secret.txt
```

```bash
$ echo whenyouwishuponastar > /home/greg/ansible/secret.txt

$ ansible-vault create /home/greg/ansible/locker.yml
```
```yaml
---
pw_developer: Imadev
pw_manager: Imamgr
```
```bash
$ ansible-vault view /home/greg/ansible/locker.yml
---
pw_developer: Imadev
pw_manager: Imamgr

$ cat /home/greg/ansible/locker.yml
...
```



## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 创建用户帐户
> **创建用户帐户**
>
> - [ ] 从 `http://materials/user_list.yml` 下载要创建的用户的列表，并将它保存到 `/home/greg/ansible`
> - [ ] 在本次考试中使用在其他位置创建的密码库 `/home/greg/ansible/locker.yml` 。创建名为 `/home/greg/ansible/users.yml` 的 playbook ，从而按以下所述创建用户帐户：
>   - [ ] 职位描述为 `developer` 的用户应当：
>     - [ ] 在 `dev` 和 `test` 主机组中的受管节点上创建
>     - [ ] 从 `pw_developer` 变量分配密码
>     - [ ] 是补充组 `devops` 的成员
>   - [ ] 职位描述为 `manager` 的用户应当：
>     - [ ] 在 `prod` 主机组中的受管节点上创建
>     - [ ] 从 `pw_manager` 变量分配密码
>     - [ ] 是补充组 `opsmgr` 的成员
> - [ ] 密码采用 `SHA512` 哈希格式。
> - [ ] 您的 playbook 应能够在本次考试中使用在其他位置创建的库密码文件 `/home/greg/ansible/secret.txt` 正常运行。

<div style="background: #dbfaf4; padding: 12px; line-height: 24px; margin-bottom: 24px;">
<dt style="background: #1abc9c; padding: 6px 12px; font-weight: bold; display: block; color: #fff; margin: -12px; margin-bottom: -12px; margin-bottom: 12px;" >Hint - 提示</dt>
  <li> 网页查关键词 <b>vars_files</b>，或模块 <b>include_vars</b> 都可以指向变量文件
  <li> 循环变量名就是 <b>item</b>
  <li> 加密密码查网页 <b>filter</b>
</div>

<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ wget http://materials/user_list.yml
$ vim /home/greg/ansible/users.yml
```
- 方法一
```yaml
---
- name: 创建用户帐户 1
  hosts: dev,test
  vars_files:
  - /home/greg/ansible/locker.yml
  - /home/greg/ansible/user_list.yml
  tasks:
  - name: Ensure group 1
    group:
      name: devops
      state: present
  - name: Add the user 1
    user:
      name: "{{ item.name }}"
      groups: devops
      password: "{{ pw_developer | password_hash('sha512') }}"
      append: yes
    loop: "{{ users }}"
    when: item.job == 'developer'

- name: 创建用户帐户 2
  hosts: prod
  vars_files:
  - /home/greg/ansible/locker.yml
  - /home/greg/ansible/user_list.yml
  tasks:
  - name: Ensure group 2
    group:
      name: opsmgr
      state: present
  - name: Add the user 2
    user:
      name: "{{ item.name }}"
      groups: opsmgr
      password: "{{ pw_manager | password_hash('sha512') }}"
      append: yes
    loop: "{{ users }}"
    when: item.job == 'manager'
```
- 方法二
```yaml
---
- name: 创建用户帐户
  hosts: all
  vars_files:
  - /home/greg/ansible/locker.yml
  - /home/greg/ansible/user_list.yml
  tasks:
  - name: Ensure group1
    group:
      name: devops
    loop: "{{ users }}"
    when: inventory_hostname in groups.dev or inventory_hostname in groups.test
  - name: Add the user1
    user:
      name: "{{ item.name }}"
      password: "{{ pw_developer | password_hash('sha512', 'mysecretsalt') }}"
      groups: devops
    loop: "{{ users }}"
    when: item.job == 'developer' and (inventory_hostname in groups.dev or inventory_hostname in groups.test)

  - name: Ensure group2
    group:
      name: opsmgr
    loop: "{{ users }}"
    when: inventory_hostname in groups.prod
  - name: Add the user2
    user:
      name: "{{ item.name }}"
      password: "{{ pw_manager | password_hash('sha512', 'mysecretsalt') }}"
      groups: opsmgr
    loop: "{{ users }}"
    when: item.job == 'manager' and inventory_hostname in groups.prod
```

```bash
$ ansible-playbook /home/greg/ansible/users.yml
```

```bash
$ ansible dev,test -m shell -a 'id bob; id sally; id fred'
$ ssh bob@172.25.250.9
bob@172.25.250.9\'s password: `Imadev`
<Ctrl-D>
$ ansible prod -m shell -a 'id fred; id bob;  id sally'
$ ssh sally@172.25.250.12
sally@172.25.250.12\'s password: `Imamgr`
<Ctrl-D>
```



## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 更新 Ansible 库的密钥
> **更新 Ansible 库的密钥**
>
> 按照下方所述，更新现有 Ansible 库的密钥：
>
> - [ ] 从 `http://materials/salaries.yml` 下载 Ansible 库到 `/home/greg/ansible`
> - [ ] 当前的库密码为 `insecure8sure`
> - [ ] 新的库密码为 `bbs2you9527`
> - [ ] 库使用`新密码`保持加密状态

<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ wget http://materials/salaries.yml

$ ansible-vault rekey salaries.yml
Vault password: `insecure8sure`
New Vault password: `bbs2you9527`
Confirm New Vault password: `bbs2you9527`
Rekey successful
```

```bash
$ ansible-vault view salaries.yml
Vault password: `bbs2you9527`
haha

$ ansible-vault view --ask-vault-pass salaries.yml
Vault password: `bbs2you9527`
haha
```

<div style="background: #f0f0f0; padding: 12px; line-height: 24px; margin-bottom: 24px;">
<dt style="background: #ee0000; padding: 6px 12px; font-weight: bold; display: block; color: #fff; margin: -12px; margin-bottom: -12px; margin-bottom: 12px;" >Important - 重要</dt>
<li>vault 实验，先做最后一题，再做倒数第三题`创建密码库`
<li>如果已经修改了配置文件，验证时需使用<b>--ask-vault-pass</b>
</div>


## ○ <font style="font-size:80%">复查</font> ○ <font style="font-size:80%">完成</font> 配置 cron 作业

> **配置 cron 作业**
>
> 创建一个名为 `/home/greg/ansible/cron.yml` 的 playbook :
>
> - [ ] 该 playbook 在 `test` 主机组中的受管节点上运行
>
> - [ ] 配置 `cron` 作业，该作业`每隔 2 分钟`运行并执行以下命令：
>
>   `logger "EX200 in progress"`，以用户 `bob` 身份运行
>

<img width=35 src="https://gitee.com/suzhen99/redhat/raw/master/images/virt-viewer.png">**[172.25.250.254|control]**

```bash
$ ansible-doc cron

$ vim /home/greg/ansible/cron.yml
```

```yaml
---
- name: cron
  hosts: test
  tasks:
  - name: Ensure a job 
    cron:
      name: "check dirs"
      minute: "*/2"
      job: 'logger "EX200 in progress"'
      user: bob
```

```bash
$ ansible-playbook /home/greg/ansible/cron.yml
```

```bash
$ ansible test -a 'crontab -l -u bob'
node2 | CHANGED | rc=0 >>
#Ansible: check dirs
*/2 * * * * logger "EX200 in progress"

$ ansible test -a 'grep EX200 /var/log/messages'
node2 | CHANGED | rc=0 >>
...
Aug 27 20:26:02 node2 bob[3626]: EX200 in progress
Aug 27 20:28:01 node2 bob[3867]: EX200 in progress
```

