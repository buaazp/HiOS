# HiOS框架是基于Apple提供的instruments工具而开发的iOS自动化测试和持续集成工具
# 程序作者@招牌疯子，欢迎新浪微博互粉
# 本套框架完全开源，遵从GPL协议
# 如有问题和建议请联系zp@buaa.us
# 2012.10.17
#!/bin/bash

#app名称
appName="netdisk_iPhone"
ipaName="${appName}.ipa"
#iOS设备UUID
iphoneUuid="7248033d2c26cdbb2f0006a620e67b5191757194"
ipadUuid="8c368d836f25c180515a3613553c1b35a308df40"
#hudson编译任务路径
compileDir="/Users/zippo/develop/ci/workspace/BaiduYun-compile/netdisk/netdisk_iphone/"
#hudson编译版本路径
buildSimuDir=${compileDir}"build/Debug-iphonesimulator/${appName}.app"
buildDir=${compileDir}
#MAC上与设备通信的ssh端口
sshPort="2222"

#模拟器路径
simuDir="/Users/zippo/Library/Application Support/iPhone Simulator/5.1/"
#模拟器application路径
simuAppDir=${simuDir}"Applications"
#iOS设备的application路径
iphoneAppDir="/var/mobile/Applications/"
#xcode命令路径
xcodePath="/Applications/Xcode.app/Contents/Developer/usr/bin"
#monkey运行时间
maxRunTime=2
