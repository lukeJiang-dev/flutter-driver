import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/common/common.dart';
import 'package:flutter_app_test/event/event.dart';
import 'package:flutter_app_test/ui/views/main_view.dart';

class CircleWaveView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomViewPageState2();
}
CircleWaveDrawer _circleWaveDrawer;
class CustomViewPageState2 extends State<CircleWaveView>
    with SingleTickerProviderStateMixin {
  GlobalKey _anchorKey = GlobalKey();
  GlobalKey _expandedKey = GlobalKey();
  //AnimationController _animation;
  TimerUtil _timerUtil;
  var _localOffset;
  double _width  = 50;
  double _height = 30;
  double _expanded_width = 120;
  @override
  void initState() {
    super.initState();
    init();
    runnable();
    /*_timerUtil = new TimerUtil(mTotalTime: 1*1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      if (_tick == 0) {
        addCircleWave();
        runnable();
        LogUtil.e('_animation.repeat()');
      }
    });
    _timerUtil.startCountDown();*/
  }

  void addCircleWave() {
    if(_localOffset==null
        &&_anchorKey.currentContext!=null
        &&_expandedKey.currentContext!=null) {
      LogUtil.e("addCircleWave---------->");
      RenderBox renderBox = _anchorKey.currentContext.findRenderObject();
      var offset = renderBox.localToGlobal(Offset.zero);
      RenderBox getBox = context.findRenderObject();
      _localOffset = getBox.globalToLocal(offset);
      _width = _anchorKey.currentContext.size.width;
      _height = _anchorKey.currentContext.size.height;
      _expanded_width = _expandedKey.currentContext.size.width;

      if(_circleWaveDrawer==null)
        _circleWaveDrawer = CircleWaveDrawer(_localOffset.dx+_width/2, _localOffset.dy+_height/2);
    }

  }

  @override
  Widget build(BuildContext context) {
    //double drawerW = ScreenUtil.getScreenW(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          key: _expandedKey,
            child: Stack(
              overflow: Overflow.clip,
              children: <Widget>[
              CustomPaint(
                child: Center(
                    child: Text(
                            '听单中',
                              key: _anchorKey,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17
                              ),
                            )
                ),
                painter: CircleWavePainter(),
              ),
          ],
        )),
        InkWell(
            onTap: () {
              isListenOrder = !isListenOrder;
              Event.sendAppEvent(context, new ComEvent(id: EventIds.home));
            },
            child: Container(
              width: 66,
              //padding: EdgeInsets.only(left: 20,right: 20),
              child: Center(
                  child: Text(
                '取消',
                style: TextStyle(color: Colors.white, fontSize: 15),
              )),
            )),
      ],
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    // onAnimationStart();
  }

  @override
  void dispose() {
    super.dispose();
    //_animation.dispose();
    if (_timerUtil != null) _timerUtil.cancel();
    stop();
  }
  stop(){
    if(timer!=null) {
      timer.cancel();
      timer = null;
    }
    isDraw = false;
  }
  Timer timer;
  runnable()async{
    if(timer==null){
      timer= Timer.periodic(
          Duration(milliseconds: 50), (as) {
              floatRadius = 2.0 + floatRadius;
              if (floatRadius > maxRadius) {
                floatRadius = (maxRadius % waveInterval);
              }
              if(mounted){
                addCircleWave();
                setState(() {});
              }
              LogUtil.e('runnable()');
          }
      );
    };
  }

  init(){
    maxRadius = _expanded_width ;// 2.0;
    floatRadius = (maxRadius % waveInterval);
    isDraw = true;
  }

}
double floatRadius; // 变化的半径
double maxRadius = 60; // 圆半径
double waveInterval = 50; // 圆环的宽度
bool isDraw = false;
class CircleWavePainter extends CustomPainter {
  Paint _paint = new Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = waveInterval
    ..isAntiAlias = true;
  Paint mLinePaint = new Paint()
  ..style = PaintingStyle.stroke
  ..strokeWidth = waveInterval
  ..isAntiAlias = true;
  @override
  void paint(Canvas canvas, Size size) {
      if(_circleWaveDrawer!=null)
        _circleWaveDrawer.drawCircleWave(canvas, _paint,mLinePaint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CircleWaveDrawer {
  double posX;
  double posY;
  CircleWaveDrawer(this.posX, this.posY);

  drawCircleWave(Canvas canvas, Paint paint,Paint mLinePaint) {
      if (maxRadius <= 0.0) {
        return;
      }
      LogUtil.e('drawRainDrop()');
      double radius = floatRadius % waveInterval;
      Offset offset = Offset(posX, posY);
      while (isDraw) {
        double _alpha = 255.0 * (1.0 - (radius / maxRadius));
        int alpha = _alpha.toInt();
        if (alpha <= 0) {
          break;
        }
        LogUtil.e('drawRainDrop()---while');
        paint.color = Color.fromARGB(alpha >> 2,255, 0, 0);
        canvas.drawCircle(offset, radius - waveInterval / 2, paint);

        mLinePaint.color = Color.fromARGB(alpha,255, 0, 0);
        canvas.drawCircle(offset, radius, mLinePaint);
        radius += waveInterval;
    }
  }

}
