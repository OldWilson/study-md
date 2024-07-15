# Dynatrace

## Info

### Dynatrace OneAgent

1. 负责收集监控环境中的数据，监控整个堆栈，包括私有云、公共云和混合云的环境。

2. 部署后，OneAgent会自动检测和监视各种主机进程、应用程序、网络和运行状况指标。

   * Web应用程序：OneAgent会自动将JavaScript tag注入到应用程序页面的HTML中。

   * 移动应用程序：需要在移动应用程序包中包含监控库。

3. 新的和更新的应用程序将自动添加到监控解决方案中。  

4. 功能

   * service：

     * OneAgent可以提供有关服务器端服务（Web服务、数据库请求等）的信息。

     * data：
       * OneAgent将传输数据，例如哪些应用程序和服务使用其他服务以及何时对数据进行调用。

     * host和network
       * 主机运行状况指标将收到监视和报告。
       * 网络监控不仅显示每个主机的流量，而且还显示每个进程的流量。

     * error和log
       * 还会跟踪接口错误、TCP错误、质量和连接性。
       * 监视日志文件，并可选择存储数据以进行独立分析。

   * database
     * 数据库监视可显示每个调用、查询和语句的性能。



### Smartscape

1. Smartscape提供了多维的（数据中心、主机、进程、服务和应用程序）动态视图。
   * 实线：表示进程、服务、应用程序和主机之间的活跃关系
   * 虚线：表示未发生任何活动。在处于非活动状态72小时后，线路将从Smartscape中删除。
2. 进程和主机可以显示潜在的漏洞。数据中心、服务和应用程序不会受到这些漏洞的影响。



### Synthetic Monitoring（合成监测）

* 为应用程序提供24 * 7全天候的global visibility
* Types：
  * Single-URL brower monitors（模拟用户访问您的网站，到单个位置）
  * Brower clickpath（一系列点击和用户输入到记录，用于模拟用户在应用程序中的行为）
  * HTTP monitors（用于监控API终端节点或检查单一资源可用性的简单HTTP请求）
* Configuration Options
  * Location and time interval（位置和时间间隔）
  * Device（设备）
  * Performance thresholds（性能阙值）
* Dynatrace使用特定公式计算合成监视器指标值。可用性取决于被视为“正常运行”的时间长度。
  * 正常运行时间（Uptime）是指监视器成功执行的时间，以毫秒为单位，具体为上次成功执行到第一次执行失败之间的时间。
  * 停机时间（Downtime）是指执行失败的时间，直到成功执行监视器。 
  * 可用性百分比：Uptime / (Uptime + Downtime) * 100
  * 监视器的总体可用性是每个位置的可用性百分比之和除以位置数量
* limit
  * 整个监视器的最大超时时间为5分钟，单个事件的最大超时时间为60秒



### Service

* Type
  * Clustered services：同一服务在同一进程组中的多个进程中运行时，表示为在多个进程或主机上运行的单个服务。 
  * Separate services：在多个进程组中监测到同一服务时，表示为单独的服务。
  * Merged services
    * 同一进程组
    * 相同的technology
    * 可能存在于不同节点之间
  * Opaque services（不透明服务）：Dynatrace无法监控的服务，但在其他服务向其发出请求时会被监测到的服务。

### Release Monitoring

* Dynatrace获取最佳版本信息的方式：

  * Environment variables

    ```bash
    set DT_RELEASE_VERSION=<version>
    set DT_RELEASE_BUILD_VERSION=<build-version>
    set DT_RELEASE_PRODUCT=<release-product-name>
    set DT_RELEASE_STAGE=<release-stage>
    ```

  * Kubernates labels

    * 使用kubernetes推荐的已部署Pod的标签来提供相关版本或可选的相关产品的元数据。

  * Event ingestion（事件摄取）

    * 在不想更改环境变量的情况下更新版本信息，可以将自定义部署事件发送到提供版本信息的Dynatrace API。

      ```json
      {
        "eventType": "CUSTOM_DEPLOYMENt",
        "attachRules": {
          "tagRule": {
            "meTypes": "PROCESS_GROUP_INStANCE",
            "tags": "YOUR_TAG"
          }
        },
        "deploymentName": "${CD_JOB_NAME}",
        "deploymentVersion": "1.1",
        "deploymentProject": "YOUR_PRJ",
        "remediationAction": "http://revertMe",
        "ciBackLink": "${BUILD_URL},
        "source": "YOUR_CD_TOOL",
        "customProperties": {
          "Commits": "${GIT_COMMITS}"
        }
      }
      ```



### Database







