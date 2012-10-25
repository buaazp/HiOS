
var target = UIATarget.localTarget();

var g_Width = 310;
var g_Height = 450;

UIALogger.logMessage("开始随机屏幕事件测试");

autoTest();

function autoTest()
{
    while(1) {	
		/*if (UIATarget.localTarget().frontMostApp().alert() != UIAElementNil)
		{
			UIATarget.localTarget().frontMostApp().alert().cancelButton().tap();
			continue;
		}*/
        // 随机一个事件索引，根据该索引调用对应的事件测试
        var randIndex = Math.ceil(Math.random()*6);
        
        switch(randIndex)
        {
        case 0:
            // 测试单击
            testTap();
            break;
        case 1:
            // 测试双击
            testDoubleTap();
            break;
        case 2:
            // 测试两个手指同时单击
            testTwoFingerTap();
            break;
        case 3:
            testOneFingerMove();
            break;
        case 4:
            //PressDone();
            break;
        case 5:
            testZoomIn();
            break;
        case 6:
            testZoomOut();
            break;
        default:
            testTap(tapPt);
        }
        
        UIATarget.localTarget().delay(0.05);
    }
}

// 随机生成一个点
function randomPoint()
{
    var ret = new Object();
    ret.x = Math.ceil(Math.random()*g_Width);
    ret.y = Math.ceil(Math.random()*g_Height);
    return ret;
}

// 单击屏幕
function testTap()
{
    var pt = randomPoint();
    UIALogger.logMessage("Tap  x:"+pt.x+"  y:"+pt.y);
    UIATarget.localTarget().tap(pt);
}

// 双击屏幕
function testDoubleTap()
{
    var pt = randomPoint();
    UIALogger.logMessage("DoubleTap  x:"+pt.x+"  y:"+pt.y);
    UIATarget.localTarget().doubleTap(pt);
}

// 两个手指单击屏幕
function testTwoFingerTap()
{
    // 这是多点放大
    UIATarget.localTarget().twoFingerTap({x:100, y:200});
    //UIATarget.localTarget().pinchOpenFromToForDuration({x:100,y:100},{x:120,y:120}, 10);
    return;
}

// 单手指移动,duration是移动的时间
function testOneFingerMove()
{
    var ptStart = randomPoint();
    var ptEnd = randomPoint();
    var duration = 0.5+Math.random()*3; // 最多3.5秒
    UIALogger.logMessage("FingerMove  x:"+ptStart.x+"  y:"+ptStart.y+" -> x:"+ptEnd.x+"  y:"+ptEnd.y);
    UIATarget.localTarget().dragFromToForDuration(ptStart, ptEnd, duration);
}

function PressDone()
{
    UIALogger.logMessage("Press Done");
    UIATarget.localTarget().tap({x:310, y:450});
}

function testZoomIn()
{
    var ptStart = randomPoint();
    var ptEnd = randomPoint();
    var duration = 0.5+Math.random()*3; // 最多3.5秒
    UIALogger.logMessage("ZoomIn  x:"+ptStart.x+"  y:"+ptStart.y+" -> x:"+ptEnd.x+"  y:"+ptEnd.y);
    UIATarget.localTarget().pinchCloseFromToForDuration(ptStart,ptEnd, duration);
}

function testZoomOut()
{
    var ptStart = randomPoint();
    var ptEnd = randomPoint();
    var duration = 0.5+Math.random()*3; // 最多3.5秒
    UIALogger.logMessage("ZoomOut  x:"+ptStart.x+"  y:"+ptStart.y+" -> x:"+ptEnd.x+"  y:"+ptEnd.y);
    UIATarget.localTarget().pinchOpenFromToForDuration(ptStart,ptEnd, duration);
}


