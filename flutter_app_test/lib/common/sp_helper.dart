import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_app_test/common/common.dart';
import 'package:flutter_app_test/models/LanguageModel.dart';

class SpHelper {
  // T 用于区分存储类型
  static void putObject(String key, Object value) {
    SpUtil.putString(key, value == null ? "" : json.encode(value));
  }

  static LanguageModel getLanguageModel() {
    String _saveLanguage = SpUtil.getString(Constant.key_language);
    if (ObjectUtil.isNotEmpty(_saveLanguage)) {
      Map userMap = json.decode(_saveLanguage);
      return LanguageModel.fromJson(userMap);
    }
    return null;
  }


}
