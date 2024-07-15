# IMAGE

## Mysql
* `docker pull mysql`
* 运行mysql
  ```sh
  docker run \
  --name mysql \
  -d \
  -p 3306:3306 \
  --restart unless-stopped \
  -v /mydata/mysql/log:/var/log/mysql \
  -v /mydata/mysql/data:/var/lib/mysql \
  -v /mydata/mysql/conf:/etc/mysql \
  -e MYSQL_ROOT_PASSWORD=123456 \
  mysql:5.7
  ```

* 错误：`Can't read dir of '/etc/mysql/conf.d/'`

  ```bash
  docker run \
  --name mysql \
  -d \
  -p 3306:3306 \
  --restart unless-stopped \
  -v C:/workspace/dev/mysql/log:/var/log/mysql \
  -v C:/workspace/dev/mysql/data:/var/lib/mysql \
  -v C:/workspace/dev/mysql/conf:/etc/mysql/conf.d \
  -e MYSQL_ROOT_PASSWORD=123456 \
  mysql
  ```




## Redis

* `docker pull redis`

* `docker run -it -d --name redis -p 6379:6379 redis --bind 0.0.0.0 --protected-mode no`

  ```txt
  -p 6379:6379 将容器的6379端口映射到宿主机的6379端口，注意：前面的6379是代表宿主  机端口，后面的6379才是容器端口
  --bind 0.0.0.0 代表谁都可以访问redis服务（任何IP地址）
  --protected-mode no 关闭redis的保护模式，允许其他机器连接Redis，如果设置为yes，那么只允许我们在本机的回环连接，其他机器无法连接
  ```

  
