# Cognito

## 基础知识

* 链接：https://docs.aws.amazon.com/zh_cn/cognito/latest/developerguide/

* 用户池
  
  1. lambda触发器
  
  2. 电子邮件设置
  
     * 默认电子邮件功能：内置于cognito服务中。
  
       1. 限额
          * 每个aws账户每天发送的最大电子邮件数：50
          * 电子邮件主题中的最大字符数：140
          * 电子邮件中的最大字符数：20000
          * 注册确认代码：24小时
          * 用户属性验证码有效性：24小时
          * 忘记密码代码：1小时
       2. FROM地址
          * 默认电子邮件地址，即no-reply@verificationemail.com
          * 自定义电子邮件地址。在使用自己的电子邮件地址之前，必须向SES验证此地址。还必须向cognito授予使用此地址的权限。
  
     * Amazon SES配置
  
       1. 应用程序需要的发送量高于默认选项时，使用ses配置电子邮件。
  
       2. 配置区域
  
          * 必须从一下区域进行选择
  
            * us-east-1
            * us-west-2
            * eu-west-1
  
          * 示例
  
            | 用户池区域      | 建议SES区域示例 |
            | --------------- | --------------- |
            | us-east-1       | us-east-1       |
            | ca-central-1    | us-east-1       |
            | us-east-2       | us-east-1       |
            | us-west-2       | us-west-2       |
            | ap-northeast-1  | us-west-2       |
            | sap-northeast-2 | us-west-2       |
            | ap-south-1      | us-west-2       |
            | ap-southeast-1  | us-west-2       |
            | ap-southeast-2  | us-west-2       |
            | eu-west-1       | eu-west-1       |
            | eu-central-1    | eu-west-1       |
            | eu-west-2       | eu-west-1       |
  
            
  
* 身份池

## 代码

