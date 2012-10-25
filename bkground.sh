# HiOS框架是基于Apple提供的instruments工具而开发的iOS自动化测试和持续集成工具
# 程序作者@招牌疯子，欢迎新浪微博互粉
# 本套框架完全开源，遵从GPL协议
# 如有问题和建议请联系zp@buaa.us
# 2012.10.17
#!/bin/bash
source ./conf/conf.sh
if [ $1 ]; then
    sTime=$[$1*36]
else
    sTime=$[$maxRunTime*3600]
fi
echo $sTime
sleep $sTime
#关闭instruments结束monkey测试
instrumentsid=`ps aux|grep -i /instruments|grep -v grep|awk -F ' ' '{print $2}'`
if [ -z $instrumentsid ]; then
    echo "instruments.app is not running!"
else
    echo "killing... instruments pid is "$instrumentsid
    kill -9 $instrumentsid
fi
