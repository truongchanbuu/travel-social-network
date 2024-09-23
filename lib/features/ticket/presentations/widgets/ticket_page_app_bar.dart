import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../tour/presentation/widgets/tour_detail_thumb.dart';
import '../../domain/entities/ticket_type.dart';

class TicketPageAppBar extends StatelessWidget {
  final TicketTypeEntity ticket;
  final bool isVisible;
  final double expandedHeight;
  const TicketPageAppBar({
    super.key,
    required this.expandedHeight,
    this.isVisible = true,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(color: !isVisible ? Colors.white : Colors.black),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      expandedHeight: expandedHeight,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: isVisible
            ? SizedBox(
                width: double.infinity,
                child: Text(
                  ticket.ticketTypeName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  maxLines: 1,
                  overflow: defaultTextOverflow,
                  textDirection: defaultTextDirection,
                ),
              )
            : null,
        background: TourDetailThumb(tourId: ticket.tourId),
      ),
    );
  }
}
