import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/common/common.dart';
import 'package:flutter_app_test/event/event.dart';
import 'package:flutter_app_test/ui/views/main_view.dart';

class RainDropView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomViewPageState();
}

List<RainDropDrawer> _rainList = List();

class CustomViewPageState extends State<RainDropView>
    with SingleTickerProviderStateMixin {
  GlobalKey anchorKey = GlobalKey();
  AnimationController _animation;
  TimerUtil _timerUtil;
  var localOffset;
  double _width  = 50;
  double _height = 30;
  @override
  void initState() {
    super.initState();
    _animation = new AnimationController(
        // 因为是repeat的，这里的duration其实不care
        duration: const Duration(milliseconds: 300),
        vsync: this)
      ..addListener(() {
        if (_rainList.isEmpty) {
          addRainDrop();
          _animation.repeat();
        }
        if (mounted) setState(() {
        });
      });

    _timerUtil = new TimerUtil(mTotalTime: 1*1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      LogUtil.e('_animation.repeat()');
      if (_tick == 0) {
        addRainDrop();
        _animation.repeat();
      }
    });
    _timerUtil.startCountDown();
  }

  void addRainDrop() {
    if(localOffset==null) {
      RenderBox renderBox = anchorKey.currentContext.findRenderObject();
      var offset = renderBox.localToGlobal(Offset.zero);
      RenderBox getBox = context.findRenderObject();
      localOffset = getBox.globalToLocal(offset);
      _width = anchorKey.currentContext.size.width;
      _height = anchorKey.currentContext.size.height;
    }
    var rainDrop = RainDropDrawer(localOffset.dx+_width/2, localOffset.dy+_height/2);
    _rainList.add(rainDrop);
  }


  @override
  Widget build(BuildContext context) {
    //double drawerW = ScreenUtil.getScreenW(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: Stack(
          children: <Widget>[
              CustomPaint(
                  //isComplex:true,
                  //willChange:true,
                child: Center(
                    child: GestureDetector(
                        onTapUp: (TapUpDetails tapUp) {
                          //RenderBox getBox = context.findRenderObject();
                          //localOffset = getBox.globalToLocal(tapUp.globalPosition);
                          //addRainDrop();
                          //_animation.repeat();
                        },
                        child: Text(
                          '听单中',
                          key: anchorKey,
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ))),
                painter: RainDrop(),
                //foregroundPainter:RainDrop()
              ),

            //CircleProgressBarPainter(_doubleAnimation.value, drawerW)),
            /*Center(
                    child: Text(
                  (_doubleAnimation.value / 3.6).round().toString(),//改变状态
                  style: TextStyle(fontSize: 1, color: Colors.transparent),
                ))*/
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
    _animation.dispose();
    if (_timerUtil != null) _timerUtil.cancel();
  }
}
class RainDrop extends CustomPainter {
  Paint _paint = new Paint()
    ..style = PaintingStyle.fill
    ..strokeWidth = 60.0
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    _rainList.forEach((item) {
      item.drawRainDrop(canvas, _paint);
    });
    _rainList.removeWhere((item) {
      return !item.isValid();
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class RainDropDrawer {
  static const double MAX_RADIUS = 120;
  double posX;
  double posY;
  double radius = 10;

  RainDropDrawer(this.posX, this.posY);

  drawRainDrop(Canvas canvas, Paint paint) {
    double opt = (MAX_RADIUS - radius) / MAX_RADIUS;
    for (int i = 0; i < 10; i++) {
      paint.color = Color.fromRGBO(255 - i * 15, 0, 0, opt);
      double r = radius - i * 5;
      if (r < 0) {
        r = 2;
      }
      //canvas.drawCircle(Offset(posX, posY), r, paint);
      Rect rect = Rect.fromCircle(center:Offset(posX, posY),radius: r);
      //Rect rect = Rect.fromPoints(Offset(posX-r*1.5, posY-r/2),Offset(posX+r*1.5, posY+r/2));
      canvas.drawOval(rect, paint);
    }
    radius += 2;
  }

  bool isValid() {
    return radius < MAX_RADIUS;
  }
}
