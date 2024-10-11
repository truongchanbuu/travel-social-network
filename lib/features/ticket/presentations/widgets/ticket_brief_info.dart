import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/enums/ticket_category.dart';
import '../../../../generated/l10n.dart';

class TicketBriefInfo extends StatelessWidget {
  final String ticketName;
  final TicketCategory category;
  final double? titleFontSize;
  final double? subtitleFontSize;
  final Widget? leading;
  final Widget? trailing;
  final bool isPaddingTitle;

  const TicketBriefInfo({
    super.key,
    required this.ticketName,
    required this.category,
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
          '$ticketName - ${S.current.forType(category.name).toUpperCase()}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: titleFontSize ?? 18,
          ),
          textDirection: defaultTextDirection,
          overflow: defaultTextOverflow,
          maxLines: 2,
        ),
      );
}
