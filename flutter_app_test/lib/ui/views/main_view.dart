import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_test/common/common.dart';
import 'package:flutter_app_test/event/event.dart';
import 'package:flutter_app_test/models/HomeInfo.dart';
import 'package:flutter_app_test/res/colors.dart';
import 'package:flutter_app_test/res/dimens.dart';
import 'package:flutter_app_test/res/strings.dart';
import 'package:flutter_app_test/res/styles.dart';
import 'package:flutter_app_test/ui/pages/order_travel_page.dart';
import 'package:flutter_app_test/utils/navigator_util.dart';
import 'package:flutter_app_test/utils/utils.dart';

import 'rain_drop_wiew.dart';
import 'circle_wave_view.dart';

Container getMainOrderInfoView(HomeInfo homeInfo) {
  return Container(
    padding: EdgeInsets.only(top: 25, bottom: 30),
    color: Color(AppTheme.ThemeColor),
    child: Row(
      children: <Widget>[
        Expanded(child: _getColumn('今日单数', homeInfo.orderNum)),
        Expanded(child: _getColumn('今日收入（元）', homeInfo.todayIncome)),
        Expanded(child: _getColumn('服务分', homeInfo.score)),
      ],
    ),
  );
}

Column _getColumn(String title, String value) {
  return Column(
    children: <Widget>[
      Text(
        title,
        style: TextStyle(color: Colors.white54, fontSize: 13),
      ),
      Gaps.vGap5,
      Text(
        value,
        style: TextStyle(color: Colors.white, fontSize: 36),
      )
    ],
  );
}

Container getInviteView() {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.all(10),
    child: Row(
      children: <Widget>[
        Expanded(child: _getInvite('邀请乘客', Ids.icon_home_yaoqing)),
        new Container(
          height: Dimens.gap_dp30,
          width: Dimens.border_width,
          margin: EdgeInsets.all(5),
          color: Colours.gray_ce,
        ),
        Expanded(child: _getInvite('活动中心', Ids.icon_home_huodong)),
      ],
    ),
  );
}

Widget _getInvite(String title, String imagePath) {
  String path = Utils.getImgPath(imagePath);
  return Stack(
    alignment: AlignmentDirectional.center,
    children: <Widget>[
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            path,
            width: 25,
            height: 25,
          ),
          Text(title, style: TextStyle(color: Colors.black87, fontSize: 17)),
        ],
      ),
    ],
  );
}

Widget getListView() {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10,bottom: 10),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(context, index);
        });
}

Widget _buildItem(BuildContext context, int index) {
  return Material(
    color: Colors.white,
    child: new InkWell(
      onTap: () {
        NavigatorUtil.pushMaterialPage(
          context,
          OrderTravelPage(),
        );
      },
      child: Column(
        children: <Widget>[
          new Container(
            height: Dimens.border_width1,
            width: double.infinity,
            color: Color(AppTheme.ScaffoldColor),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: _getOrderTitle(),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, top: 5),
            child: _getAddressView('凯达尔集团大厦A座', Colors.teal[300]),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, top: 15, bottom: 20),
            child: _getAddressView('深圳机场T3航站楼', Colors.red[400]),
          ),
        ],
      ),
    ),
  );
}

Widget _getOrderTitle() {
  return new Stack(
    //padding: EdgeInsets.all(15),
    children: <Widget>[
      new Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            Utils.getImgPath(Ids.icon_home_icon_label_real),
            width: 34,
            height: 16,
          ),
          new Container(
            height: Dimens.border_width1,
            width: 10,
          ),
          Text(
            "当前订单",
            style: TextStyle(
              color: Color(AppTheme.ThemeColor),
              fontSize: 15,
            ),
          ),
        ],
      ),
      Positioned(
        right: 0,
        top: 0,
        bottom: 0,
        //alignment: Alignment.bottomRight,
        //width: double.maxFinite,
        child: Text(
          "您有一个未完成订单",
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color(0xFF999999),
            fontSize: 15,
          ),
        ),
      ),
    ],
  );
}

Widget _getAddressView(String address_, Color color_) {
  return new Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Icon(
        Icons.fiber_manual_record,
        size: 15,
        color: color_,
      ),
      new Container(
        height: Dimens.border_width1,
        width: 5,
      ),
      Text(
        address_,
        style: TextStyle(
          color: Color(AppTheme.ThemeColor),
          fontSize: 17,
        ),
      ),
    ],
  );
}

Widget getMainBottomView(BuildContext context) {
  return Container(
    //padding: EdgeInsets.only(left: 20, right: 20),
    color: Color(AppTheme.ThemeColor),
    height: 66,
    //width: screenW,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 66,
          child: Image.asset(
            Utils.getImgPath(Ids.icon_home_set),
            width: 25,
            height: 25,
          ),
        ),
        Expanded(child: _getListenOrderView(context)),
      ],
    ),
  );
}
//底部按钮
bool isListenOrder = false;
Widget _getListenOrderView(BuildContext context) {
  if(isListenOrder){
    return Container(
      //color: Colors.blue,
      child: CircleWaveView(),
    );
  }else{
    return Align(
        alignment: Alignment.bottomCenter,
        child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            onTap: () {
              isListenOrder = !isListenOrder;
              Event.sendAppEvent(context, new ComEvent(id: EventIds.home));
            },
            child: Container(
              decoration: BoxDecoration(
                //border: Border.all(width: 1.0, color: Colors.black38),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.red,
              ),
              margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
              alignment: Alignment(0, 0),
              child: Text(
                '开始听单',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            )));
  }

}
