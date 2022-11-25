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

## 面试专题

### 1. 什么是Redis？简述它的优缺点？

* Redis全称是Remote Dictionary.Server，本质上是一个Key-Value类型的内存数据库，很像memcached，整个数据库统统加载在内存当中进行操作，定期通过异步操作把数据库数据flush到硬盘上进行保存。
* 纯内存操作，每秒可以处理超过10万次读写操作，是已知性能最快的Key-Value DB。
* 支持保存多种数据结构，此外单个value的最大限制是1GB。
* 可以对存入的Key-Value设置expire时间。
* 主要缺点是数据库容量收到物理内存的限制，不能用做海量数据的高性能读写，因此Redis适合的场景主要局限在较小数据量大高性能操作和运算上。

### 2. Redis与memcached相比有哪些优势？

* memcached所有的值均是简单的字符串，redis支持多种数据类型
* redis的速度比memcached快很多
* redis可以持久化数据

### 3. Redis有哪几种数据淘汰策略？

* noeviction：默认操作，如果内存已满则报错
* allkeys-lru：尝试回收最少使用的键
* volatile-lru：在设置过期时间的所有键中，尝试回收最少使用的键
* allkeys-random：在所有键中，随机回收
* volatile-random：在设置过期时间的所有键中，随机回收
* volatile-ttl：在设置过期时间的所有键中，回收存活时间最短的键
* 内存淘汰策略用于处理内存不足时需要申请额外空间的数据

### 4. Redis集群方案

1. 主从复制模式

   * 客户端可对主数据库进行读写操作，对从数据库进行读操作，主数据库写入的数据会实时自动同步到从数据库

   * 主从模式为了使在部分节点失败或者大部分节点无法通信的情况下集群仍然可用，每个节点都有N-1个复制品

   * 工作机制：
     * slave启动后，向master发送sync命令，master接收到sync命令后通过bgsave保存快照，并使用缓冲区记录保存快照这段时间内执行的写命令
     * master将保存的快照文件发送给slave，并继续记录执行的写命令
     * slave接收到快照文件后，加载快照文件，载入数据
     * master快照发送完后开始向slave发送缓冲区的写命令，slave接收写命令并执行，完成复制初始化
     * 此后master每次执行一个写命令都会同步发送给slave，保持master与slave之间数据的一致性

   * 优缺点
     * master能自动将数据同步到slave，可以进行读写分离，分担master的读压力
     * master、slave之间的异步是以非阻塞的方式进行的，同步期间，客户端仍然可以提交查询或更新请求
     * 不具备自动容错与恢复功能，master或slave的宕机都可能导致客户端请求失败，需要等待机器重启或手动切换客户端IP才能恢复
     * master宕机，如果宕机前数据没有同步完，则切换IP后会存在数据不一致的问题
     * 难以支持在线扩容，Redis的容量受限于单机配置

