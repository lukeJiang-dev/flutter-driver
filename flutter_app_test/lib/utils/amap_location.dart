import 'package:amap_base/amap_base.dart';
import 'package:common_utils/common_utils.dart';

final _amapLocation = AMapLocation();
var _result = '';

//初始化定位监听
void initLocation() async {
  _amapLocation.init();
  final options = LocationClientOptions(
    isOnceLocation: false,
    locatingWithReGeocode: true,
    interval: 1000*10,
    httpTimeOut:1000*10
  );

  if (await Permissions().requestPermission()) {
    _amapLocation.startLocate(options).listen((location) {
      _result = '${location.toJson()}';
      LogUtil.e(_result);
    });
  } else {
    _result = "无定位权限";
    LogUtil.e(_result);
  }
}
