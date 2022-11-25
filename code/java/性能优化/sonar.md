# Sonar

## 1. 使用非同步类代替同步类

1. 问题

   ```tex
   Replace the synchronized class "Stack" by an unsynchronized one such as "Deque".
   ```

2. 解释

   * 非同步的类在执行效率上会高于同步的类，所以在不是必须同步的情况下，建议使用非同步类

3. 处理方案

   ```tex
   ArrayList or LinkedList instead of Vector
   Deque instead of Stack
   HashMap instead of Hashtable
   StringBuilder instead of StringBuffer
   ```

   