# Deque

1. Deque（double ended queue）是一个双端队列接口，继承自Queue接口
2. Deque的实现类是LinkedList、ArrayQueue、LinkedBlockingDeque、ConcurrentLinkedDeque
3. 先进先出(FIFO)
   * addLast()：向队尾插入元素，失败抛出异常
   * offerLast()：向队尾插入元素，失败返回false
   * removeFirst()：获取并删除队首元素，失败抛出异常
   * pollFirst()：获取并删除队首元素，失败返回null
   * getFirst()：获取但不删除队首元素，失败抛出异常
   * peekFirst()：获取但不删除队首元素，失败返回null
4. 先进后出（LIFO）
   * addFirst()：向栈顶插入元素，失败则抛出异常
   * offerFirst()：向栈顶插入元素，失败返回false
   * removeFirst()：获取并删除队首元素，失败抛出异常
   * peekFirst()：获取但不删除队首元素，失败返回null
5. 不支持索引访问元素
   * removeFirstOccurrence(Object o)：从此双端队列中 移除指定元素的第一个匹配项
   * removeLastOccurrence(Object o)：从此双端队列中移除指定
