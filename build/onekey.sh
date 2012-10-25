# HiOS框架是基于Apple提供的instruments工具而开发的iOS自动化测试和持续集成工具
# 程序作者@招牌疯子，欢迎新浪微博互粉
# 本套框架完全开源，遵从GPL协议
# 如有问题和建议请联系zp@buaa.us
# 2012.10.17
#!/bin/bash
source ../conf/conf.sh

deviceType=$1
if [ $deviceType == 0 ]; then

    #如果模拟器在运行则关闭模拟器程序
    appid=`ps aux|grep "MacOS/iPhone Simulator"|grep -v grep|awk -F ' ' '{print $2}'`
    if [ -z $appid ]; then
        echo "iPhone Simulator is not running!"
    else
        echo "killing... iPhone Simulator's pid is "$appid
        kill -9 $appid
    fi
    #清空模拟器的APP目录，防止之前安装的APP影响
    rm -r "${simuDir}"
    echo rm -rf "${simuDir}"
    #新建模拟器的APP目录
    mkdir -p "${simuAppDir}"
    echo mkdir -p "${simuAppDir}"
    #将编译好的.app文件夹拷贝到模拟器APP目录
    cp -r "${buildSimuDir}" "${simuAppDir}"
    echo cp -rf "${buildSimuDir}" "${simuAppDir}"

else
    #install the ipa
    ./appinstaller  "${compileDir}${ipaName}" 
    echo "${ipaName} installed!"
fi
