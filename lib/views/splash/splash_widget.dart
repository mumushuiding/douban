// 启动小部件
import 'dart:async';
import '../../util/screen_utils.dart';
import '../../constant/constant.dart';
import 'package:flutter/material.dart';
import '../container_page.dart';
class SplashWidget extends StatefulWidget{

  @override
  _SplashWidgetState createState() => _SplashWidgetState();

}

class _SplashWidgetState extends State<SplashWidget>{
  var container = ContainerPage();
  bool showAd = true;
  @override
  Widget build(BuildContext context) {
    print('build splash');
    return Stack(
      children: <Widget>[
        // 当showAd为真时显示
        Offstage(
          child: container,
          offstage: showAd
        ),
        Offstage(
          child: Container(
            color: Colors.white,
            width: ScreenUtils.screenW(context),
            height: ScreenUtils.screenH(context),
            child: Stack(
              children:<Widget>[
                Align(
                  alignment: Alignment(0.0,0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: ScreenUtils.screenW(context) / 3,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(Constant.ASSETS_IMG + 'home.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          '落花有意随流水,流水无心恋落花',
                          style: TextStyle(fontSize: 15.0, color:Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(
                        alignment: Alignment(1.0,0.0),
                        child: Container(
                          margin: const EdgeInsets.only(right: 30.0, top: 20.0),
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                          decoration: BoxDecoration(
                            color: Color(0xffEDEDED),
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: CountDownWidget(onCountDownFinishCallBack: (bool value){
                            if (value) {
                              setState(() {
                                showAd  = false;
                              });
                            }
                          },),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              Constant.ASSETS_IMG + 'ic_launcher.png',
                                width: 50.0,
                                height: 50.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                  'Hi,豆芽',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                  ),
                ),
              ]
            ),
          ),
          offstage:!showAd,
        )
      ],
    );
  }
  
}
class CountDownWidget extends StatefulWidget{
  final onCountDownFinishCallBack;
  CountDownWidget({Key key,@required this.onCountDownFinishCallBack}):super(key:key);

  @override
  _CountDownWidget createState() {
    
    return _CountDownWidget();
  }
  
}
class _CountDownWidget extends State<CountDownWidget> {
  var _seconds = 3;
  Timer _timer;

  @override
  void initState(){
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_seconds',
      style:TextStyle(fontSize: 17.0),
    );
  }
  
  void _startTimer(){
    _timer = Timer.periodic(Duration(seconds:1), (timer){
      setState(() {});
      if (_seconds <= 1) {
        widget.onCountDownFinishCallBack(true);
        _cancelTimer();
        return;
      }
      _seconds--;
    });
  }
  void _cancelTimer(){
    _timer?.cancel();
  }
}