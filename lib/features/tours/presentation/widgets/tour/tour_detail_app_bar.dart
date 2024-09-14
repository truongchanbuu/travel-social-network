import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';
import '../../../data/models/tour.dart';
import 'tour_detail_thumb.dart';

class TourDetailAppBar extends StatefulWidget {
  final Tour tour;
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
  late final Tour tour;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    tour = widget.tour;
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      expandedHeight: widget.expandedHeight,
      automaticallyImplyLeading: true,
      leadingWidth: 40,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            Color titleColor = widget.titleColor;
            if (constraints.maxWidth > 500) {
              titleColor = primaryColor;
            }

            return Row(
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
                        ),
                        semanticsLabel: tour.tourName,
                        maxLines: 1,
                        textDirection: defaultTextDirection,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                GestureDetector(
                  onTap: () => setState(() => _isFavorite = !_isFavorite),
                  child: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: _isFavorite ? Colors.pink : titleColor,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.share,
                  color: titleColor,
                ),
              ],
            );
          },
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: TourDetailThumb(tour: tour),
      ),
    );
  }
}
