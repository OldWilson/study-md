# QA

* <font title="red">Github enterprise - remote: Password authentication is not available for Git operations</font>

  * <font title="green">解决方法</font>

    ```
    git remote set-url origin git@github.xxx.com:xxxxx
    ```

* <font>git remote set-url origin git@github.xxx.com:xxxxx</font>

  * <font title="green">解决方法</font>

  * 修改代理

    ```
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    ```

  
  