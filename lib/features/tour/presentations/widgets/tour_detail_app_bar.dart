import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../cores/constants/constants.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../bloc/tour_bloc.dart';
import 'thumbnails_widget.dart';

class TourDetailAppBar extends StatefulWidget {
  final Color titleColor;
  final double expandedHeight;

  const TourDetailAppBar({
    super.key,
    required this.expandedHeight,
    required this.titleColor,
  });

  @override
  State<TourDetailAppBar> createState() => _TourDetailAppBarState();
}

class _TourDetailAppBarState extends State<TourDetailAppBar> {
  bool _isFavorite = false;

  BoxDecoration buttonOverlay = BoxDecoration(
    color: Colors.black.withOpacity(0.3),
    shape: BoxShape.circle,
  );

  @override
  Widget build(BuildContext context) {
    Color titleColor = widget.titleColor;

    return BlocBuilder<TourBloc, TourState>(
      builder: (context, state) {
        if (state is TourLoaded) {
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
                decoration:
                    widget.titleColor == Colors.white ? buttonOverlay : null,
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
                          state.tour.tourName,
                          style: TextStyle(
                            color: widget.titleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          semanticsLabel: state.tour.tourName,
                          maxLines: 1,
                          textDirection: defaultTextDirection,
                          overflow: defaultTextOverflow,
                        ),
                      ),
                    ),
                  // TODO: FAVORITE TOUR FEATURE
                  GestureDetector(
                    onTap: () => setState(() => _isFavorite = !_isFavorite),
                    child: Container(
                      decoration: widget.titleColor == Colors.white
                          ? buttonOverlay
                          : null,
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
                    onTap: _onShared,
                    child: Container(
                      decoration: widget.titleColor == Colors.white
                          ? buttonOverlay
                          : null,
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
                child: ThumbnailsWidget(imageUrls: state.tour.imageUrls),
              ),
            ),
          );
        }

        return const AppProgressingIndicator();
      },
    );
  }

  void _onShared() async {
    Share.share('TEST SHARE');
  }
}
