# thymeleaf

## 标签

1. th:field：可以在页面初始化的时候给对应的元素生成id。

2. th:id：类似htm标签中的id属性

3. th:text和th:utext：文本显示

4. th:object：用于表单数据对象绑定

5. th:action：定义后台控制器路径，类似<form>标签的action属性

   ```html
   <form action="subscribe.html" th:action="@{/subscribe}">
   ```

6. th:href：定义超链接，类似<a>标签的href属性，形式为@{/main.css}

7. th:src：用于外部资源的引入，类似于<script>标签的src属性

   ```html
   <script th:src="@{/js/jquery-2.4.min.js}"></script>
   ```

8. th:value：用于标签赋值

9. th:if和th:unless

   * thymeleaf支持的写法

     ```html
     <div th:if="${user.isAdmin()} == false"></div>
     ```

   * OGNL或SpringEL库支持的写法

     ```html
     <div th:if="${user.isAdmin() == false}"></div>
     ```

10. th:switch和th:case

    * 一个case被判断为真，那么其他的同等级的case都将被判断为假

      ```html
      <div th:switch="${user.role}">
        <p th:case="admin">管理员1</p>
        <p th:case="#{roles.manager}">管理员2</p>
        <p th:case="*">其他用户</p>
      </div>
      ```

11. th:with

    * 定义变量，定义多个变量可以用逗号分隔。

    * ```html
      <div th:with="firthParam=${persons[0]}, secondParam=${persons[1]}">
      	<p>
          <span th:text="${firstParam.name}"></span>
        </p>
      </div>
      ```

    * 允许重用变量定义在相同的属性：

      ```html
      <div th:with="compan=${user.company + 'cc'}, account=${accounts[company]}"></div>
      ```

12. th:remove

    * 移除除了第一个外的静态数据，用第一个tr标签进行循环迭代显示

## 表达式

1. 变量表达式：${...}

2. 选择表达式：*{...}。一般跟在th:object后，直接选择object中的属性

3. 消息文字表达式：#{...}

   ```html
   <p th:utext="#{welcome}">welcome to our company.</p>
   ```

4. 链接url表达式：@{...}