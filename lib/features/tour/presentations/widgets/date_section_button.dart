import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/utils/extensions/context_extension.dart';

import '../../../../config/themes/app_theme.dart';

class DateSectionButton extends StatefulWidget {
  final VoidCallback? onTap;
  final String title;
  final IconData icon;
  final Color textColor;

  const DateSectionButton({
    super.key,
    required this.title,
    required this.icon,
    this.textColor = AppTheme.primaryColor,
    this.onTap,
  });

  @override
  State<DateSectionButton> createState() => _DateSectionButtonState();
}

class _DateSectionButtonState extends State<DateSectionButton> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) => setState(() => _isHover = value),
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(999)),
          color: _isHover
              ? context.isDarkMode
                  ? AppTheme.secondaryColorDark
                  : widget.textColor
              : context.isDarkMode
                  ? AppTheme.primaryColorDark
                  : AppTheme.secondaryColor,
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 5,
              color: Colors.grey.withOpacity(0.4),
            )
          ],
        ),
        padding:
            const EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 18),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color: !_isHover
                  ? context.isDarkMode
                      ? DefaultTextStyle.of(context).style.color
                      : widget.textColor
                  : context.isDarkMode
                      ? widget.textColor
                      : AppTheme.secondaryColor,
              size: 20,
            ),
            const SizedBox(width: 5),
            Text(
              widget.title,
              style: TextStyle(
                color: !_isHover
                    ? context.isDarkMode
                        ? DefaultTextStyle.of(context).style.color
                        : widget.textColor
                    : context.isDarkMode
                        ? widget.textColor
                        : AppTheme.secondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
