# python

## 基础

### 模块

1. import
   * import 模块名
   * import 包名.模块名
   * import 模块名 as 别名
   
2. from import
   * from 包名.模块名 import 变量1，变量2，...
   * from 包名 import 模块名
   * from 包名.模块名 import * 
     * 引入模块下所有的变量
     * *对应引用模块中的\__all__
     * \_\_all__设置方式：\_\_all\_\_ = ['变量1', '变量2', ...]
   * 换行方式
     * 在行末使用"\\"
     * 用小括号将换行内容括起来
   
3. \_\_init__.py
   * 每个包里都会有一个\_\_init__.py文件
   * 导入包时，\_\_init__.py首先被执行
   
3. 模块内置变量
   
   1. dir()：返回模块中的所有变量，包含内置变量和自定义变量
   
      * 无参数时，但因当前模块中所有变量
      * 有参数时，显示指定的模块或类中的变量
   
   2. 个别内置变量
   
      * \_\_name\_\_：命名空间。值为\_\_main\_\_时，执行文件是入口文件
   
      * \_\_package\_\_：包名。入口文件不属于任何包
   
      * \_\_file\_\_：当前模块在系统中的物理路径。取决于python命令执行时所在的文件目录
   
      * \_\_doc\_\_：三引号中的文档注释内容
   
   3. 判断一个模块是否是入口文件
   
      ```python
      if __name__ == '__main__'
      ```
   
   4. 将python文件作为普通模块执行
   
      ```shell
      python -m demo.helloworld
      ```
   
      * 作为普通模块的文件，必须有一个包，执行该模块文件时，当前路径至少在其上一层
   
3. 导入
   
   * 顶级包：一个模块的顶级包由其与入口文件的关系决定。与入口文件同级的包，即为该包下所有模块的顶级包
   * 绝对导入：要从顶级包开始导入
   * 相对导入：用`.`表示当前目录；用`..`表示上级目录；用`...`表示上上级目录，以此类推
     * 入口文件不能使用相对导入，因为入口文件没有包

### 函数

1. 内置函数

   * round(A, m)：执行四舍五入，将A保留m位小数，如果m超过A原本的小数位，返回结果A

2. 自定义函数

   * 定义函数方法：def funcname():

   * return

     * 函数中无return，相当于return (None)

     * 可以返回任意类型的变量

     * 可以返回多个值，返回类型为元组

       ```python
       return param1, param2,...
       ```

   * 序列解包与链式赋值

     ```python
     a, b, c = 1, 2, 3  # a = 1;b = 2;c = 3 
     
     d = 1, 2, 3  # tuple
     a, b, c = d  # a = 1;b = 2;c = 3 序列解包
     
     a = b = c = 1 # 链式赋值
     ```

   * 关键字参数

     ```python
     def add(x, y):
     	return x + y
     	
     print(add(y = 2, x = 1))
     ```

   * 默认参数

     ```python
     def add(x, y, z = 1):
     	return x + y + z
     ```

     * 默认参数必须在非默认参数之后，否则报错

   * 可变参数

     ```python
     def demo(*param): # param 类型为tuple
     	print(param)
     ```

     * *作用类似解包，将元组中的元素传入可变参数中
     * 传入参数的个数是可变的，可以是1个，2个，无数个；传入参数类型为list或者tuple
   
   * 参数定义顺序：必须参数，可变参数，默认参数 
   
   * 关键字可变参数
   
     * **可以表示多个关键字可变参数
     * 允许你传入0个或任意个含参数名的参数
     
     ```python
     def demo(**param): # param 类型为dict
     	print(param.a)
     	print(param.b)
     	print(param.c)
       
     demo(a='aaa', b='bbb', c='ccc')
     
     val = {a:'aaa', b:'bbb', c:'ccc'}
     demo(**val )
     ```

### 类

1. 实例方法访问类变量

   * 类名.类变量
   * self.__class__.param

