#!/bin/sh
server=10.255.255.222
user=username
password=password
html_file="/root/drcom.html"
#检测登录状态
logger "【Dr.COM网页认证】开始定时检测"
curl http://${server} > ${html_file}	#保存网页到drcom.html
check_status=`grep "Dr.COMWebLoginID_0.htm" ${html_file}`
# Dr.COMWebLoginID_0.htm 登陆页（未登陆）
# Dr.COMWebLoginID_1.htm 注销页（已登录）
# Dr.COMWebLoginID_2.htm 登陆失败页
# Dr.COMWebLoginID_3.htm 登陆成功页
if [[ $check_status != "" ]]
then
    #尚未登录
    logger "【Dr.COM网页认证】上网登录窗尚未登录"
	curl -s "http://${server}/drcom/login?callback=dr1003&DDDDD=${user}&upass=${password}&0MKKey=123456&R1=0&R2=&R3=0&R6=0&para=00&v6ip=&terminal_type=1&lang=zh-cn&jsVersion=4.1.3&v=1897&lang=zh"	#发送get认证请求
    # 此处为你已修改完毕的curl
    logger "【Dr.COM网页认证】上网登录窗未登录，现已登录"
    curl -s "https://api.telegram.org/bot1860358075:AAGRAC3lc3B6MBzbxGfNg85CZW-GVXhN4DY/sendMessage?chat_id=600694974" --data-binary "&text=【OpenWrt联网状态】当前路由器未联网，已执行登录。当前时间 ""`date`" &
    logger "【Dr.COM网页认证】已通过 Telegram Bot 发送当前时间"
else
    #已经登录
    logger "【Dr.COM网页认证】上网登录窗之前已登录"
    curl -s "https://api.telegram.org/bot1860358075:AAGRAC3lc3B6MBzbxGfNg85CZW-GVXhN4DY/sendMessage?chat_id=600694974" --data-binary "&text=【OpenWrt联网状态】当前路由器之前已登录，无需执行登录。当前时间 ""`date`" &
    logger "【Dr.COM网页认证】已通过 Telegram Bot 发送当前时间"
fi
logger "【Dr.COM网页认证】结束定时检测"


