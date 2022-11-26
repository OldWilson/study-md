# QA

* `Github enterprise - remote: Password authentication is not available for Git operations`

  * 解决方法

    > git remote set-url origin git@github.xxx.com:xxxxx

* `git remote set-url origin git@github.xxx.com:xxxxx`

  * 解决方法

    >git config --global --unset http.proxy
  	>git config --global --unset https.proxy

* `HTTP/2 stream 1 was not closed cleanly before end of the underlying stream`

  * 解决方法：

    > git config *--global http.version HTTP/1.1*

* `国内github 无法访问`

  * mac

    * 在`/etc/hosts`中添加：

      ```tex
      # github
      20.205.243.166	github.com
      20.205.243.166  gist.github.com
      20.205.243.166  assets-cdn.github.com
      20.205.243.166  raw.githubusercontent.com
      20.205.243.166  gist.githubusercontent.com
      20.205.243.166  cloud.githubusercontent.com
      20.205.243.166  camo.githubusercontent.com
      20.205.243.166  avatars0.githubusercontent.com
      20.205.243.166 avatars1.githubusercontent.com
      20.205.243.166 avatars2.githubusercontent.com
      20.205.243.166 avatars3.githubusercontent.com
      20.205.243.166 avatars4.githubusercontent.com
      20.205.243.166 avatars5.githubusercontent.com
      20.205.243.166 avatars6.githubusercontent.com
      20.205.243.166 avatars7.githubusercontent.com
      20.205.243.166 avatars8.githubusercontent.com
      ```

    * 刷新DNS

      >sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder   # macOS 13