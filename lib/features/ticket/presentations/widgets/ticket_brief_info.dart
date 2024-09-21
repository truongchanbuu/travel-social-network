import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';

class TicketBriefInfo extends StatelessWidget {
  final String ticketName;
  final String ticketCategory;
  final String ticketDescription;
  final double? titleFontSize;
  final double? subtitleFontSize;
  final Widget? leading;
  final Widget? trailing;

  const TicketBriefInfo({
    super.key,
    required this.ticketName,
    required this.ticketCategory,
    required this.ticketDescription,
    this.leading,
    this.trailing,
    this.titleFontSize,
    this.subtitleFontSize,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        leading: leading,
        trailing: trailing,
        title: Text(
          '$ticketName - For $ticketCategory',
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
