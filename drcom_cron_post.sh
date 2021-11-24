#!/bin/sh
server=10.255.255.222
user=username
password=password
html_file="/root/drcom.html"
#(一)检测是否是登录状态
logger "【Dr.COM网页认证】开始定时检测"
curl http://${server} > ${html_file}	#保存网页到drcxom.html
check_status=`grep "Dr.COMWebLoginID_0.htm" ${html_file}`
# Dr.COMWebLoginID_0.htm 登陆页（未登陆）
# Dr.COMWebLoginID_1.htm 注销页（已登录）
# Dr.COMWebLoginID_2.htm 登陆失败页
# Dr.COMWebLoginID_3.htm 登陆成功页
if [[ $check_status != "" ]]
then
    #尚未登录
    logger "【Dr.COM网页认证】上网登录窗尚未登录"
	curl -X POST "http://${server}" -H "Origin: http://${server}" -H "Connection: keep-alive" -H "Cache-Control: max-age=0" -H "Upgrade-Insecure-Requests: 1" -H "Content-Type: application/x-www-form-urlencoded" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9" -H "DNT: 1" -H "Referer: http://${server}" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7,und;q=0.6" -b "vlan=0; ssid=null; areaID=null; program=2018050401-hnkj; save_DDDDD=用户名; save_upass=密码; ISP_select=@telecom; md5_login2=|,0,用户名@运营商|密码;" --data "DDDDD=${user}&upass=${password}&R1=0&R2=&R3=0&R6=0&para=00&0MKKey=123456&buttonClicked=&redirect_url=&err_flag=&username=&password=&user=&cmd=&Login=&v6ip=" --tlsv1.3 //curl	#发送Post认证请求
    # 此处为你已修改完毕的curl

    logger "【Dr.COM网页认证】上网登录窗未登录，现已登录"
    curl -s "https://api.telegram.org/bot(这里是token)/sendMessage?chat_id=（这里是你的id）" --data-binary "&text=【OpenWrt联网状态】当前路由器未联网，已执行登录。当前时间 ""`date`" &
    logger "【Dr.COM网页认证】已通过 Telegram Bot 发送当前时间"
else
    #已经登录
    logger "【Dr.COM网页认证】上网登录窗之前已登录"
    curl -s "https://api.telegram.org/bot(这里是token)/sendMessage?chat_id=（这里是你的id）" --data-binary "&text=【OpenWrt联网状态】当前路由器之前已登录，无需执行登录。当前时间 ""`date`" &
    logger "【Dr.COM网页认证】已通过 Telegram Bot 发送当前时间"
fi
logger "【Dr.COM网页认证】结束定时检测"

