### 1、MySQL体系结构
![](http://a2.qpic.cn/psb?/V14EGSbs4eQiTA/pgz.ZtNnXUsqfl2W.6G2yZ2Jc9xQCmVcBPh8Z*o5Cms!/b/dKMAAAAAAAAA&bo=lwOJApcDiQIDCSw!&rf=viewer_4)

 1. Connectors(连接器)：指不同语言（PHP/Perl/Python/Ruby）中与SQL的交互
 2. Management Services & Utilites(服务管理与控制工具)：包括数据备份与恢复、安全、复制、集群、权限管理、配置等
 3. Connection Pool(连接池)：认证、线程重用、管理缓冲用户连接
 4. SQL Interface(SQL接口)：DML，DDL，存储过程，视图，触发器等等。
 5. Parser(解析器)：验证和解析SQL语句
 6. Optimizer(查询优化器)：查询之前进行优化，“选取-投影-联接”策略
 7. Caches & Buffers(查询缓存)：小缓存组成
 8. Pluggable Storage Engines(可插拔的存储引擎)：一个抽象接口来定制一种文件访问机制

### 2、二分查找（折半查找法）
指：将记录按有序化（递增或递减）排序，在查找过程中采用跳跃式方式查找，即先以有序数列的重点位置为比较对象，如果要找的元素小于该中点元素，则将待查序列缩小为左半部分，否则为有半部分；通过一次比较，将查找区间缩小一半，直到找到或者到最后一个数为止

如：2、3、5、6、、7、8
![](http://a3.qpic.cn/psb?/V14EGSbs4eQiTA/EORWTyAOBCNFwtuj3RzBPjt**mTI2rMurfFAXemT9Dk!/b/dKcAAAAAAAAA&bo=.wBiAPsAYgAFACM!&rf=viewer_4)

（1）二分查找平均次数 = (3+2+3+1+3+2)/6 = 2.3

（2）顺序查找平均次数 = (1+2+3+4+5+6)/6 = 3
而且随着数据量的怎么大，差距越来越大

（3）平衡二叉查找树，平均查找次数 = (1+2+2+3+3+3)/6 = 2.3（平衡二叉查找树 是二分查找的一种算法实现）
![](http://a3.qpic.cn/psb?/V14EGSbs4eQiTA/3FJhucMreYTqjJPCE8Y.za.Z*VRZFsDi0ujUfhkLu9A!/b/dKoAAAAAAAAA&bo=kwE3AZMBNwEFACM!&rf=viewer_4)
----------


### 3、数据结构

 1. 二叉树
		指：二叉树的每个结点至多只有二棵子树(度<=2)，二叉树的子树有左右之分，次序不能颠倒
		特点：
			（1）度 <= 2
			（2）左右之分
 2. 二叉搜索树（二叉查找树）Binary Search Tree
		 指：每个节点都不比它左子树的任意元素小，而且不比它的右子树的任意元素大的二叉树
		 特点：
				 （1）二叉树 + 节点数据大小关系
 3. 平衡二叉树 Balanced Binary Tree（AVL树 AVerage Length Tree）
		 指：它是一棵空树或它的左右两个子树的深度差的绝对值不超过1，并且左右两个子树都是一棵平衡二叉树
		 特点：
				 （1）左右子树深度差的绝对值 <= 1
 4. 平衡二叉查找树
		 指：它是一棵空树或它的左右两个子树的深度差的绝对值不超过1，并且左右两个子树都是一棵平衡二叉查找树
 5. 完全二叉树
		 指：二叉树的深度为h，除第 h 层外，其它各层 (1～h-1) 的结点数都达到最大个数，第 h 层所有的结点都连续集中在最左边
		 特点：
				 （1）只允许最后一层有空缺结点且空缺在右边，即叶子结点只能在层次最大的两层上出现
 6. 满二叉树
		 指：除最后一层无任何子节点外，每一层上的所有结点都有两个子结点（非叶子节点都有两个子节点）
		 特点：
				 （1）总节点数：2^h - 1，一定是奇数
				 （2）总叶子数：2^(h - 1)，一定是偶数
				 （3）第k层节点数：2^(k - 1)，一定是偶数
				 （4）满二叉树一定是完全二叉树，完全二叉树不一定是满二叉树
 
### 3、B+树相关

 1. B树：平衡二叉查找树
		 每个节点只储存一个关键字，等于即命中，小于查左子树，大于查右子树，递归往下知道找到关键字或者找到叶子节点
![](http://a3.qpic.cn/psb?/V14EGSbs4eQiTA/8ZNcdoJk*sFTAFUP3YWf4cxf9pxKuMtwKzDDvNf1teI!/b/dKoAAAAAAAAA&bo=9wD8APcA*AAFACM!&rf=viewer_4)
 2. B-树：多路搜索树（并不是二叉的）
		 每个节点上存储[M/2, M]个关键字（且M > 2，根节点的儿子树[2, M]），非叶子节点存储指向关键字范围的子节点，所有关键字在整个数中出现且只出现一次，非叶子节点可以命中
		 特点：
				 （1）定义任意非叶子结点最多只有M个儿子；且M>2；
				 （2）根结点的儿子数为[2, M]；
				 （3）除根结点以外的非叶子结点的儿子数为[M/2, M]；
				 （4）每个结点存放至少M/2-1（取上整）和至多M-1个关键字；（至少2个关键字）
				 （5）非叶子结点的关键字个数=指向儿子的指针个数-1；
				 （6）非叶子结点的关键字：K[1], K[2], …, K[M-1]；且K[i] < K[i+1]；
				 （7）非叶子结点的指针：P[1], P[2], …, P[M]；其中P[1]指向关键字小于K[1]的子树，P[M]指向关键字大于K[M-1]的子树，其它P[i]指向关键字属于(K[i-1], K[i])的子树；
				（8）所有叶子结点位于同一层；
如：M = 3，下图：
![](http://a1.qpic.cn/psb?/V14EGSbs4eQiTA/BBDYUu*y2dbq.7ESh*TORUDUJUfdst9wlLFZWi4nU0Y!/b/dAIBAAAAAAAA&bo=oAPfAaAD3wEFACM!&rf=viewer_4)
 3. B+树
		 特点：
				 （1）其定义基本与B-树同，除了：
				 （2）非叶子结点的子树指针与关键字个数相同；
				 （3）非叶子结点的子树指针P[i]，指向关键字值属于[K[i], K[i+1])的子树（B-树是开区间）；
				 （4）为所有叶子结点增加一个链指针；
				 （5）所有关键字都在叶子结点出现；
如：M = 3，下图：
![](http://a2.qpic.cn/psb?/V14EGSbs4eQiTA/D*caDlMY9SwxSolOT5czq1HE1NMjZm5SIPg4g9moRxI!/b/dKkAAAAAAAAA&bo=oQPQAaED0AEDACU!&rf=viewer_4)
 4. B*树
			是B+树的变体，在B+树的非根和非叶子结点再增加指向兄弟的指针；
![](http://a1.qpic.cn/psb?/V14EGSbs4eQiTA/d5qP*cjSk7XXjKw20pHYIuDd*GHSUEf2VORWsTxC*J4!/b/dKsAAAAAAAAA&bo=oQPHAaEDxwEFACM!&rf=viewer_4)


    
    