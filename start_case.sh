# HiOS框架是基于Apple提供的instruments工具而开发的iOS自动化测试和持续集成工具
# 程序作者@招牌疯子，欢迎新浪微博互粉
# 本套框架完全开源，遵从GPL协议
# 如有问题和建议请联系zp@buaa.us
# 2012.10.17

#!/bin/bash

#xcode命令路径
xcodePath=/Applications/Xcode.app/Contents/Developer/usr/bin
#测试类型
deviceType=$1
#模版目录
#templatePath=~/"Develop/ios-learn/ios_autotest/baiduHi/"
templatePath="./"
#模版名
if [ $deviceType = "0" ]; then
    templateName=baiduhi_simulator.tracetemplate
else
    templateName=baiduhi_iphoneos.tracetemplate
fi
#模块名
module=$2

if [ ! -d ./${module} ]; then
    echo "${module}目录不存在!"
    exit
fi
shift 2


#程序路径
applicationPath=~/"Library/Application Support/iPhone Simulator/5.1/Applications/"
appId=`ls "$applicationPath"`
echo $appId
appPath=$applicationPath$appId
echo $appPath
#程序名
appName=`ls "$appPath" | grep .app`
echo $appName
#构建结果报表
xmlTempString=""
#统计全部case通过情况
caseAllCount=0
caseAllPass=0
caseAllFail=0
caseAllError=0
#统计全部测试时间
timeAllModule=0

#模块的结果报表
xmlTemp=""
#统计模块case通过情况
caseCount=0
casePass=0
caseFail=0
caseError=0
#统计模块测试时间
timeModule=0


for argv in $*
do
    #case id
    caseId=$argv

    #脚本路径
    #scriptPath=~/"Develop/ios-learn/ios_autotest/baiduHi/login/"
    scriptPath=./${module}
    
    #列出js脚本
    #for i in `find ./${module} -type f -name "*.js"`
    i=`find ./${module} -type f -name "*.js" | grep ${caseId}`
    #do
        let "caseCount=caseCount+1"
        scriptName=`basename $i`    #获取*.js文件名
        echo "================开始测试脚本: "$scriptName" ================="
        #脚本名
        #echo $scriptName
        #dirname $i        #获取*.js对应的目录名
        #case执行时间
        timeBegin=`date +%s`
        echo $xcodePath/instruments -t "${templatePath}${templateName}" "${appPath}/${appName}" -e UIASCRIPT "${scriptPath}/${scriptName}" -v | tee ./result/result_${module}_${scriptName}.txt
        $xcodePath/instruments -t "${templatePath}${templateName}" "${appPath}/${appName}" -e UIASCRIPT "${scriptPath}/${scriptName}" -v | tee ./result/result_${module}_${scriptName}.txt
        timeEnd=`date +%s`
        timeUse=$(($timeEnd-$timeBegin))
        timeModule=$(($timeModule+$timeUse))
        echo "time used: "$timeUse"s"
        xmlTemp=$xmlTemp"<testcase classname=\"${module}\" name=\"${scriptName}\" time=\"${timeUse}\">"
        retPass=`grep "Pass" ./result/result_${module}_${scriptName}.txt`
        retFail=`grep "Fail" ./result/result_${module}_${scriptName}.txt`
        retError=`grep "error" ./result/result_${module}_${scriptName}.txt`
        if [ -n "${retPass}" ]; then
            let "casePass=casePass+1"
        elif [ -n "${retFail}" ]; then
            let "caseFail=caseFail+1"
            xmlTemp=$xmlTemp"\n<failure message=\"check error\" type=\"\">\n"$retFail"\n</failure>\n"
        else
            let "caseError=caseError+1"
            xmlTemp=$xmlTemp"\n<error message=\"script error\" type=\"\">\n"$retError"\n</error>\n"
        fi
        xmlTemp=$xmlTemp"</testcase>\n"
        echo "casePass: "$casePass
        echo "caseFail: "$caseFail
        echo "caseError: "$caseError
        echo "caseCount: "$caseCount
        echo "================测试结束脚本: "$scriptName" ================="
    #done
    
done

    xmlTempString=$xmlTempString"<testsuite errors=\"${caseError}\" failures=\"${caseFail}\" name=\"${module}\" tests=\"${caseCount}\" time=\"${timeModule}\">\n"$xmlTemp"</testsuite>\n"
    let "caseAllCount=caseAllCount+caseCount"
    let "caseAllPass=caseAllPass+casePass"
    let "caseAllFail=caseAllFail+caseFail"
    let "caseAllError=caseAllError+caseError"
    let "timeAllModule=timeAllModule+timeModule"


xmlString="<testsuites name=\"hi_ios_quick\" test=\"${caseAllCount}\" pass=\"${caseAllPass}\" failures=\"${caseAllFail}\" errors=\"${caseAllError}\" time=\"${timeAllModule}\">\n<schemaversion>junit 1.0.0</schemaversion>\n"$xmlTempString"</testsuites>\n"
now=`date +%Y%m%d%H%M%S`
#echo $xmlString > report_${now}.xml
echo $xmlString > report.xml
rm -rf *.trace
appid=`ps aux|grep "MacOS/iPhone Simulator"|grep -v grep|awk -F ' ' '{print $2}'`
echo $appid
kill -9 $appid




