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