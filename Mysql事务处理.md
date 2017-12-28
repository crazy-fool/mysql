Mysql事务处理
---------

####1、概述：
事务是一组原子性sql查询语句，被当作一个工作单元。若mysql对改事务单元内的所有sql语句都正常的执行完，则事务操作视为成功，所有的sql语句才对数据生效，若sql中任意不能执行或出错则事务操作失败，所有对数据的操作则无效（通过回滚恢复数据）。

数据库引入事务的主要目的：事务会把数据库从一种一致状态转换为另一种一致状态。在数据库提交工作时，可以确保其要么所有修改都已经保存了，要么所有修改都不保存。

####2、事务（Transaction）的 ACID 特性：
**原子性 (atomicity)**: 事务中的所有操作要么全部提交成功，要么全部失败回滚。
**一致性 (consistency)**: 数据库总是从一个一致性状态转换到另一个一致性状态。
**隔离性 (isolation)**: 一个事务所做的修改在提交之前对其它事务是不可见的。
**持久性 (durability)**: 一旦事务提交，其所做的修改便会永久保存在数据库中。

####3、MYSQL事务处理的两种方式：
 1. 用begin,rollback,commit来实现
 开始：START TRANSACTION或BEGIN语句可以开始一项新的事务；推荐用START TRANSACTION 是SQL-99标准启动一个事务
 提交：COMMIT可以提交当前事务，是变更成为永久变更
 回滚：ROLLBACK可以回滚当前事务，取消其变更
 
	注，其他事务控制语句：
	SAVEPOINT identifier:  SAVEPOINT允许你在事务中创建一个保存点，一个事务中可以有多个SAVEPOINT。
	RELEASE SAVEPOINT identifier: 删除一个事务的保存点，当没有一个保存点执行这句语句时，会抛出一个异常。
	ROLLBACK TO [SAVEPOINT] identifier : 这个语句与SAVEPOINT命令一起使用，可以把事务回滚到标记点，而不回滚在此标记点之前的任何工作。

 2. 直接用set来改变mysql的自动提交模式，**用于当前连接**
 MYSQL默认是自动提交的，也就是你提交一个QUERY，它就直接执行！我们可以通过
set autocommit=0 禁止自动提交
set autocommit=1 开启自动提交
来实现事务的处理。当你用 set autocommit=0 的时候，你以后所有的SQL都将做为事务处理，直到你用commit确认或rollback结束。

	**注意：**当你结束这个事务的同时也开启了个新的事务！按第一种方法只将当前的作为一个事务！**推荐使用第一种方法！**

####4、MYSQL事务的实现：
 1. Redo Log
	 在InnoDB存储引擎中，事务日志是通过重做（redo）日志文件和InnoDB存储引擎的日志缓冲（InnoDB Log Buffer）来实现的。当开始一个事务的时候，会记录该事务的LSN (Log Sequence Number，日志序列号); 当事务执行时，会往InnoDB存储引擎的日志
 的日志缓存里面插入事务日志；当事务提交时，必须将InnoDB存储引擎的日志缓冲写入磁盘（通过innodb_flush_log_at_trx_commit来控制，默认的实现，即innodb_flush_log_at_trx_commit=1）。也就是写数据前，需要先写日志。这种方式称为“预写日志方式”（Write-Ahead Logging, WAL）。

 InnoDB通过此方式来保证事务的完整性。也就意味着磁盘上存储的数据页和内存缓冲池上面的页是不同步的，对于内存缓冲池中页的修改，先是先写入重做日志文件（redo log），然后再写入磁盘（data file），因此是一种异步的方式。可以通过 show engine innodb status\G 来观察当前磁盘和日志之间的“差距”。
 
 2. Undo 
	重做日志记录了事务的行为，可以很好地通过其进行“重做”。但是事务有时还需要撤销，这是就需要undo。undo与redo正好相反，对于数据库进行修改时，数据库不但会产生redo，而且还会产生一定量的undo，即使你执行的事务或语句由于某种原因失败了，或者如果你用一条ROLLBACk语句请求回滚，就可以利用这些undo信息将数据回滚到修改之前的样子。与redo不同的是，redo存放在重做日志文件中，undo存放在数据库内部的一个特殊段（segment）中，这称为undo段（undo segment），undo段位于共享表空间内。

####5、事务的隔离级别
ANSI/ISO SQL标准定义了4中事务隔离级别：未提交读（read uncommitted），提交读（read committed），重复读（repeatable read），串行读（serializable）。

对于不同的事务，采用不同的隔离级别分别有不同的结果。不同的隔离级别有不同的现象。主要有下面3种现在：
1、**脏读（dirty read）**：一个事务可以读取另一个尚未提交事务的修改数据。
2、**非重复读（nonrepeatable read）**：在同一个事务中，同一个查询在T1时间读取某一行，在T2时间重新读取这一行时候，这一行的数据已经发生修改，可能被更新了（update），也可能被删除了（delete）。
3、**幻像读（phantom read）**：在同一事务中，同一查询多次进行时候，由于其他插入操作（insert）的事务提交，导致每次返回不同的结果集。

不同的隔离级别有不同的现象，并有不同的锁定/并发机制，隔离级别越高，数据库的并发性就越差，4种事务隔离级别分别表现的现象如下表：
|隔离级别|	脏读|	非重复读|	幻像读|
|:-:|:-:|:-:|:-:|
|read uncommitted|允许|允许|允许|
|read committed||允许|允许|
|repeatable read|||允许|
|serializable||| |

