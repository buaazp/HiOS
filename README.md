## This framework is used for iOS UIAutomation autotest based on instruments.

HiOS
==========
A framework for iOS autotest.

## Requirements

* Mac OS X. Tested on Snow Leopard, Mountion Lion.
* Xcode 4.x versions.
* A hudson build system.

## Usage

* Checkout HiOS code. Copy to any directory.
* Copy your own JSs to ./HiOS/cases.
* Modify ./conf/conf.sh to adapt your app, simulator, iOS devices and Xcode information.
* `sh ./build/onekey.sh 1` build for your real device. Use 0 for building in simulator.
* `./hios 1 all` test all case in your real device. Use 0 for testing in simulator.
* `./hios 1 suit login` test login module.
* `./hios 1 monkey 8` run monkey test in real device for 8 hours.


## Functions

* Install app automatically.
* Run monkey test.
* Run functional test automatically.
* Generate Junit report xml for hudson.

## Contact Me

* @招牌疯子 in weibo.com
* Email: zp@buaa.us
