import 'package:amap_base/amap_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/common/component_index.dart';
import 'package:flutter_app_test/res/strings.dart';
import 'package:flutter_app_test/res/styles.dart';
import 'package:flutter_app_test/utils/Toast.dart';
import 'package:flutter_app_test/utils/utils.dart';

class OrderTravelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OrderTravelState();
  }
}

class OrderTravelState extends State<OrderTravelPage> {
  String title = '去接乘客';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color(AppTheme.ScaffoldColor),
        appBar: new AppBar(
          /*leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
          color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),*/
          title: new Text(
            title, //?? IntlUtil.getString(context, titleId),
            style: TextStyles.appTitle,
          ),
          centerTitle: true,
          actions: <Widget>[
            InkWell(
              child: Container(
                child: Text('行程详情'),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(15),
              ),
              onTap: () {
                Toast.toast(context, '行程详情');
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            _titleWidget(),
            Expanded(child: _getMapWidget()),
            _getBottomPage()
          ],
        ));
  }

  Widget _titleWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[_getAddressWidget(), _getResidueWidget()],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 105,
          height: 105,
          color: Colors.red,
          child: Image.asset(
            Utils.getImgPath(Ids.icon_trip_icon_nav),
            width: 29,
            height: 50,
          ),
        )
      ],
    );
  }

  Widget _getAddressWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      child: RichText(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            text: '去',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '南山科技园南山科技园',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              )
            ]),
      ),
    );
  }

  Widget _getResidueWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: RichText(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            text: '剩余 ',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '15.6',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: '公里 ',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ),
              ),
              TextSpan(
                text: '25',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: '分钟',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ),
              ),
            ]),
      ),
    );
  }

  AMapOptions aMapOptions = AMapOptions(
      mapType:MAP_TYPE_NAVI,
  );

  Widget _getMapWidget() {
    return Stack(
      children: <Widget>[
        AMapView(amapOptions:aMapOptions)
      ],
    );
  }

  Widget _getBottomPage(){
    return Container(
      alignment: Alignment.center,
      height: 58,
      width: double.infinity,
      color: Colors.red,
      child: Text('去接乘客',
        style: TextStyle(
          color: Colors.white,fontSize: 18
        ),
      ),
    );
  }

}
