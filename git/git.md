# Git

## command

## 教程

### 1. 放弃本地文件修改

* 删除本地修改的文件

  ```
  git checkout -- 文件名
  git checkout -- 文件名1 文件名2
  ```

### 2. 撤销本地修改

* ```
  git reset HEAD~        # 保留修改的文件
  git reset HEAD~N
  git reset --hard HEAD~ # 丢失本地修改的文件
  ```

### 3. 从git中删除文件而不从文件系统中删除

* git add后，要从暂存区删除某个文件，本地文件系统保留

  ```bash
  git reset filename
  ```

* 将文件添加到.gitingore

  ```bash
  echo filename >> .gitignoreß
  ```

### 4. 编辑commit未push的信息

* ```bash
  git commit --amend   # start $EDITOR to edit the message
  git commit --amend   # set the new message directly
  ```

* --amend会创建一个替换前一个提交的新提交。不能修改已push到远程仓库的提交。ß

### 5. 推送前清理本地提交

### 6. 恢复推送的提交

### 7. 避免重复的合并冲突

### 8. 找到合并后破坏了某些内容的提交

### 9. 使用git hook避免常见错误

### 10. 修改默认分支master为main分支

#### 1. 创建main分支，并提交

```sh
git checkout -b main
git checkout origin main
```

#### 2. 修改默认分支

![image-20220601085617172](C:\Users\zefeng\AppData\Roaming\Typora\typora-user-images\image-20220601085617172.png)

#### 3. 删除master

```sh
git branch -d master
git push origin :master
```







