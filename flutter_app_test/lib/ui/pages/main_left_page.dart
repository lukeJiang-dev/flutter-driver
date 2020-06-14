import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/common/component_index.dart';
import 'package:flutter_app_test/models/ItemInfo.dart';
import 'package:flutter_app_test/res/strings.dart';
import 'package:flutter_app_test/res/styles.dart';
import 'package:flutter_app_test/ui/pages/settings_page.dart';
import 'package:flutter_app_test/ui/widgets/other/clock.dart';
import 'package:flutter_app_test/utils/navigator_util.dart';
import 'package:flutter_app_test/utils/utils.dart';

class MainLeftPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainLeftPageState();
  }
}

class _MainLeftPageState extends State<MainLeftPage> {
  List<ItemInfo> _itemList = new List();

  @override
  void initState() {
    super.initState();
    _itemList.add(new ItemInfo());
    _itemList.add(new ItemInfo(
        titleId: Ids.car_rental, iconRes: Ids.icon_side_icon_rent));
    _itemList
        .add(new ItemInfo(titleId: Ids.my_trips, iconRes: Ids.icon_my_trips));
    _itemList
        .add(new ItemInfo(titleId: Ids.my_wallet, iconRes: Ids.icon_my_wallet));
    _itemList.add(new ItemInfo(
        titleId: Ids.customer_service, iconRes: Ids.icon_customer_service));
    _itemList
        .add(new ItemInfo(titleId: Ids.settings, iconRes: Ids.icon_settings));
    //动画
    _itemList.add(new ItemInfo(
        titleId: Ids.animation_clock, iconRes: Ids.icon_customer_service));

  }

  Widget buildItem(ItemInfo info) {
    return new InkWell(
      onTap: () {
        switch (info.titleId) {
          case Ids.settings:
            NavigatorUtil.pushPageBody(
              context,
              titleId: Ids.settings,
              body: new SettingsPage(),
            );
            break;
          case Ids.animation_clock:
            NavigatorUtil.pushPageBody(
              context,
              titleId: Ids.animation_clock,
              body:  ClockPage(),
            );
            break;
          default:
            break;
        }
      },
      child: new Container(
          height: 50.0,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              new Container(
                padding: EdgeInsets.only(left: 30.0, right: 10.0),
                child: new Image.asset(
                  Utils.getImgPath(info.iconRes),
                  width: 18,
                  height: 18,
                ),
              ),
              new Text(
                IntlUtil.getString(context, info.titleId),
                style: new TextStyle(
                  fontSize: 15.0,
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double drawerW = ScreenUtil.getScreenW(context)*0.75;
    return new Material(
      elevation: 2,
      child: new Container(
        width: drawerW,
        padding: EdgeInsets.only(top: ScreenUtil.getInstance().statusBarHeight),
        child: Column(
          //alignment: const FractionalOffset(1, 0.95),
          children: <Widget>[
            Expanded(child: new ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: _itemList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return _getHeadView();
                  } else {
                    return buildItem(_itemList[index]);
                  }
                }
                ),
            ),

            Container(
              padding: EdgeInsets.all(10.0),
              child: new Image.asset(
              Utils.getImgPath(Ids.icon_ban_user),
              width:drawerW,
            ),),

            /*new Positioned(
              right: 15.0,
              left: 15.0,
              bottom: 15,
              child: new Image.asset(
                Utils.getImgPath(Ids.icon_ban_user),
                  width:drawerW,
              ),
            ),*/

          ],
        )
      ),
    );
  }

  Container _getHeadView() {
    return new Container(
      //height: 120.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Gaps.vGap10,
          _getHeadImage(),
          Gaps.vGap10,
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "猪猪代驾",
                style: new TextStyle(fontSize: 16.0, color: Colors.black87),
              )
            ],
          ),
          Gaps.vGap10,
          _getRow(5, 4),
          Gaps.vGap20,
        ],
      ),
    );
  }

  Row _getRow(int numStars, int rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _getStarList(numStars, rating),
    );
  }

  List<Widget> _getStarList(int numStars, int rating) {
    List<Widget> children = new List();
    for (int i = 0; i < numStars; i++) {
      if (i < rating) {
        children.add(new Icon(
          Icons.star,
          color: Colors.amber,
          size: 20,
        ));
      } else {
        children.add(new Icon(
          Icons.star_border,
          color: Colors.grey,
          size: 20,
        ));
      }
    }
    return children;
  }

  Container _getHeadImage() {
    return new Container(
      width: 86.0,
      height: 86.0,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(90),
        //shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(
            Utils.getImgPath(Ids.icon_user_header_def),
          ),
        ),
      ),
    );
  }
}
