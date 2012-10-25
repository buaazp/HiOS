# HiOS框架是基于Apple提供的instruments工具而开发的iOS自动化测试和持续集成工具
# 程序作者@招牌疯子，欢迎新浪微博互粉
# 本套框架完全开源，遵从GPL协议
# 如有问题和建议请联系zp@buaa.us
# 2012.10.17
#!/bin/bash
source ./conf/conf.sh
sTime=$[$maxRunTime*3600]
echo $sTime
sleep $sTime
#关闭模拟器结束本次测试
appid=`ps aux|grep "MacOS/iPhone Simulator"|grep -v grep|awk -F ' ' '{print $2}'`
if [ $appid ]; then
    echo $appid
    kill -9 $appid
fi
