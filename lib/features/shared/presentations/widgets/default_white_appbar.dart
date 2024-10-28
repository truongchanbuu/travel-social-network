import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';

AppBar defaultWhiteAppBar({
  VoidCallback? onBack,
  List<Widget>? actions,
  String? titleText,
  Widget? title,
  bool centerTitle = false,
}) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    titleSpacing: 0,
    leading: BackButton(onPressed: onBack),
    actions: actions,
    title: (titleText != null)
        ? Text(
            titleText,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textDirection: defaultTextDirection,
            overflow: defaultTextOverflow,
          )
        : title,
    centerTitle: centerTitle,
  );
}
