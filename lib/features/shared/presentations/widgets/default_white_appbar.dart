import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';

AppBar defaultWhiteAppBar({
  required BuildContext context,
  VoidCallback? onBack,
  List<Widget>? actions,
  String? titleText,
  Widget? title,
  bool centerTitle = false,
}) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.black
          : Colors.white,
    ),
    backgroundColor: Theme.of(context).colorScheme.background,
    titleSpacing: 0,
    leading: BackButton(onPressed: onBack),
    actions: actions,
    title: (titleText != null)
        ? Text(
            titleText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            textDirection: defaultTextDirection,
            overflow: defaultTextOverflow,
          )
        : title,
    centerTitle: centerTitle,
  );
}
