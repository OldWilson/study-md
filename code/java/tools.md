## 1. cookie、session及token

### cookie

* 无状态协议：HTTP是无状态的web服务器，下一次对话完全不知道上一次对话发生了什么。

* 过程
  * 浏览器第一次访问服务器端时，服务器创建一个独特的身份标识数据，格式`key=value`，放到`Set-Cookie`字段里，随着响应发给浏览器。
  * 浏览器看到有`Set-Cookie` 字段后就知道这是服务器给的身份标识，就保存起来，下次请求时会自动将此`key=value` 值放到Cookie字段中发给服务器端。
  * 服务器端收到请求后，发现cookie字段中有值，就能根据此值识别用户的身份然后提供个性化的服务。
  
* 记录的信息

  | 参数     | 作用                                                         | 后端设置方法             |
  | -------- | ------------------------------------------------------------ | ------------------------ |
  | Max-Age  | 设置cookie的过期时间，单位秒                                 | cookie.setMaxAge(10)     |
  | Domain   | 指定了cookie所属的域名                                       | cookie.setDomain("")     |
  | Path     | 指定了cookie所属的路径                                       | cookie.setPath("")       |
  | HttpOnly | 告诉浏览器此cookie只能靠浏览器http协议传输，禁止其他方式访问 | cookie.setHttpOnly(true) |
  | Secure   | 告诉浏览器此cookie只能在https安全协议中传输，如果是http则禁止传输 | cookie.setSecure(true)   |

* 缺点

  一旦信息被拦截，那么所有的账户信息都会丢失掉

### session

* session存储在服务器端，客户端只存储sessionId。
* session是在容器中管理的。tomcat、jetty等都是容器。
* session是存储在tomcat的容器中，所以如果后端机器是多台时，多个机器间是无法共享session的。此时可以使用spring提供的分布式session的解决方案，是将session放在redis中。

### token

* token是在服务器端将用户信息经过Base64 url编码后传给客户端，每次用户请求时都会带上这段信息，服务器端拿到此信息进行解密就知道此用户是谁了，这个方法叫做JWT（json web token）。

* token相较于session的优点在于，当后端系统有多台时，由于客户端访问时直接带着数据，因此无需做共享数据的操作。

* token在客户端一般存放在localStorage、cookie或sessionStorage中。服务器端一般存放在数据库中。

* 优点

  * 简洁：可以通过url，post参数或者是在http头参数发送，因为数据量小，传输速度很快。
  * 自包含：由于串包含了用户所需要的信息，避免了多次查询数据库。
  * 因为token是以json的形式保存在客户端的，所以jwt是跨语言的。
  * 不需要在服务端保存会话信息，特别适用于分布式微服务。

* JWT的结构

  * Header：json对象

    * ```json
      {
      	"alg": "HS256",
          "typ": "JWT"
      }
      ```

    * alg属性表示签名的算法(algorithm)，默认是HMAC SHA256；typ属性表示这个令牌的类型。最后将上面的json使用base64URL算法转成字符串。

    * jwt作为令牌，有些场合会放到url中。base64中有三个字符+、/和=，在url中有特殊含义，所以要被替换掉：=被省略、+替换为-、/替换为_。

  * Payload：json对象

    * 用来存放实际需要传输的数据
    * jwt官方规定的字段：
      * iss(issuer)：签发人
      * exp(expiration time)：过期时间
      * sub(subject)：主题
      * nbf(Not Before)：生效时间
      * iat(Issued At)：签发时间
      * jti(JWT ID)：编号
    * 除官方提供的字段，还可以自己定义私有字段。
    * 默认情况下jwt是不加密的，只要进行base64解码就可以读到信息。

  * Signature：对前面的两部分的数据进行签名，防止数据篡改。

    * 首先需要定义一个密钥，这个密钥只有服务器知道，不能泄露给用户，然后使用header中指定的签名算法算出签名，之后将Header、Payload和Signature三部分拼成一个字符串，每个部分用`.` 分割开。

## 2. 浅拷贝和深拷贝

### 浅拷贝（shallow copy）

1. java中的数据类型分为基本数据类型和引用数据类型ß

2. 对于基本数据类型的成员变量，浅拷贝会直接进行值传递。对其中一个对象的成员变量值进行修改，不回影响另一个对象拷贝得到的数据。

3. 对于引用数据类型的成员变量（比如数据、某个类的对象等），浅拷贝会进行引用传递，也就是只是将该成员变量的引用值（内存地址）复制一份给新的对象。在一个对象中修改成员变量会影响到另一个对象的成员变量的值。

4. 重写clone()方法实现浅拷贝

   ```java
   class Strudent implements Cloneable {
     private String name;
     private Age age;
     private int length;
     
     public Object clone() {
       Object obj = null;
           try {
               obj = super.clone();
           } catch (CloneNotSupportedException e) {
               e.printStackTrace();
           }
           return obj;
     }
   }
   ```

   

### 深拷贝（deep copy）

1. 不仅要复制对象的所有基本数据类型的成员变量值，还要为所有引用数据类型的成员变量申请存储空间，并复制每个引用数据类型成员变量所引用的对象，直到该对象可达到的所有对象。
2. 简单的说，深拷贝对引用数据类型的成员变量的对象都开辟了内存空间；浅拷贝只是传递地址指向。
3. 通过为每一个引用到的类重写clone()方法实现深拷贝
4. 通过序列化实现深拷贝