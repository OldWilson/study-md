# Dart

## 基础

### 1. 问号

1. `String? name`
   * 可以让静态检查通过，表示可空类型
2. `String a = b ?? 'hello'`
   * b不为空则a等于b；b为空，则a等于hello
3. `b ??= 'hello'`
   * b为null则其赋值为hello， 否则不会改动
4. `a?.p a?.m()`
   * 如果a为空，则直接返回null，不执行后续操作

