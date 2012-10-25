#import "../include/function_01_login.js"

var caseGoal = "测试登出帐号";
//UIALogger.logStart("测试目标："+caseGoal);

var target = UIATarget.localTarget();
var result = 0;
var uname = "ziputao1167";
var pwd = "ais1165";
if(loginNeedNotLogout(uname, pwd)!=1)
{
	result = 0;
}
else
{
	result = logout();
}

if (result == 1) {
	UIALogger.logPass("测试结果: Pass");
} else {
	UIALogger.logFail("测试结果: Fail [" + result +"]");
}