2. Sentinel（哨兵）模式

   * 哨兵监控master、slave是否正常运行；当master出现故障时，能自动将一个slave转换为master；多个哨兵可以监控同一个Redis，哨兵之间也会自动监控

   * 工作机制：
     * 哨兵启动后，会与要监控的master建立两条连接：
       2. 一条连接用来订阅master的`_sentinel_:hello`频道与获取其他监控该master的哨兵节点信息
       3. 另一条连接定期向master发送INFO等命令获取master本身的信息
     * 与master建立连接后，哨兵会执行三个操作：
       1. 定期（一般10s一次，当master被标记为主观下线时，改为1s一次）向master和slave发送INFO命令
       2. 定期向master和slave的`_sentinel_:hello`频道发送自己的信息
       3. 定期（1s一次）向master、slave和其他哨兵发送PING命令
     * 发送INFO命令可以获取当前数据库的相关信息从而实现新节点的自动发现。因此哨兵只需配置master数据库信息就可以自动发现其slave信息。获取到slave信息后，哨兵也会与slave建立两条连接执行监控。
     * 哨兵向主从数据库的`_sentinel_:hello`频道发送信息与同样监控这些数据库的哨兵共享自己的信息，发送内容为哨兵的ip端口、运行id、配置版本、master名字、master的ip端口还有master的配置版本。信息的作用：
       1. 其他哨兵可以通过该信息判断发送者是否是新发现的哨兵，如果是会创建一个到改哨兵的连接用于发送PING命令
       2. 其他哨兵通过信息可以判断master的版本，如果该版本高于直接记录的版本，将会更新
       3. 当实现了自动发现slave和其他哨兵节点后，哨兵就可以通过定期发送PING命令定时监控这些数据库和节点有没有停止服务
     * 如果PING的数据库或节点超时未回复，哨兵认为其主观下线。如果下线的是master，哨兵会向其他哨兵发送命令询问它们是否也认为该master主观下线，如果达到一定数量投票（quorum），哨兵会认为该master已经可断下线，并选举领头的哨兵节点对主从系统发起故障恢复。若没有足够的sentinel进程同意master下线，master的客观下线状态会被移除，若master重新向sentinel进程发送的PING命令返回有效回复，master的主观下线状态就会被移除
     * 哨兵认为master客观下线后，故障恢复的操作需要由选举的领头哨兵来执行，选举采用Raft算法：
       1. 发现master下线的哨兵节点向每个哨兵发送命令，要求对方选自己为领头哨兵
       2. 如果目标哨兵节点没有选过其他人，则会同意选举其为领头哨兵
       3. 如果有超过一半的哨兵同意选举其为领头，则当选
       4. 如果有多个哨兵节点同时参选领头，此时有可能存在一轮投票无竞选者胜出，此时每个参选的节点等待一个随机时间后在此发起参选请求，进行下一轮 投票竞选，直至选举出领头哨兵。
     * 选出领头哨兵后，领头者开始对系统进行故障恢复，从出现故障的master的主从数据库中挑选一个来当选新的master，选择规则如下：
       1. 所有在线的slave中选择优先级最高的，优先级可以通过slave-priority配置
       2. 如果有多个最高优先级的slave，则选取复制偏移量最大的当选
       3. 如果以上条件都一样，选取id最小的slave
     * 挑选出需要继任的slave后，领头哨兵向该数据库发送命令使其升格为master，然后向其他slave发送命令接收新的master，最后更新数据。将已停止的master更新为新的master的从数据库，使其恢复服务后以slave的身份继续运行。
   * 优缺点
     * 哨兵模式基于主从复制模式，所以主从复制模式有的优点，哨兵模式也有
     * 哨兵模式下，master挂掉可以自动进行切换，系统可用性更高
     * 同样也有主从模式的难以在线扩容的缺点
     * 需要额外的资源来启动sentienl进程，同时slave节点作为备份节点不提供服务

