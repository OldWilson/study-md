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