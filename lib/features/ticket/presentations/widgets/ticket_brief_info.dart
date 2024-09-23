import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';

class TicketBriefInfo extends StatelessWidget {
  final String ticketName;
  final String? ticketCategory;
  final String ticketDescription;
  final double? titleFontSize;
  final double? subtitleFontSize;
  final Widget? leading;
  final Widget? trailing;
  final bool isPaddingTitle;

  const TicketBriefInfo({
    super.key,
    required this.ticketName,
    this.ticketCategory,
    required this.ticketDescription,
    this.leading,
    this.trailing,
    this.titleFontSize,
    this.subtitleFontSize,
    this.isPaddingTitle = true,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        leading: leading,
        contentPadding: isPaddingTitle ? null : EdgeInsets.zero,
        trailing: trailing,
        title: Text(
          ticketCategory?.isEmpty ?? true
              ? ticketName
              : '$ticketName - For $ticketCategory',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: titleFontSize ?? 18,
          ),
          textDirection: defaultTextDirection,
          overflow: defaultTextOverflow,
          maxLines: 2,
        ),
        subtitle: ticketDescription.isNotEmpty
            ? Text(
                ticketDescription,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: subtitleFontSize ?? 16,
                ),
                textDirection: defaultTextDirection,
                overflow: defaultTextOverflow,
                maxLines: 2,
              )
            : null,
      );
}
