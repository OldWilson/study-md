# docker

## 镜像和容器

### 1. 镜像

1. 介绍

   * Docker image是一个`read-only`文件
   * 这个文件包含文件系统、源码、库文件、依赖及工具等一些运行application所需要的文件
   * 可以理解成一个模版
   * docker image具有分层的概念
   
2. 通过commit创建镜像

3. scratch镜像

   * 空的Docker镜像

   * ```dockerfile
     FROM scratch
     ADD hello /
     CMD ["hello"]
     ```


### 2. 容器

* “一个运行中的docker image”

* 容器其实是进程

* 实质是复制image并在image最上层加上一层`read-write`的层（称之为 container layer，容器层）

* 基于同一个image可以创建多个container

* 容器运行模式

  * attached模式：

    * 容器在前台执行
    * `docker run -p 80:80 nginx  # attached 打印log`

  * detached模式

    * 容器在后台执行

    * ```sh
      docker run -d -p 80:80 nginx # detached 后台运行
      docker attach [id]  #再次attched
      ```

  * 交互式模式

    * ```sh
      docker container run -d -p 80:80 nginx # detached
      docker container logs [id] # 查看log
      docker container logs -f [id] # 动态监控log
      ```

    * ```sh
      docker container run -it ubuntu sh # 可以进入ubuntu进行sh输入，退出后，容器会停止
      ```

    * ```sh
      docker container run -d -p 80:80 nginx # detached
      docker container exec -it [id/name] sh # 可以进入后台运行的container，且退出后容器不会停止

### 3. 命令

```sh
# docker
docker version
docker info

# docker image
## 拉取
docker image pull nginx
docker image pull nginx:1.20.0
docker image pull quay.io/bitnami/nginx
## 查看image信息
docker image inspect [id/name]
## 查看
docker image ls
## 删除
docker image rm [id/name]
docker image prune -a

## 导出
docker image save nginx:1.20.0 -o nginx.image
## 导入
docker image load -i ./nginx.image
## 上传
## 创建tag
docker image tag hello zefeng/hello:1.0
## login
docker login
## push
docker image push zefeng/hello:1.0

# docker container
## 容器停止
docker container stop [id/name] / docker stop [name]
## 容器创建
docker container run [name] / docker run [name]
## 容器删除
docker container rm [name] / docker rm [name]
## 容器一览
docker container ls / docker container ps / docker ps
	-a # 显示全部
	-q # 显示id
## 批量停止
docker container stop $(docker container ps -aq)
## 批量删除
docker container rm $(docker container ps -aq)

## 可以快速对系统进行清理，删除停止的容器，不用的image等等。
docker system prune -f
```

## Dockerfile

### 1. command

```sh
# 通过Dockerfile创建image
docker image build -t hello .
# 运行image
docker run -it hello
```

### 2. 文件构成

- FROM

  - 基础镜像的选择

- RUN

  * 主要用于Image里执行命令

  * 每一行的RUN命令都会产生一层image layer，导致镜像的臃肿

- ADD，COPY，WORKDIR

  * COPY和ADD都可以把本地文件复制到镜像中，如果目标目录不存在，则会自动创建

  * ADD：如果复制的文件是一个gzip等压缩文件时，ADD会自动去解压缩文件

- ARG，ENV

  * ARG可以在镜像build的时候动态修改value，通过`--build-arg`

  * ```dockerfile
    ENV VERSION=1.0.1
    ARG VERSION=1.0.1
    ```

  * ```dockerfile
    docker image build -f .\Dockerfile -t hello --build-arg VERSION=1.0.2 .
    ```

  * ENV设置的变量可以在image中保持，并在容器中的环境变量里


* CMD

  * 用来设置容器启动时默认会执行的命令

  * 如果docker container run 启动容器时指定了其他命令，则CMD命令会被忽略

  * 如果定义了多个CMD，只有最后有一个会被执行


* ENTRYPOINT

  * 可以设置容器启动时要执行的命令


  * ENTRYPOINT设置的命令，一定会被执行


  * 命令格式

    * shell格式

      * ```dockerfile
        CMD echo "hello docker"
        CMD echo "hello $NAME"
        
        ENTRYPOINT echo "hello docker"
        ```

    * exec格式

      * ```dockerfile
        CMD ["echo", "hello docker"]
        CMD ["sh", "-c", "echo hello $NAME"]
        
        ENTRYPOINT ["echo", "hello docker"]
        ```

        


## Docker 存储

## Docker 网络

## Docker Compose

## Docker Swarm

## Docker 多架构

## CICD

## 容器安全



