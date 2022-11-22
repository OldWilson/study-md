# QA

## Mac

1. `Fatal Error. Failed to ping backend API`

   > * Command + 空格，搜索`活动监视器`。在`活动监视器`中搜索docker并将其关闭。
   >
   > * `cd ~/Library/Group\ Containers/group.com.docker/`
   >
   > * `rm -f settings.json`
   > * 重启docker。