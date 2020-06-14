import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/common/component_index.dart';
import 'package:flutter_app_test/models/LanguageModel.dart';
import 'package:flutter_app_test/res/strings.dart';
import 'package:flutter_app_test/res/styles.dart';
import 'package:flutter_app_test/utils/Toast.dart';
import 'package:flutter_app_test/utils/utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'models/HomeInfo.dart';
import 'res/dimens.dart';
import 'ui/pages/main_left_page.dart';
import 'ui/views/main_view.dart';
import 'package:amap_base/amap_base.dart';

import 'utils/amap_location.dart';

void main() {
  AMap.init('a3deb2c77e284a16fb55028f29b0af43');
  runApp(BlocProvider<ApplicationBloc>(
    bloc: ApplicationBloc(),
    child: BlocProvider(child: MyApp(), bloc: MainBloc()),
  ));
  initLocation();
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  HomeInfo homeInfo =
      HomeInfo(orderNum: '15', todayIncome: '666.6', score: '96');

  @override
  void initState() {
    super.initState();
    setLocalizedValues(localizedValues);
    _initAsync();
    _initListener();
  }

  void _initAsync() async {
    await SpUtil.getInstance();
    if (!mounted) return;
    _loadLocale();
  }

  void _initListener() {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    bloc.appEventStream.listen((value) {
      switch (value.id) {
        case EventIds.home:
          _loadLocale();
          LogUtil.e("EventIds.home......");
          //Toast.toast(context, "home");
          break;
        default:
          break;
      }
    });
  }

  void _loadLocale() {
    setState(() {
      LanguageModel model = SpHelper.getLanguageModel();
      if (model != null) {
        _locale = new Locale(model.languageCode, model.countryCode);
      } else {
        _locale = null;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double drawerW = ScreenUtil.getScreenW(context);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(AppTheme.ScaffoldColor),
        appBar: _appBar(context),
        body: _getMainView(context),
        drawer: new MainLeftPage(),
      ),
      theme: AppTheme.getThemeData(),
      locale: _locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        CustomLocalizations.delegate
      ],
      supportedLocales: CustomLocalizations.supportedLocales,
    );
  }

  MyAppBar _appBar(BuildContext context) {
    return MyAppBar(
      leading: IconButton(
        icon: new Image.asset(
          Utils.getImgPath(Ids.icon_title_user),
          width: 25.0,
          height: 25.0,
        ),
        /*onPressed: (){
          Toast.toast(context, 'Toast');
        },*/
        //padding: EdgeInsets.only(left: 15),
      ),
      title: Text(
        "猪猪代驾",
        style: TextStyles.appTitle,
      ),
      centerTitle: true,
      elevation: 0,
      actions: <Widget>[
        new IconButton(
            icon: new Image.asset(
              Utils.getImgPath(Ids.icon_title_msg),
              width: 24.0,
              height: 24.0,
            ),
            onPressed: () {
              setState(() {
                int Num = new Random().nextInt(100);
                int income = new Random().nextInt(1000);
                int _score = new Random().nextInt(100);
                homeInfo = HomeInfo(
                    orderNum: Num.toString(),
                    todayIncome: income.toString(),
                    score: _score.toString());
              });
              Toast.toast(context, "暂无消息");
            }),
      ],
    );
  }

  Widget _getMainView(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      //const FractionalOffset(0, 1),
      children: <Widget>[
        getMainBottomView(context),
        Container(
          color: Color(AppTheme.ScaffoldColor),
          width: double.infinity,
          height: double.maxFinite,
          margin: EdgeInsets.only(bottom: 66),
          child: Column(
            children: <Widget>[
              getMainOrderInfoView(homeInfo),
              getInviteView(),
              Container(
                height: Dimens.border_width1,
                width: double.infinity,
              ),
              Expanded(
                child: getListView(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