2. 类方法

   * 定义

     ```python
     @classmethod
     def test_demo(cls):
       cls.param += 1
     	print('ssss')
     ```

   * 调用方式：类名.类方法  / 对象名.类方法

3. 静态方法

   * 定义

     ```python
     @staticmethod
     def test_demo(x, y):
     	print(x + y)
     	
     demo1 = demo()
     demo1.test_demo(1, 2)
     demo.test_demo(1, 2)
     ```

   * 调用方式：类名.静态方法 / 对象名.静态方法

   * 类方法和静态方法不能访问实例变量（self.实例变量名）

4. 成员可见性

   * 默认公开

   * 定义私有：在变量或方法前加`__`

     ```python
     class demo():
     	def __test_demo(self, name):
         self.__name = name
     		print('私有')
     ```

   * `__init__`可以在外部访问，因为在末尾也添加了`__`

5. 继承

   * 定义

     ```python
     class parent():
       sum = 0
       def __init__(self, name, age):
         self.name = name
         self.age = age
     	def get_name(self):
         return self.name
      
     from demo import parent
     class demo001(demo):
       def __init(self, score, name, age):
         self.score = score
         # parent.__init__(self, name, age)
         super(demo001, self).__init__(name, age)
         
     ```

   * 子类调用父类方法：super



### 正则表达式与JSON

1. 正则表达式

   1. ```python
      import re
      a = 'python 11\tjava'
      r = re.findall('python', a, re.I | re.S)	
      ```

   2. 匹配模式

      * re.I：忽略大小写
      * re.S：匹配所有字符，包括\n
   
   3. sub
   
      ```python
      import re
      
      data = 'PythonC#JavaC#PHP'
      
      def convert(value):
        matched = value.group()
        return '!!' + matched
      
      print(re.sub('C#', convert, data, 1))
      ```
   
   4. match, search
   
      ```python
      import re
      
      s = 'Add2234lls3443566'
      
      print(re.match('\d', s))
      print(re.search('\d', s))
      ```
   
      1. match：从字符串的第一个字符匹配，如果没有匹配到，则会返回None
      2. search：搜索整个字符串，直到找到第一个满足正则的结果，将其返回。
      3. match和search只会匹配一次
   
   5. group分组
   
      ```python
      import re
      
      s = 'life is short,i use python'
      r = re.search('life(.*)python', s)
      print(r.group(1)) // ' is short,i use '
      
      r = re.findAll('life(.*)python', s)
      print(r) // [' is short,i use ']
      ```
   
1. JSON

   1. JavaScript Object Notation, JavaScript对象标记
   
   2. 一种轻量级的数据交换格式
   
   3. 反序列化：json转为python对象

      ```python
      import json
      json_str = '{"name": "test"}'
      print(json.loads(json_str)) // dict
      ```
   
      * 数据类型的映射：
   
        ```txt
        json		python
        object	dict
        array		list
        string	str
        number	int
        number	float
        true		True
        false		False
        null		None
        ```
   
        
   
   4. 序列化：python对象转为json
   
      ```python
      import json
      jsonObj = [
        {'name': 'test1'},
        {'name': 'test2', 'age': 30}
      ]
      print(json.dump(jsonObj)) // str
      ```

### 枚举

1. 定义：

   ```python
   class status(Enum):
     SUCCESS = 1
     FAULT = 2
   ```

2. 操作

   ```
   print(status.SUCCESS.vaule) // 1
   print(status.SUCCESS.name) // SUCCESS str
   print(status.SUCCESS) // status.SUCCESS enum
   ```

3. 别名：多个枚举类元素value相同，除第一个外都作为第一个的别名

   * 遍历时，别名不会返回

   * 遍历别名：

     ```python
     for v in status.__memebers__.items():  // 返回key和value
       
     for v in statu.__memebers__:  // 返回key
     ```

4. value转为枚举类型

   ```python
   a = 1
   print(status(a))
   ```

### 函数式编程

