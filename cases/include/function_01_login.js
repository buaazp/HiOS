/*
	百度云iOS版测试用例函数库
	function01：登录模块函数
	招牌疯子 @ Baidu
	zp@buaa.us
	2012.10.9
*/

/*
	Notes:
		target.frontMostApp().mainWindow().logElementTree(); 获取被测界面的所有元素
		target.delay(1); 等待1s
		target.tap({x:165, y:200}); 直接点击屏幕上的点(x, y)
*/

function loginByNameAndPassword(username, password)
{
	var result = 1;
	if(goToLoginLabel()!=1)
	{
		result = 0;
		return result;
	}
	result = loginJustLogin(username, password);
	return result;
}

function goToLoginLabel()
{
	var result = 1;
	if(checkIfLoginLabel()!=1)
	{
		if(logout()!=1){
			result = 0;
		}
	}
	return result;
}

function loginNeedNotLogout(username, password)
{
	var result = 0;

	if( checkIfLoginLabel() )
	{
		result = loginJustLogin(username, password);
	}
	else
	{
		result = 1;
	}
	
	return result;
}

function logout()
{
	var result = 1;
        if(checkIfLoginedLabel() == 1)
        {
            UIALogger.logMessage("已登录，开始注销。");

            //然后注销
            target.frontMostApp().tabBar().buttons()[3].tap();
            target.frontMostApp().mainWindow().tableViews()[0].dragInsideWithOptions({startOffset:{x:0.62, y:0.86}, endOffset:{x:0.50, y:0.07}});
            //target.dragFromToForDuration({x:229.00, y:389.00}, {x:242.00, y:21.00}, 0.4);
            target.delay(1);
            target.frontMostApp().mainWindow().tableViews()[0].buttons()[0].tap();
            target.frontMostApp().actionSheet().buttons()[0].tap();

            target.delay(1);
            if(checkIfLoginLabel() != 1)
            {
                result = 0;
            }
        }
        else
        {
            UIALogger.logMessage("未登录，无法注销...");
            result = 0;
        }
	return result;
}

function checkIfLoginLabel()
{
	var result = 1;
        var loginTab = "";
	UIALogger.logMessage("检测是否为登录面板...");
        
        var naviBar = target.frontMostApp().navigationBar();
        var topBarName = naviBar.name();

        if(topBarName == "登录百度云")
        {
            loginTab = "登录面板";
        }
        else
        {
            result = 0;
            loginTab = "非登录面板";
        }
        UIALogger.logMessage("当前面板: " + loginTab);
	return result;
}

function checkIfLoginedLabel()
{
	var result = 0;
	var window = target.frontMostApp().mainWindow()
	var name = window.tabBar().buttons()[0].name();
	if (name)
	{
		result = 1;
	}
	return result;
}

function checkIfFileLabel()
{
	var result = 0;
	var window = target.frontMostApp().mainWindow()
	var value = window.tabBar().buttons()[0].value();
	if (value)
	{
		result = 1;
	}
	return result;
}

function checkIfUploadLabel()
{
	var result = 0;
	var window = target.frontMostApp().mainWindow()
	var value = window.tabBar().buttons()[1].value();
	if (value)
	{
		result = 1;
	}
	return result;
}

function checkIfDownloadLabel()
{
	var result = 0;
	var window = target.frontMostApp().mainWindow()
	var value = window.tabBar().buttons()[2].value();
	if (value)
	{
		result = 1;
	}
	return result;
}

function checkIfSettingLabel()
{
	var result = 0;
	var window = target.frontMostApp().mainWindow()
	var value = window.tabBar().buttons()[3].value();
	if (value)
	{
		result = 1;
	}
	return result;
}

function loginJustLogin(username, password)
{
	var result = 1;

        //先登录
	UIALogger.logMessage("开始输入帐号。");
        target.frontMostApp().mainWindow().scrollViews()[0].textFields()[1].tap();
        //输入用户名
        target.frontMostApp().keyboard().typeString(username);
        //输入密码
	UIALogger.logMessage("开始输入密码。");
        target.frontMostApp().mainWindow().scrollViews()[0].secureTextFields()[0].tap();
        target.frontMostApp().keyboard().typeString(password);
        //点击登录按钮
        target.frontMostApp().mainWindow().scrollViews()[0].buttons()["登录"].tap();

	if(checkIfLoginedLabel()!=1)
	{
		result = 0; 
	}
/* 处理验证码相关代码，需要修改
	if ( result == 0 ){
		var errorStr = target.frontMostApp().mainWindow().staticTexts()["需要验证码"].value();
		if ( errorStr == "需要验证码" ){
			UIALogger.logMessage("登陆失败，错误为：" + errorStr);
			result = 0;
			return errorStr;
		}else{
			errorStr = target.frontMostApp().mainWindow().staticTexts()["帐号或者密码错误"].value();
			if ( errorStr == "帐号或者密码错误" ){
				UIALogger.logMessage("登陆失败，错误为：" + errorStr);
				result = 0;
				return errorStr;
			}
		}
	}
        */
	return result;
}

function goToTabById(tabId)
{
	result = 0;
	id = tabId - 1;
	target.frontMostApp().tabBar().buttons()[id].tap();
	if (target.frontMostApp().tabBar().buttons()[id].value())
	{
		result = 1;
	}
	return result;
}

function goToFileLabel()
{
	result = 0;
	UIALogger.logMessage("切换到文件面板");
	target.frontMostApp().tabBar().buttons()[0].tap();
	result = checkIfFileLabel();
	return result;
}

function goToUploadLabel()
{
	result = 0;
	UIALogger.logMessage("切换到上传面板");
	target.frontMostApp().tabBar().buttons()[1].tap();
	result = checkIfUploadLabel();
	return result;
}

function goToDownloadLabel()
{
	result = 0;
	UIALogger.logMessage("切换到收藏面板");
	target.frontMostApp().tabBar().buttons()[2].tap();
	result = checkIfDownloadLabel();
	return result;
}

function goToSettingLabel()
{
	result = 0;
	UIALogger.logMessage("切换到更多面板");
	target.frontMostApp().tabBar().buttons()[3].tap();
	result = checkIfSettingLabel();
	return result;
}










