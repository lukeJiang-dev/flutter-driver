import 'package:flutter/material.dart';
import 'package:flutter_app_test/common/component_index.dart';
import 'package:flutter_app_test/res/styles.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    Key key,
    this.title,
    this.titleId,
    this.body,
  }) : super(key: key);

  final String title;
  final String titleId;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          title ?? IntlUtil.getString(context, titleId),
          style: TextStyles.appTitle,
        ),
        centerTitle: true,
      ),
      body: body,
    );
  }
}
