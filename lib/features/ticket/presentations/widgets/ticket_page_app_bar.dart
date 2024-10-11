import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../../tour/presentations/widgets/thumbnails_widget.dart';

class TicketPageAppBar extends StatelessWidget {
  final bool isLoading;
  final String ticketName;
  final List<String> imageUrls;
  final bool isVisible;
  final double expandedHeight;

  const TicketPageAppBar({
    super.key,
    required this.expandedHeight,
    this.isVisible = true,
    required this.ticketName,
    this.isLoading = false,
    this.imageUrls = const <String>[],
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(color: !isVisible ? Colors.white : Colors.black),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      expandedHeight: expandedHeight,
      pinned: true,
      leading: IgnorePointer(
        ignoring: !isVisible,
        child: BackButton(
          color: !isVisible ? Colors.white : Colors.black,
          onPressed: () => _backToPrevious(context),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: isVisible
            ? SizedBox(
                width: double.infinity,
                child: Text(
                  ticketName,
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
        background: isLoading
            ? const AppProgressingIndicator()
            : ThumbnailsWidget(imageUrls: imageUrls),
      ),
    );
  }

  void _backToPrevious(BuildContext context) => Navigator.pop(context);
}
