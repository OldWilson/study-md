# Mysql - QA

### 1. **<font color="red">1044: Access denied for user 'root'@'localhost' to database 'information_schema' when using LOCK TABLES</font>**

* 在mysqldump命令之后添加--single-transaction 即可
* --single-transaction参数的作用，设置事务的隔离级别为可重复读，即REPEATABLE READ，这样能保证在一个事务中所有相同的查询读取到同样的数据，也就大概保证了在dump期间，如果其他innodb引擎的线程修改了表的数据并提交，对该dump线程的数据并无影响，在这期间不会锁表。
* `mysqldump --single-transaction -hIP地址 -p3306 -uroot -p密码 数据库名>D:/hhh.sql`

### 2. <font color="red">SELECT /*!40001 SQL_NO_CACHE */  * FROM</font>

* /*!  */ 这是mysql 特里的语法，并非注释，因为里面达到条件也会执行。
* !后面是版本号， 如果本数据库等于或大于此版本号，那么注释内的代码也会执行
* 在备份操作时Mysql 会自动调用此语法

### 3. <font color="red">mysqldump: Couldn't execute 'SELECT /*!40001 SQL_NO_CACHE */ * FROM \`GLOBAL_STATUS\`': The 'INFORMATION_SCHEMA.GLOBAL_STATUS' feature is disabled; see the documentation for 'show_compatibility_56'</font>

```mysql
mysql>  show variables like '%show_compatibility_56%';
+-----------------------+-------+
| Variable_name         | Value |
+-----------------------+-------+
| show_compatibility_56 | OFF   |
+-----------------------+-------+
1 row in set (0.01 sec)

mysql> set global show_compatibility_56=on;
Query OK, 0 rows affected (0.01 sec)

mysql> show variables like '%show_compatibility_56%';
+-----------------------+-------+
| Variable_name         | Value |
+-----------------------+-------+
| show_compatibility_56 | ON    |
+-----------------------+-------+
1 row in set (0.00 sec)
```

### 4.  <font color="red">The generated identifier is already in use [xxx

### ]</font>

```java
net.sf.hibernate.HibernateException: The generated identifier is already in use: [com.model.entity.Info#aaa.json]
	at net.sf.hibernate.impl.SessionImpl.doSave(SessionImpl.java:682) ~[hibernate2.jar:?]
	at net.sf.hibernate.impl.SessionImpl.save(SessionImpl.java:620) ~[hibernate2.jar:?]
```

