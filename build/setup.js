
var target = UIATarget.localTarget();
target.delay(1);
target.frontMostApp().mainWindow().logElementTree();
target.frontMostApp().tabBar().buttons()[4].tap();
target.delay(1);
target.frontMostApp().mainWindow().logElementTree();
target.frontMostApp().mainWindow().tableViews()[0].cells()[0].tap();
target.delay(1);
target.frontMostApp().mainWindow().logElementTree();
target.frontMostApp().mainWindow().buttons()[1].tap();
target.delay(1);
target.frontMostApp().mainWindow().logElementTree();
target.frontMostApp().mainWindow().tableViews()[0].cells()[0].buttons()[0].tap();
