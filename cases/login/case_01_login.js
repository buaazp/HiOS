#import "../include/function_01_login.js"
var caseGoal = "测试一次完整的登录流程";
//UIALogger.logStart("测试目标："+caseGoal);



var target = UIATarget.localTarget();
var uname = "xxxxx";
var pwd = "xxxx";
var result = loginByNameAndPassword(uname, pwd);

if (result == 1) {
    UIALogger.logPass("测试结果: Pass");
} else {
    UIALogger.logFail("测试结果: Fail [" + result +"]");
}
