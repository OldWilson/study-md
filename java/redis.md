# redis

## 基础

1. 什么是Redis？
   * Remote Dictionary.Server。本质上是一个Key-Server类型的内存数据库。
   * 因为是纯内存操作，redis的性能非常出色，每秒可以处理超过10万次读写操作，是已知性能最快的Key-Value DB。
   * 单个value的最大限制是1GB。可使用其List来做FIFO双向链表，实现一个轻量级的高性能消息队列服务，用它的Set可以做高性能的tag系统等等。
   * redis可以对存入的Key-Value设置expire时间，因此可以被当作一个功能加强版的memcached来用。
   * 主要缺点是数据库容量容易受到物理内存的限制，不能用做海量数据的高性能读写。因此redis适合的场景主要局限在较小数据量大高性能操作和运算上。
2. 安装
   1. 常用配置
      * daemonize：是否是守护进程（no|yes）
      * port：redis对外端口号，默认：6379
      * logfile：redis系统日志
      * dir：redis工作目录

### api的使用

#### 通用命令

1. keys：keys [pattern]

   * keys *：遍历所有key

2. dbsize：计算key的总数

3. exits key：检查key是否存在

   * 存在返回1，不存在返回0

4. del key [key ...]：删除指定key-value

5. expire key seconds：key在seconds秒后过期

   * ttl key：查看key剩余的过期时间
   * persist key：去掉key的过期时间

6. type key：返回key的类型

7. 时间复杂度

   | 命令   | 时间复杂度 |
   | ------ | ---------- |
   | keys   | O(n)       |
   | dbsize | O(1)       |
   | del    | O(1)       |
   | exists | O(1)       |
   | expire | O(1)       |
   | type   | O(1)       |

#### 数据结构

1. string，hash，list，set，zset，none

2.  内部编码

   | 数据结构 | 内部编码            |
   | -------- | ------------------- |
   | string   | raw, int, embstr    |
   | hash     | hashtable, ziplist  |
   | list     | linkedlist, ziplist |
   | set      | hashtable, intset   |
   | zset     | skiplist, ziplist   |

3. redisObject：数据类型（type），编码方式（encoding），数据指针（ptr），虚拟内存（vm）等

4. redis是单线程

   * 注意事项：
     * 一次只运行一条命令
     * 拒绝长命令：keys, flushall, flushdb, slow lua script, mutil/exec, operate big value
     * 其实不是单线程：fysnc file descriptor close file descriptor

##### 字符串

1. 存储最大容量为512MB
2. 命令
   * get, set, del : o(1)
   * incr：incr key #key自增1，如果key不存在，自增后get(key)=1  o(1)
   * decr：decr key #key自减1，如果key不存在，自减后get(key)=1  o(1)
   * incrby：incrby key k #key自增k，如果key不存在，自增后get(key)=k  o(1)
   * decrby：decr key k #key自减k，如果key不存在，自减后get(key)=k  o(1)
   * set key value # 不管key是否存在，都设置  o(1)
   * setnx key value # key不存在，才设置  o(1)
   * set key value xx #key存在，才设置  o(1)
   * mget key1 key2 key3.... # 批量获取key，原子操作  o(n)
   * mset key1 value1 key2 value2 key3 value3 # 批量设置key-value o(n)
   * getset key newvalue # set key newvalue并返回旧的value  o(1)
   * append key value # 将value追加到旧的value  o(1)
   * strlen key # 返回字符串的长度 o(1)
   * incrbyfloat key k # 增加key对应的值k   o(1)
   * getrange key start end # 获取字符串指定下标所有的值   o(1)
   * setrange key index value # 设置指定下标所有对应的值   o(1)

##### hash

1. key    filed value
2. 命令
   * hget key field # 获取hash key对应的field的value  o(1)
   * hset key field value # 设置hash key对应的field的value  o(1)
   * hdel key filed # 删除hash key对应field的value  o(1)
   * hexists key field # 判断hash key是否有field  o(1)
   * hlen key # 获取hash key field的数量  o(1)
   * hmget key field1 field2 ... fieldN # 批量获取hash key的一批field对应的值  o(n)
   * hmset key field1 value1 field2 value2 ... fieldN valueN # 批量设置hash key的一批field value  o(n)
   * hincrby key filed k # 增加key对应的filed的值k   o(1)
   * hgetall key # 返回hash key对应所有的field和value  o(n)
   * hvals key  # 返回hash key对应所有field的value  o(n)
   * hkeys key # 返回hash key对应所有field  o(n)
   * hsetnx key field value # 设置hash key对应field的value（如field已经存在，则失败）o(1)
   * hincrbyfloat key field k # 浮点数自增k  o(1)

##### list

