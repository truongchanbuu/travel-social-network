import 'package:flutter/material.dart';

import '../../../../config/themes/app_theme.dart';

class SwitchSettingItem extends StatefulWidget {
  final String title;
  final bool value;
  final void Function(bool value)? onChanged;

  const SwitchSettingItem({
    super.key,
    required this.title,
    this.value = false,
    this.onChanged,
  });

  @override
  State<SwitchSettingItem> createState() => _SwitchSettingItemState();
}

class _SwitchSettingItemState extends State<SwitchSettingItem> {
  bool _current = false;

  @override
  void initState() {
    super.initState();
    _current = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      activeColor: AppTheme.primaryColor,
      value: _current,
      title: Text(widget.title),
      onChanged: (value) {
        setState(() {
          _current = value;
          widget.onChanged?.call(_current);
        });
      },
    );
  }
}
