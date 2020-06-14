import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_test/res/colors.dart';
import 'package:flutter_app_test/res/dimens.dart';

class TextStyles {
  static const TextStyle listTitle = TextStyle(
    fontSize: Dimens.font_sp16,
    color: Colours.text_dark,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle listContent = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.text_normal,
  );
  static const TextStyle listExtra = TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colours.text_gray,
  );

  static const TextStyle appTitle = TextStyle(
    fontSize: Dimens.font_sp18,
    color: Colors.white,
    fontWeight: FontWeight.bold
  );
}

class Decorations {
  static const Decoration bottom = BoxDecoration(
      border: Border(
          bottom:
              BorderSide(width: Dimens.border_width, color: Colours.divider)));
}

class Gaps {
  static Widget hGap3 = new SizedBox(width: Dimens.gap_dp3);
  static Widget hGap5 = new SizedBox(width: Dimens.gap_dp5);
  static Widget hGap10 = new SizedBox(width: Dimens.gap_dp10);
  static Widget hGap15 = new SizedBox(width: Dimens.gap_dp15);

  static Widget vGap5 = new SizedBox(height: Dimens.gap_dp5);
  static Widget vGap10 = new SizedBox(height: Dimens.gap_dp10);
  static Widget vGap15 = new SizedBox(height: Dimens.gap_dp15);
  static Widget vGap20 = new SizedBox(height: Dimens.gap_dp20);
  static Widget vGap30 = new SizedBox(height: Dimens.gap_dp30);
}

class AppTheme{
   static int ThemeColor = 0xFF282833;
   static int ScaffoldColor = 0xFFF7F7F7;
   static ThemeData getThemeData(){
    return ThemeData(
      primaryColor: Color(ThemeColor),
      backgroundColor: Color(0xFFEFEFEF),
      accentColor: Color(0xFF888888),
      textTheme: TextTheme(
        body1: TextStyle(color: Color(0xFF888888), fontSize: 16.0),
      ),
      iconTheme: IconThemeData(
        color: Color(ThemeColor),
        size: 35.0,
      ),
    );
  }
}