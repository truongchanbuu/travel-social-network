import 'package:flutter/material.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/extensions/context_extension.dart';

class DateTimeItem extends StatefulWidget {
  final String date;
  final bool isSelected;
  final void Function()? onTap;

  const DateTimeItem({
    super.key,
    required this.date,
    this.isSelected = false,
    this.onTap,
  });

  @override
  State<DateTimeItem> createState() => _DateTimeItemState();
}

class _DateTimeItemState extends State<DateTimeItem> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.isSelected;
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(999)),
      onHover: (value) => setState(() => _isHover = value),
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(999)),
          color: _isHover || isSelected
              ? AppTheme.primaryColor
              : context.isDarkMode
                  ? AppTheme.secondaryColorDark
                  : AppTheme.secondaryColor,
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 5,
              color: Colors.grey.withOpacity(0.5),
            )
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Text(
          widget.date,
          style: TextStyle(
            color: _isHover || isSelected
                ? AppTheme.secondaryColor
                : context.isDarkMode
                    ? AppTheme.secondaryColor
                    : AppTheme.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            overflow: defaultTextOverflow,
          ),
          maxLines: 2,
          overflow: defaultTextOverflow,
        ),
      ),
    );
  }
}
