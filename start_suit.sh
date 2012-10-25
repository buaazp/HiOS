# HiOS框架是基于Apple提供的instruments工具而开发的iOS自动化测试和持续集成工具
# 程序作者@招牌疯子，欢迎新浪微博互粉
# 本套框架完全开源，遵从GPL协议
# 如有问题和建议请联系zp@buaa.us
# 2012.10.17
#!/bin/bash
source ./conf/conf.sh
#测试类型
deviceType=$1
#模版目录
templatePath="./template"
shift


#程序路径
applicationPath=${simuAppDir}
appPath=$applicationPath
searchApp=`ls "$applicationPath" | grep ${appName}`
if [ ! $searchApp ]; then
    appId=`ls "$applicationPath"`
    echo "appId={"$appId"}"
    for i in $appId
    do
        appPath=$applicationPath/$i
        # echo "appPath="$appPath
        searchApp=`ls "$appPath" | grep ${appName}`
        if [ $searchApp ]; then
            break
        fi
    done
fi
echo "查找结束，找到的target为: "$appPath"/"$searchApp

#构建结果报表
xmlTempString=""
#统计全部case通过情况
caseAllCount=0
caseAllPass=0
caseAllFail=0
caseAllError=0
#统计全部测试时间
timeAllModule=0

#按模块执行
for argv in $*
do
    #模块名
    module=$argv
    #模块路径
    modulePath=./cases/${module}
    if [ ${module} == "include" ]; then
        echo "${module}是引用文件，跳过。"
        continue
    fi

    if [ ! -d ${modulePath} ]; then
        echo "${modulePath}目录不存在!"
        continue
    fi

    #模块的结果报表
    xmlTemp=""
    #统计模块case通过情况
    caseCount=0
    casePass=0
    caseFail=0
    caseError=0
    #统计模块测试时间
    timeModule=0
    #脚本路径
    #scriptPath=~/"Develop/ios-learn/ios_autotest/baiduHi/login/"
    scriptPath=${modulePath}
    
    #列出js脚本
    for i in `find ${modulePath} -type f -name "*.js"`
    do
        let "caseCount=caseCount+1"
        scriptName=`basename $i`    #获取*.js文件名
        echo "================开始测试脚本: "$scriptName" ================="
        #脚本名
        #echo $scriptName
        #dirname $i        #获取*.js对应的目录名
        #case执行时间
        timeBegin=`date +%s`

        #如果instruments在运行则关闭
        instrumentsid=`ps aux|grep -i /instruments|grep -v grep|awk -F ' ' '{print $2}'`
        echo "instrumentsid:"$instrumentsid
        if [ -z $instrumentsid ]; then
            echo "instruments.app is not running!"
        else
            echo "killing... instruments pid is "$instrumentsid
            kill -9 $instrumentsid
        fi

        #构造参数执行instruments命令
        if [ $deviceType = "0" ]; then
            templateName=tp.simulator.tracetemplate
            target="${appPath}/${searchApp}" 
            echo "begin!"
            echo $xcodePath/instruments -t "${templatePath}/${templateName}" "${target}" -e UIASCRIPT "${scriptPath}/${scriptName}" -v
            $xcodePath/instruments -t "${templatePath}/${templateName}" "${target}" -e UIASCRIPT "${scriptPath}/${scriptName}" -v | tee ./result/result_${module}_${scriptName}.txt
            echo "done!"
        else
            # appName=$ipaName
            templateName=tp.iphoneos.tracetemplate
            target=$iphoneUuid
            
            echo "begin!"
            echo $xcodePath/instruments -t "${templatePath}/${templateName}" -w "${target}" "${appName}" -e UIASCRIPT "${scriptPath}/${scriptName}" -v
            $xcodePath/instruments -t "${templatePath}/${templateName}" -w "${target}" "${appName}" -e UIASCRIPT "${scriptPath}/${scriptName}" -v | tee ./result/result_${module}_${scriptName}.txt
            echo "done!"
        fi

        #计算和输出结果报表
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
    done
    xmlTempString=$xmlTempString"<testsuite errors=\"${caseError}\" failures=\"${caseFail}\" name=\"${module}\" tests=\"${caseCount}\" time=\"${timeModule}\">\n"$xmlTemp"</testsuite>\n"
    let "caseAllCount=caseAllCount+caseCount"
    let "caseAllPass=caseAllPass+casePass"
    let "caseAllFail=caseAllFail+caseFail"
    let "caseAllError=caseAllError+caseError"
    let "timeAllModule=timeAllModule+timeModule"
done

xmlString="<testsuites name=\"hi_ios_quick\" test=\"${caseAllCount}\" pass=\"${caseAllPass}\" failures=\"${caseAllFail}\" errors=\"${caseAllError}\" time=\"${timeAllModule}\">\n<schemaversion>junit 1.0.0</schemaversion>\n"$xmlTempString"</testsuites>\n"
now=`date +%Y%m%d%H%M%S`
#echo $xmlString > report_${now}.xml
echo $xmlString > report.xml
#清理运行log文件
rm -rf *.trace
#关闭模拟器结束本次测试
appid=`ps aux|grep "MacOS/iPhone Simulator"|grep -v grep|awk -F ' ' '{print $2}'`
if [ $appid ]; then
    echo $appid
    kill -9 $appid
fi