3. Cluster模式

   * Cluster采用无中心结构。
     * 所有的redis节点彼此互联（PING-PONG机制），内部使用二进制协议优化传输速度和带宽
     * 节点的fail是通过集群中超过半数的节点检测失效时才生效
     * 客户端与redis节点直连，不需要中间代理层，客户端不需要连接集群所有节点，连接集群中任何一个可用节点即可。

   * 工作机制：
     * 在Redis的每个节点上，都有一个插槽（slot），取值范围为0-16383
     * 当我们存取key的时候，redis会根据CRC16算法得出一个结果，然后把结果对16384求余数，这样每个key都会对应一个编号在0-16383之间的哈希槽，通过这个值，去找到对应的插槽所对应的节点，然后直接自动跳转到这个对应的节点上进行存取操作
     * 为了保证高可用，Cluster模式也引入主从复制模式，一个主节点对应一个或者多个从节点，当主节点宕机的时候，就会启用从节点
     * 当其他主节点ping一个主节点A时，如果半数以上的主节点与A通信超时，那么认为主节点A宕机了。如果主节点A和它的从节点都宕机了，那么该集群就无法再提供服务了。

   * Cluster模式集群节点最小配置6个节点（3主3从），其中主节点提供读写操作，从节点作为备用节点，不提供请求，只作为故障转移使用

   * 优缺点：
     * 无中心架构，数据按照slot分布在多个节点
     * 集群中的每个节点都是平等的关系，每个节点都保存各自数据和整个集群的状态。每个节点都和其他节点连接，而且这些连接保持活跃，这样就保证了我们只需要连接集群中的任意一个节点，就可以获取到其他节点的数据
     * 可线性扩展到1000多个节点，节点可动态添加或删除
     * 能够实现自动故障转移，节点之间通过gossip协议交换状态信息，用投票机制完成slave到master的角色转换
     * 开发难度大，目前仅JedisCluster相对成熟，异常处理还不完善。
     * 节点会因为某些原因发生阻塞被判断下线
     * 数据通过异步复制，不能保证数据的强一致性
     * slave充当备份，不能缓解读压力
     * 批量操作限制，目前只支持具有相同slot值的key执行批量操作，对master、mget、sunion等操作不友好
     * key事务操作支持有限，只支持多key在同一节点的事务操作，多key分布不同节点时无法使用事务功能
     * 不支持多数据库空间，单机redis可以支持16个db，集群模式下只能使用一个即：db0

### 5. Redis适合的场景

* 会话缓存（Session Cache）

* 全页缓存（FPC）
* 队列
* 排行榜/计数器
* 发布/订阅

### 6. Redis的管道

### 7. 怎样理解Redis事务？

1. 事务是一个单独的隔离操作；事务中的所有命令都会序列化、按顺序地执行，事务在执行的过程中，不会被其他客户端发来的命令请求所打断。
2. 事务是一个原子操作，事务中的命令要么全部被执行，要么全部都不执行。
3. 事务相关的命令：MULTI、EXEC、DISCARD、WATCH

### 8. Redis如何做内存优化？

尽可能使用散列表（hashes），散列表使用的内存非常小。

### 9. 加锁机制

### 10. 锁互斥机制

 ### 11. watch dog自动延期机制

### 12. 可重入加锁机制

### 13. 释放锁机制

### 14. Redis分布式锁是怎么实现的？

1. 用setnx来争抢锁，抢到之后，再用expire给锁加一个过期时间防止锁忘记释放

### 15. 什么是缓存穿透？如何避免？什么是缓存雪崩？如何避免？

1. 缓存穿透：一般的缓存系统，都是按照key去缓存查询，如果不存在对应的value，就应该去后端系统查找（比如db）。一些恶意的请求会故意查询不存在的key，请求量很大，就会对后端系统造成很大的压力。
2. 缓存穿透如何避免？
   * 对查询结果为空的情况也缓存，缓存时间设置短一点，或者该key对应的数据insert了之后清理缓存。
   * 对一定不存在的key进行过滤。可以把所有的可能存在的key放到一个大的Bitmap中，查询时通过该bitmap过滤。
3. 缓存雪崩：当缓存服务器重启或者大量缓存集中在某个时间段失效，这样在失效的时候，会给后端系统带来很大压力。导致系统崩溃。
4. 缓存雪崩如何避免？
   * 在缓存失效后，通过加锁或者队列来控制读数据库写缓存的线程数量。比如对某个key只允许一个线程查询数据和写缓存，其他线程等待。
   * 做二级缓存，A1为原始缓存，A2为拷贝缓存，A1失效时，可以访问A2，A1缓存失效时间设置为短期，A2设置长期。
   * 不同的key，设置不同的过期时间，让缓存失效的时间点尽量均匀。

### 16. 异步队列

1. 一般使用list结构作为队列，rpush生产消息，lpop消费消息。当lpop没有消息的时候，要适当sleep一会再重试。
2. 使用pub/sub主题订阅者模式，可以实现1：N的消息队列。
3. 在消费者下线的情况下，生产的消息会丢失，得使用专业的消息队列如rabbitmq等。

