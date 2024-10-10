import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../domain/entities/ticket_type.dart';

class TicketGridView extends StatelessWidget {
  final List<TicketTypeEntity> tickets;
  final bool scrollable;
  final double? itemHeight;
  final double? itemWidth;
  final double? horizontalSpacing;
  final double? verticalSpacing;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const TicketGridView({
    super.key,
    required this.tickets,
    required this.itemBuilder,
    this.itemHeight,
    this.itemWidth,
    this.horizontalSpacing,
    this.verticalSpacing,
    this.scrollable = false,
  });

  static const int maxRows = 2;

  @override
  Widget build(BuildContext context) {
    final double verticalSpacing = this.verticalSpacing ?? 10;
    final double maxCrossAxisExtent = itemWidth ?? 600;

    return LayoutBuilder(
      builder: (context, constraints) {
        double itemHeight =
            this.itemHeight ?? _determineItemHeight(constraints.maxWidth);
        double crossAxisExtent = constraints.maxWidth;

        int columns = (crossAxisExtent / maxCrossAxisExtent).ceil();
        int rows = min(maxRows, (tickets.length / columns).ceil());

        columns = columns != 0 ? columns : 1;
        rows = rows != 0 ? rows : 1;
        int itemCount = min(rows * columns, tickets.length);

        if (itemCount == 0) {
          return Text(
            S.current.noTickets,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          );
        }

        return SizedBox(
          height: itemHeight * rows + verticalSpacing * (rows - 1),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: verticalSpacing,
              crossAxisSpacing: horizontalSpacing ?? 0,
              maxCrossAxisExtent: maxCrossAxisExtent,
              mainAxisExtent: itemHeight,
            ),
            itemBuilder: (context, index) => RepaintBoundary(
              child: itemBuilder(context, index),
            ),
            itemCount: scrollable ? tickets.length : itemCount,
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
