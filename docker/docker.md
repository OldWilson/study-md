# docker

## 镜像和容器

### 1. 镜像

1. 介绍

   * Docker image是一个`read-only`文件

   * 这个文件包含文件系统、源码、库文件、依赖及工具等一些运行application所需要的文件

   * 可以理解成一个模版

   * docker image具有分层的概念

### 2. 容器

* “一个运行中的docker image”

* 实质是复制image并在image最上层加上一层`read-write`的层（称之为 container layer，容器层）

* 基于同一个image可以创建多个container

* attached和detached模式

  * ```sh
    docker run -p 80:80 nginx  # attached 打印log
    ```

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
    ```

  * 

### 3. 命令

```sh
# docker
docker version
docker info

# docker image
# 拉取
docker image pull nginx
docker image pull nginx:1.20.0
docker image pull quay.io/bitnami/nginx
# 查看image信息
docker image inspect [id/name]
# 查看
docker image ls
# 删除
docker image rm [id/name]

# 导出
docker image save nginx:1.20.0 -o nginx.image
# 导入
docker image load -i ./nginx.image
# 上传
## 创建tag
docker image tag hello zefeng/hello:1.0
## login
docker login
## push
docker image push zefeng/hello:1.0

# docker container
docker container ls
docker container stop [id/name] / docker stop [name]
docker container run [name] / docker run [name]
docker container rm [name] / docker rm [name]
docker container ps / docker ps
	-a # 显示全部
	-q # 显示id

docker container stop $(docker container ps -qa)


```

## Dockerfile

### 1. command

```sh
# 通过Dockerfile创建image
docker image build -t hello .
# 运行image
docker run -it hello
```



## Docker 存储

## Docker 网络

## Docker Compose

## Docker Swarm

## Docker 多架构

## CICD

## 容器安全



