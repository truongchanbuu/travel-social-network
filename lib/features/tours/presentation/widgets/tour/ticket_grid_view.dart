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

  static const double spacing = 10;
  static const int maxRows = 2;
  static const double maxCrossAxisExtent = 600;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double itemHeight = _determineItemHeight(constraints.maxWidth);
        double crossAxisExtent = constraints.maxWidth;

        int columns = (crossAxisExtent / maxCrossAxisExtent).ceil();
        int rows = min(maxRows, (tickets.length / columns).ceil());

        return SizedBox(
          height: itemHeight * rows + spacing * (rows - 1),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: spacing,
              maxCrossAxisExtent: maxCrossAxisExtent,
              mainAxisExtent: itemHeight,
            ),
            itemBuilder: (context, index) =>
                RepaintBoundary(child: TicketItem(ticketId: tickets[index])),
            itemCount: scrollable ? tickets.length : columns * rows,
            physics: !scrollable ? const NeverScrollableScrollPhysics() : null,
          ),
        );
      },
    );
  }

  double _determineItemHeight(double crossAxisWidth) =>
      switch (crossAxisWidth) {
        < 290 && > 190 => 200,
        <= 190 => 250,
        _ => 180,
      };
}
