# Git

## command

### 放弃本地文件修改

* 删除本地修改的文件

  ```
  git checkout -- 文件名
  git checkout -- 文件名1 文件名2
  ```

### 撤销本地修改

* ```
  git reset HEAD~        # 保留修改的文件
  git reset HEAD~N
  git reset --hard HEAD~ # 丢失本地修改的文件
  ```

### 从git中删除文件而不从文件系统中删除

* git add后，要从暂存区删除某个文件，本地文件系统保留

  ```bash
  git reset filename
  ```

* 将文件添加到.gitingore

  ```bash
  echo filename >> .gitignoreß
  ```

### 编辑commit未push的信息

* ```bash
  git commit --amend   # start $EDITOR to edit the message
  git commit --amend   # set the new message directly
  ```

* --amend会创建一个替换前一个提交的新提交。不能修改已push到远程仓库的提交。ß

### 推送前清理本地提交

### 恢复推送的提交

### 避免重复的合并冲突

### 找到合并后破坏了某些内容的提交

### 使用git hook避免常见错误