####6、设置事务的隔离级别
用户可以用SET TRANSACTION语句改变单个会话或者所有新进连接的隔离级别。它的语法如下：

	SET [SESSION | GLOBAL] TRANSACTION ISOLATION LEVEL {READ UNCOMMITTED | READ COMMITTED | REPEATABLE READ | SERIALIZABLE}

**注意：**默认的行为（不带session和global）是为下一个（未开始）事务设置隔离级别。如果你使用GLOBAL关键字，语句在全局对从那点开始创建的所有新连接（除了不存在的连接）设置默认事务级别。你需要SUPER权限来做这个。使用SESSION 关键字为将来在当前连接上执行的事务设置默认事务级别。 任何客户端都能自由改变会话隔离级别（甚至在事务的中间），或者为下一个事务设置隔离级别。

可以用下列语句查询全局和会话事务隔离级别：

	mysql> SELECT @@global.tx_isolation; 
	+-----------------------+
	| @@global.tx_isolation |
	+-----------------------+
	| REPEATABLE-READ       |
	+-----------------------+
	1 row in set (0.00 sec)
	mysql>
	mysql> SELECT @@session.tx_isolation; 
	+------------------------+
	| @@session.tx_isolation |
	+------------------------+
	| REPEATABLE-READ        |
	+------------------------+
	1 row in set (0.00 sec)
	mysql> SELECT @@tx_isolation;
	+-----------------+
	| @@tx_isolation  |
	+-----------------+
	| REPEATABLE-READ |
	+-----------------+
	1 row in set (0.00 sec)
	
####7、数据库中的默认事务隔离级别
在Oracle中默认的事务隔离级别是提交读（read committed）。
对于MySQL的Innodb的默认事务隔离级别是重复读（repeatable read）。可以通过下面的命令查看：		

	mysql -h10.8.3.29 -P3337 -umlstmpdb -p****
	mysql> SELECT @@GLOBAL.tx_isolation,@@tx_isolation;
	+———————–+—————–+
	| @@GLOBAL.tx_isolation | @@tx_isolation  |
	+———————–+—————–+
	| REPEATABLE-READ | REPEATABLE-READ |
	+———————–+—————–+
	1 row in set (0.00 sec) 
	
可以利用如下语句查询并临时修改隔离级别:
	
	mysql> show variables like 'tx_isolation';
	+---------------+-----------------+
	| Variable_name | Value           |
	+---------------+-----------------+
	| tx_isolation  | REPEATABLE-READ |
	+---------------+-----------------+
	1 row in set (0.00 sec)
	mysql> set tx_isolation = 'READ-COMMITTED';
	Query OK, 0 rows affected (0.00 sec)
	mysql> show variables like 'tx_isolation';
	+---------------+----------------+
	| Variable_name | Value          |
	+---------------+----------------+
	| tx_isolation  | READ-COMMITTED |
	+---------------+----------------+
	1 row in set (0.00 sec)
	mysql>

####8、数据库中事务的种类

 1. 扁平事务；（应用场景中用的比较多的）
 2. 带有保存点的扁平事务；
 3. 链事务；
 4. 嵌套事务；
 5. 分布式事务。
 参考：http://www.jb51.net/article/64005.htm   
   
#### 9、不能回滚的语句
有些语句不能被回滚。通常，这些语句包括数据定义语言（DDL）语句，比如创建或取消数据库的语句，和创建、取消或更改表或存储的子程序的语句。

在设计事务时，不应包含这类语句。如果您在事务的前部中发布了一个不能被回滚的语句，则后部的其它语句会发生错误，在这些情况下，通过发布ROLLBACK语句不能 回滚事务的全部效果。


----------


**延伸：**
1、**DDL**（Data Definition Language）数据定义语言，于定义和管理 SQL 数据库中的所有对象的语言
CREATE、ALTER、DROP、TRUNCATE、COMMENT、RENAME
2、**DML**（Data Manipulation Language）数据操纵语言，SQL中处理数据等操作统称为数据操纵语言
SELECT、INSERT、UPDATE、DELETE、MERGE、CALL、EXPLAIN、PLAN、LOCK TABLE
3、**DCL**（Data Control Language）数据控制语言  授权，角色控制等
GRANT 授权
REVOKE 取消授权
4、**TCL**（Transaction Control Language）事务控制语言
COMMIT 提交
SAVEPOINT 设置保存点
ROLLBACK  回滚
SET TRANSACTION

#### 10、优缺点总结
并发控制（锁）中已做了相关说明，这里再补充一下
 1. 优点
	 a、事务处理是一组原子性的操作，内部有一个失败，则回滚；保证数据的一致性
	 b、行级锁定，利于数据的快速更新
	 c、事务的隔离性，使得事务可以并发的工作，提高并发
 2. 缺点
	 a、相对比较消耗内存；事务处理时间越长，影响越大；
	 b、死锁等现象影响性能
	 c、单个连接不支持夸库事务处理
	 d、任何可能让事务提交发生延迟的操作代价都很大，因为它影响的不仅仅是自己本身，它还会让所有参与者都在等待


注：在应用程序中，最好的做法是把事务的START TRANSACTION 、COMMIT、ROLLBACK操作交给程序端来完成，而不是在存储过程内完成。
	 	       
 