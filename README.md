# CQUCC_drcom

## 使用
### 1、使用支持crontab的路由器固件

### 2、确认drcom的认证类型（get or post）
    get使用drcom_cron.sh，post使用drcom_cron_post.sh
### 3、打开文件修改server，user，password。需要tgbot提醒还需要修改tg_token和tg_id
    按照自己的情况修改curl
### 4、Padavan放入/etc/storage并保存，OpenWrt放入/etc。
  添加运行权限
    chmod +x drcom_cron.sh
### 5、在Crontab中添加定时（drcom.txt）也可以按照crontab.guru修改。




## 参考大佬：

* [TigerBeanst](https://jakting.com/archives/drcom-autologin-padavan-tgbot.html)
* [枫谷剑仙](https://www.right.com.cn/forum/thread-249325-1-1.html)
* [chn](https://catalog.chn.moe/)
