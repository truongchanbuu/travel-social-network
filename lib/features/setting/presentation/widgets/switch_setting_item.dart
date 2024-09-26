import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';

class SwitchSettingItem extends StatefulWidget {
  final String title;
  const SwitchSettingItem({super.key, required this.title});

  @override
  State<SwitchSettingItem> createState() => _SwitchSettingItemState();
}

class _SwitchSettingItemState extends State<SwitchSettingItem> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      activeColor: primaryColor,
      value: _isDarkMode,
      title: Text(widget.title),
      onChanged: (value) => setState(() => _isDarkMode = value),
    );
  }
}