1. key elements
2. 有序，可重复
3. 命令
   * rpush key value1 value2 ... valueN # 从列表右端插入值（1-N个）o(1~n)
   * lpush key value1 value2 ... valueN # 从列表左端插入值（1-N个）o(1~n)
   * linsert key before|after value newValue # 在list指定的值前｜后插入newValue  o(n)
   * lpop key # 从列表左侧弹出一个item o(1)
   * rpop key # 从列表右侧弹出一个item o(1)
   * lrem key count value
     * 根据count值，从列表中删除所有与value相等的项
     * count>0，从左到右，删除最多count个value相等的项
     * count<0，从右到左，删除最多Math.abs(count)个value相等的项
     * count=0，删除所有value相等的项
   * ltrim key start end # 按照索引范围修剪列表  o(n)
   * lrange key start end(包含end) # 获取列表指定索引范围所有item  o(n) 
   * lindex key index # 获取列表指定索引的item o(n)
   * llen key # 获取列表长度 o(1)
   * lset key index newValue  # 设置列表指定索引值为newValue o(n)
   * blpop key timeout # lpop阻塞版本，timeout是阻塞超时时间，timeout=0为永远不阻塞 o(1)
   * brpop key timeout # rpop阻塞版本，timeout是阻塞超时时间，timeout=0为永远不阻塞 o(1)

##### set

1. key values
2. 无序，无重复，集合间操作
3. 命令
   * sadd key element # 向集合key添加element（如果element已经存在，添加失败）o(1)
   * srem key element # 将集合key中的element移除 o(1)
   * scard key # 计算集合key的大小
   * sismember key element # 判断it是否在集合中。存在返回1
   * srandmember key count # 从集合中随机挑count个元素，不会破坏集合
   * smembers key # 获取集合key所有元素
   * spop key # 从集合key中随机弹出一个元素
   * sdiff key1 key2 # 差集
   * sinter key1 key2 # 交集
   * sunion key1 key2 # 并集
   * sdiff|sinter|suion + store destkey ... # 将差集、并集、交集结果保存在destkey中

##### zset

1. 有序集合，无重复
2. key score value
3. 命令 
   * zadd key score element（可以是多对）# 添加score和element o(logN)
   * zrem key element （可以是多个）# 删除元素 o(1)
   * zscore key element # 返回元素的分数  o(1)
   * zincrby key increScore element # 增加或减少元素的分数  o(1)
   * zcard key # 返回元素的总个数 o(1)  
   * zrange key start end [withscores] # 返回指定索引范围内的升序元素[分值] o(log(n) + m)
   * zrangebyscore key minScore maxScore [withscores] # 返回指定分数范围内的升序元素[分值] o(log(n) + m)
   * zcount key minScore maxScore # 返回有序集合内在指定分数范围内的个数 o(log(n) + m)
   * zremrangebyrank key start end # 删除指定排名内的升序元素 o(log(n) + m)
   * zremrangebyscore key minScore maxScore # 删除指定分数内的升序元素 o(log(n) + m)

##### 慢查询

1. 生命周期：

   * 发送命令；排队；执行命令；返回结果

2. 慢查询发生在第3阶段；客户端超时不一定慢查询，但慢查询是客户端超时的一个可能因素

3. 两个配置：

   * slowlog-max-len：设置慢查询的大小，默认128

   * slowlog-log-slower-than：慢查询阈值（单位：微妙），默认10000

     * =0：记录所有命令
     * <0：不记录所有命令

   * 配置方法：

     * 修改配置文件，需要重启redis

     * 命令配置

       ```shell
       config set slowlog-max-len 1000
       config set slowlog-log-slower-than 1000
       ```

4. 命令

   * slowlog get [n]：获取慢查询队列
   * slowlog len：获取慢查询的队列长度
   * slowlog reset：清空慢查询队列

##### pipeline

##### 发布订阅

1. publish channel message：发布命令
2. subscribe [channel]：订阅
3. unsubscribe [channel]：取消订阅
4. psubscribe [pattern]：订阅模式
5. punsubscribe [pattern]：退订指定的模式
6. pubsub channels：列出至少有一个订阅者的频道
7. pubsub numsub [channel...]：列出给定频道的订阅者数量
8. pubsub numpat：列出被订阅模式的数量

##### Bitmap 位图

1. setbit key offset value：给位图指定索引设置值
2. getbit key offset：获取位图指定索引的值
3. bitcount key [start end]：获取位图指定范围（start到end，单位为字节，如果不指定就是获取全部）位值为1的个数
4. bitop op destkey key [key ...]：做多个bitmap的and、or、not、xor操作结果保存在destkey中
5. bitpos key targetBit [start] [end]：计算位图指定范围（start到end，单位为字节，如果不指定就是获取全部）第一个偏移量对应的值等于targetBit的位置

##### hyperLogLog

