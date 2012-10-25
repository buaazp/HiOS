# HiOS框架是基于Apple提供的instruments工具而开发的iOS自动化测试和持续集成工具
# 程序作者@招牌疯子，欢迎新浪微博互粉
# 本套框架完全开源，遵从GPL协议
# 如有问题和建议请联系zp@buaa.us
# 2012.10.17
device=$1
shift
case $1 in
    all)
        # for i in `ls ./cases`
        # do
        #     sh start_suit.sh $device $i
        # done
        modules=`ls ./cases | grep -v monkey`
        echo sh start_suit.sh $device $modules
        sh start_suit.sh $device $modules
        exit
        ;;
    case)
        # case部分主要用于调试，与hudson持续集成的意义不大，故而没有做报表功能，如果需要请参考start_suit.sh中的代码实现。@_@
        module=$2
        shift 2
        argv=$*
        sh start_case.sh $device $module $argv
        exit
        ;;
    suit)
        sh start_suit.sh $device $2
        exit
        ;;
    monkey)
        sh bkground.sh $2 &
        sh start_suit.sh $device $1
esac 
