# Homebrew

> Formulae：软件包，包括了这个软件的依赖、源码位置及编译方法等
>
> Casks：已经编译好的应用包，如图形界面程序等¥

## install

1. 安装方式：

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. 环境变量

   ```bash
   sudo vim ~/.zshrc
   > export PATH="/usr/local/bin:/usr/local/sbin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
   source ~/.zshrc
   ```

   

## 切换homebrew源

1. 替换homebrew源

   ```bash
   cd "$(brew --repo)"
   git remote set-url origin https://mirrors.ustc.edu.cn/brew.git
   ```

2. 切换homebrew Core源

   ```bash
   cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
   git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git
   ```

3. 切换homebrew Cask源

   ```bash
   cd "$(brew --repo)"/Library/Taps/homebrew/homebrew-cask
   git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git
   ```

## 命令

### 1. 安装

```bash
brew install <package>
brew uninstall <package>
brew reinstall <package>

brew uninstall --force <package>
```

### 2. 搜索

```bash
brew search <package> # 搜索置顶软件
```

### 3. 更新

```bash
brew update # 更新brew

brew upgrade # 更新所有软件
brew upgrade <package> # 更新指定软件
```

### 4. 查看homebrew相关路径

```bash
brew --cache # 下载缓存路径
brew --prefix # 安装路径，通常是该路径的Cellar目录下
```

### 5. 查看安装的软件

```bash
brew list # 所有安装的软件，包括formulae和cask
brew list --formulae # 所有安装的formulae
brew list --cask # 所有安装的cask
brew list <package> # 列出指定软件的详细路径
```

### 6. 查看可更新的软件

```bash
brew outdated
```

### 7. 清理旧版本软件

```bash
brew cleanup # 清理所有旧版本的包
brew cleanup <package> # 清理指定旧版本的包
brew cleanup -n # 查看可清理的旧版本包
```

### 8. 锁定某个不想更新的软件

```bash
brew pin <package> # 锁定指定包
brew unpin <package> # 取消锁定指定包
```

### 9. 查看已安装软件的依赖

```bash
brew deps --installed --tree
```

### 10. 查看软件信息

```bash
brew info <package> # 显示某个包的信息
brew info # 显示安装的软件数量、文件数量以及占用空间
```



## QA

### 1. 安装包卡在 Updating Homebrew 

```bash
vim ~/.bash_profile
> export HOMEBREW_NO_AUTO_UPDATE=true
source ~/.bash_profile
```