1. 基于HyperLogLog算法：极小空间完成独立数量统计。
2. 本质还是字符串。
3. 错误率：0.81%
4. 命令
   * pfadd key element [element ...]：向hyperloglog添加元素
   * pfcount key [key...]：计算hyperloglog的独立总数
   * pfmerge destkey sourcekey [sourcekey ...]：合并多个hyperloglog

##### GEO

1. 地理信息定位：存储经纬度，计算两地距离，范围计算等
2. 命令
   * geoadd key longitude latitude member [longitude latitude memeber ...] ：增加地理位置信息
   * geopos key memeber [member ...] ：获取地理位置信息
   * geodist key member1 member2 [unit]：获取两个地理位置等距离
     * unit：m、km、mi（英里）、ft（尺）
   * `georadius key longitude latitude radiusm|km|ft|mi [withcoord] [withdist] [withhash] [COUNT count] [asc|desc] [store key][storedist key]`
   * `georadiusbymember key member radiusm|km|ft|mi [withcoord] [withdist] [withhash] [COUNT count] [asc|desc] [store key][storedist key] `：获取指定位置范围内的地理位置信息集合
     * withcoord：返回结果中包含经纬度
     * withdist：返回结果中包含距离中心节点位置
     * withhash：返回结果中包含geohash
     * COUNT count：指定返回结果的数量
     * asc|desc：返回结果按照距离中心节点的距离做升序或者将序
     * store key：将返回结果的地理位置信息保存到指定键
     * storedist key：将返回结果距离中心节点的距离保存到指定键

#### 持久化

1. 持久化：redis所有数据保存在内存中，对数据的更新将异步地保存在磁盘上。
2. 持久化方式：
   * 快照：Mysql Dump；redis RDB
   * 写日志：Mysql Binlog；Hbase Hlog；redis AOF

##### RDB

1. redis创建RDB文件（二进制）保存在磁盘中
2. redis启动时可以载入RDB文件
3. 生成RDB的方式
   * save：同步
     * 会出现阻塞
     * 如存在旧的RDB文件，则替换
     * 复杂度：O(N)
   * bgsave：异步
     * 如存在旧的RDB文件，则替换
     * 复杂度：O(N)
     * 需要fork，消耗内存
     * 阻塞发生在fork
   * 自动
4. 耗时耗性能，不可控、丢失主机

##### AOF

1. redise写命令刷新缓冲区，缓冲区将命令fsync到硬盘AOF文件中

2. 三种策略

   * always：每条命令都fsync到硬盘AOF文件中

     * 不丢失数据
     * IO开销大，一般大sata盘只有几百TPS

     * everysec：每秒把缓冲区fsync到硬盘AOF文件中
       * 丢1秒数据

   * no：操作系统决定是否fsync到硬盘AOF文件中
     * 不用管理，但不可控

3. AOF重写作用

   * 减少硬盘占用量
   * 加速恢复速度

4. AOF重写的方式

   * bgrewriteaof
     * 
   * AOF重写配置
     * 配置：
       * auto-aof-rewrite-min-size：AOF文件重写需要的大小
       * auto-aof-rewrite-percentage：AOF文件增长率
     * 统计：
       * aof_current_size：AOF当前大小（字节）
       * aof_base_size：AOF上次启动和重写的尺寸（字节）
   * <img src="/Users/zefeng/Library/Application Support/typora-user-images/image-20220214205313324.png" alt="image-20220214205313324" style="zoom: 33%;" />

##### 常见问题

###### fork操作

1. 同步操作
2. 与内存量有关：内存越大，耗时越长（与机器类型也有关）
3. info:latest_fork_usec # 查看fork执行时间
4. 改善fork
   * 优先使用物理机或者高效支持fork操作的虚拟化技术
   * 控制redis实例最大可用内存：maxmemory
   * 合理配置Linux内存分配策略：vm.overcommit_memory = 1
   * 降低fork频率：例如放宽AOF重写自动触发时机，不必要的全量复制

#### 主从复制

1. 作用：数据副本；扩展读性能
2. 一个master可以有多个slave
3. 一个slave只能有一个master
4. 数据流向是单向的，master到slave
5. 实现方式：
   * slaveof命令
     * redis-6380> slaveof 127.0.0.1 6379
     * slaveof no one：取消主从复制
   * 配置
     * slaveof ip port
     * slave-read-only yes
6. 全量复制和部分复制
7. 读写分离
   * 读流量分摊到从节点
   * 复制数据可能有延迟（主到从）
   * 读到过期数据
   * 从节点故障 
   * 配置不一致
   * 规避全量复制
     * 第一次全量复制
     * 节点运行ID不匹配（主节点重启或故障转移）
     * 复制积压缓冲区不足
   * 规避复制风暴

#### redis sentinel

1. 监控故障转移和通知



