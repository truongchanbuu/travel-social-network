import 'dart:math';

import 'package:flutter/material.dart';

import 'ticket_item.dart';

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
    const int maxRows = 2;
    const double maxCrossAxisExtent = 600;

    return LayoutBuilder(
      builder: (context, constraints) {
        double mainAxisExtent = _determineMainAxisExtent(constraints.maxWidth);
        double crossAxisExtent = constraints.maxWidth;

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
            itemBuilder: (context, index) =>
                RepaintBoundary(child: TicketItem(ticket: tickets[index])),
            itemCount: scrollable ? tickets.length : columns * rows,
            physics: !scrollable ? const NeverScrollableScrollPhysics() : null,
          ),
        );
      },
    );
  }

  double _determineMainAxisExtent(double crossAxisWidth) =>
      switch (crossAxisWidth) {
        < 290 && > 190 => 200,
        <= 190 => 250,
        _ => 150,
      };
}
