import 'package:flutter/material.dart';

import 'ticket_item.dart';

class TicketGridView extends StatelessWidget {
  final List<String> tickets;
  const TicketGridView({super.key, required this.tickets});

  @override
  Widget build(BuildContext context) {
    const double spacing = 10;

    return SliverLayoutBuilder(
      builder: (context, constraints) {
        double crossAxisExtent = constraints.crossAxisExtent;
        double maxAxisExtent = 150;
        if (crossAxisExtent < 290 && crossAxisExtent > 190) {
          maxAxisExtent = 200;
        } else if (crossAxisExtent <= 190) {
          maxAxisExtent = 250;
        }

        return SliverToBoxAdapter(
          child: SizedBox(
            height: maxAxisExtent * 2 + spacing,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: spacing,
                maxCrossAxisExtent: 600,
                mainAxisExtent: maxAxisExtent,
              ),
              itemBuilder: (context, index) =>
                  TicketItem(ticket: tickets[index]),
              itemCount: tickets.length,
            ),
          ),
        );
      },
    );
  }
}
