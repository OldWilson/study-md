# LocalStack

>doc: https://docs.localstack.cloud/



## 安装

* `python -m pip install localstack `
* `localstack --help`

## 命令

### 启动

1. localstack cli

   * `localstack start`

2. docker

   * `docker run --rm -it -p 4566:4566 -p 4510-4559:4510-4559 localstack/localstack`

3. docker-compose

   * docker-compose.yml

     ```yaml
     version: "3.8"
     
     services:
       localstack:
         container_name: "${LOCALSTACK_DOCKER_NAME-localstack_main}"
         image: localstack/localstack
         ports:
           - "127.0.0.1:4566:4566"            # LocalStack Gateway
           - "127.0.0.1:4510-4559:4510-4559"  # external services port range
           - "127.0.0.1:53:53"                # DNS config (only required for Pro)
           - "127.0.0.1:53:53/udp"            # DNS config (only required for Pro)
           - "127.0.0.1:443:443"              # LocalStack HTTPS Gateway (only required for Pro)
         environment:
           - DEBUG=${DEBUG-}
           - PERSISTENCE=${PERSISTENCE-}
           - LAMBDA_EXECUTOR=${LAMBDA_EXECUTOR-}
           - LOCALSTACK_API_KEY=${LOCALSTACK_API_KEY-}  # only required for Pro
           - DOCKER_HOST=unix:///var/run/docker.sock
         volumes:
           - "${LOCALSTACK_VOLUME_DIR:-./volume}:/var/lib/localstack"
           - "/var/run/docker.sock:/var/run/docker.sock"
     ```

   * `docker-compose up`

   