1. 匿名函数

   1. lambda表达式：lambda params: expression

      ```python
      f = lambda x, y: x + y
      f(1, 2)
      ```

   2. map

      * map(a, b)：a为函数，b为序列，map对b中每一个值执行a中的函数，相当于for循环

      * 返回值为对象，可以使用list()转换数据类型

      * ```python
        from functools import reduce
        
        list_x = []
        list_y = []
        map(lambda x, y: x + y, list_x, list_y) # 连续执行
        
        reduce(lambda x, y: x + y, list_x)
        
        f = filter(lambda x: True if x==1 eles False, list_x)
        list(f)
        ```

2. 装饰器

   1. ```python
      import time
      
      def timePrint(func):
        def test():
          print(time.time())
          func()
        return test
      
      def f1():
        print('This is a function')
        
      timePrint(f1)
      ```

   2. ```python
      @timePrint
      def f1():
        print('This is a function')
        
      f1()
      ```

   3. ```
      import time
      
      # 带参数
      def timePrint(func):
        def test(*args):
          print(time.time())
          func(*args)
        return test
        
      @timePrint
      def f1(param):
        print('This is a function')
      ```

   4. ```python
      import time
      
      # 带参数
      def timePrint(func):
        def test(*args, **kw):
          print(time.time())
          func(*args, **kw)
        return test
        
      @timePrint
      def f1(param):
        print('This is a function')
        
      @timePrint
      def f2(param1, **kw):
        print('This is a function', param1)
        print('This is a function', **kw)
        
      ```

### 爬虫

### 知识补充

1. 推导式

   ```python
   a = [1, 2, 3, 4, 5]
   b = [i**2 for i in a] // 列表推导式
   
   c = {1, 2, 3, 4, 5}
   d = {i**2 for i in c if i >=3} // set推导式
   
   students = {'aaa': 18, 'bbb': 19, 'ccc': 20}
   keys = [key for key,value in students.items()]
   
   student001 = {value:key for key,value instatus.items()}// 字典
   //元组
   tuple001 = (key for key,value instatus.items())
   for x in tuple001:
     print(x)
   
   ```

2. iterator

   * 可迭代对象（list，set，dict等）：可以重复迭代，一般使用for循环

   * 迭代器：只能迭代一次，可以通过for或next进行迭代

     ```python
     class Book:
       def __init__(self):
         self.data = ['111', '222', '333']
         self.cur = 0
         pass
       def __iter__(self):
         return self
       def __next__(self):
         if self.cur >= len(self.data):
           raise StopIteration()
         r = self.data[self.cur]
         self.cur += 1
         return r
       
     books = Books()
     for book in books:
       print(book)
     print(next(book))
     ```

3. 生成器：generator

   ```python
   def gen(max):
     n = 0
     while n <= max:
       n += 1
       yield n
       
   g = gen(100)
   print(next(g))
   ```

4. None是NoneType类型

5. python把0，空序列，空几何和None都看作False

6. 装饰器等副作用：改变原函数名，原函数注释信息也将不显示

   ```python
   import time
   import functools import wraps
   
   def timePrint(func):
     @wraps(func)
     def test(*args):
       print(time.time())
       func(*args)
     return test
     
   @timePrint
   def f1(param):
     print('This is a function. funcName: ', f1.__name__)
   ```

7. 海象运算符 walrus operator

   * :=：3.8v

   * ```python
     a = 'python'
     
     if (b := len(a)) > 5:
       print(str(b))
     ```

8. 关键字做字符串拼接

   ```python
   messageId = '111'
   print('messageid: ' + messageid)
   print(f'messageid: {messageId}')
   ```

9. 数据类dataclass装饰器

   * 应用场景：类的实例属性赋值

     ```python
     class Student():
       def __init__(self, name, age, sex):
         self.name = name
         self.age = age
         self.sex = sex
         
     # 装饰器
     from dataclasses import dataclass
     
     @dataclass
     class Student():
       name: str
       age: int
       sex: str
     ```

     

### Flask



