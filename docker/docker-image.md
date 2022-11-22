# IMAGE

## Mysql
* `docker pull image`
* 运行mysql
  ```
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