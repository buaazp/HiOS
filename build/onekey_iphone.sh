# HiOS框架是基于Apple提供的instruments工具而开发的iOS自动化测试和持续集成工具
# 程序作者@招牌疯子，欢迎新浪微博互粉
# 本套框架完全开源，遵从GPL协议
# 如有问题和建议请联系zp@buaa.us
# 2012.10.17
#!/bin/bash
source ../conf/conf.sh
#手机安装采用第三方app【同步推】来实现，因此要求测试手机已越狱并且安装了ssh服务，同时在mac上也要开启sshviausb程序来实现ssh通讯功能
scp -P ${sshPort} "${compileDir}${ipaName}" root@localhost:"${iphoneAppDir}${tbtuiUuid}"/Documents
echo scp -P ${sshPort} "${compileDir}${ipaName}" root@localhost:"${iphoneAppDir}${tbtuiUuid}"/Documents
