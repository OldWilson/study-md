# security

## （跨站脚本）xss

> XSS攻击是代码注入，最常见的是基于DOM的攻击。



1. 有风险的位置：

   * HTML
   * 样式（CSS）
   * 属性
   * 资源（文件内容）

2. 防止 XSS 攻击方式

   1. `vue-sanitize`，清理代码中出现的问题，以防止XSS攻击。

      ```typescript
      import VueSanitize from "vue-sanitize";
      Vue.use(VueSanitize);
      
      defaultOptions = {
          allowedTags: ['a', 'b'],
          allowedAttributes: {
              'a': ['href']
          }
      }
      Vue.use(VueSanitize, defaultOptions);
      ```

      

## （跨站请求伪造）csrf

