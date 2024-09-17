import 'dart:math';

import 'package:flutter/material.dart';
import 'package:travel_social_network/features/tours/presentation/widgets/tour/ticket_item.dart';

class TicketGridView extends StatelessWidget {
  final List<String> tickets;
  final bool scrollable;
  const TicketGridView({
    super.key,
    required this.tickets,
    this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    const double spacing = 10;
    const int maxRows = 4;

    return LayoutBuilder(
      builder: (context, constraints) {
        const double maxCrossAxisExtent = 600;
        double crossAxisExtent = constraints.maxWidth;
        double mainAxisExtent = 150;
        if (crossAxisExtent < 290 && crossAxisExtent > 190) {
          mainAxisExtent = 200;
        } else if (crossAxisExtent <= 190) {
          mainAxisExtent = 250;
        }

        int columns = (crossAxisExtent / maxCrossAxisExtent).ceil();
        int rows = min(maxRows, (tickets.length / columns).ceil());

        return SizedBox(
          height: mainAxisExtent * rows + spacing * (rows - 1),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: spacing,
              maxCrossAxisExtent: maxCrossAxisExtent,
              mainAxisExtent: mainAxisExtent,
            ),
            itemBuilder: (context, index) => TicketItem(ticket: tickets[index]),
            itemCount: tickets.length,
            physics: !scrollable ? const NeverScrollableScrollPhysics() : null,
          ),
        );
      },
    );
  }
}
