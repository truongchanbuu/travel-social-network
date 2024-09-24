import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../domain/entities/tour.dart';
import 'tour_detail_thumb.dart';

class TourDetailAppBar extends StatefulWidget {
  final TourEntity tour;
  final Color titleColor;
  final double expandedHeight;
  const TourDetailAppBar({
    super.key,
    required this.tour,
    required this.expandedHeight,
    required this.titleColor,
  });

  @override
  State<TourDetailAppBar> createState() => _TourDetailAppBarState();
}

class _TourDetailAppBarState extends State<TourDetailAppBar> {
  late final TourEntity tour;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    tour = widget.tour;
  }

  @override
  Widget build(BuildContext context) {
    Color titleColor = widget.titleColor;
    BoxDecoration buttonOverlay = BoxDecoration(
      color: Colors.black.withOpacity(0.3),
      shape: BoxShape.circle,
    );

    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      expandedHeight: widget.expandedHeight,
      automaticallyImplyLeading: true,
      leadingWidth: 50,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.only(left: 5),
          decoration: widget.titleColor == Colors.white ? buttonOverlay : null,
          child: Icon(Icons.arrow_back, color: widget.titleColor),
        ),
      ),
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: widget.titleColor == Colors.white
              ? MainAxisAlignment.end
              : MainAxisAlignment.spaceBetween,
          children: [
            if (widget.titleColor != Colors.white)
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    tour.tourName,
                    style: TextStyle(
                      color: widget.titleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    semanticsLabel: tour.tourName,
                    maxLines: 1,
                    textDirection: defaultTextDirection,
                    overflow: defaultTextOverflow,
                  ),
                ),
              ),
            GestureDetector(
              onTap: () => setState(() => _isFavorite = !_isFavorite),
              child: Container(
                decoration:
                    widget.titleColor == Colors.white ? buttonOverlay : null,
                padding: const EdgeInsets.all(10),
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_outline,
                  color: _isFavorite ? Colors.pink : titleColor,
                ),
              ),
            ),
            const SizedBox(width: 6),
            GestureDetector(
              // TODO: SHARE FEATURE
              onTap: () => debugPrint('Share'),
              child: Container(
                decoration:
                    widget.titleColor == Colors.white ? buttonOverlay : null,
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.share,
                  color: titleColor,
                ),
              ),
            ),
          ],
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: IgnorePointer(
          ignoring: titleColor != Colors.white,
          child: TourDetailThumb(tourId: tour.tourId),
        ),
      ),
    );
  }
}
