import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../cores/shared/widgets/app_progressing_indicator.dart';

class TourDetailAppBar extends StatelessWidget {
  const TourDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    const double expandedHeight = 250;

    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      expandedHeight: expandedHeight,
      automaticallyImplyLeading: true,
      leadingWidth: 40,
      titleSpacing: 0,
      title: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Underwater World Pattaya',
                style: TextStyle(
                  color: Colors.white,
                ),
                semanticsLabel: 'Underwater World Pattaya',
                maxLines: 1,
                textDirection: TextDirection.ltr,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.favorite_outline),
            SizedBox(width: 10),
            Icon(Icons.share),
          ],
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: CachedNetworkImage(
          imageUrl:
              'https://mediaim.expedia.com/localexpert/823737/fc50c54c-f7e6-48f8-a708-1e5740c8aa02.jpg?impolicy=resizecrop&rw=1005&rh=565',
          fit: BoxFit.cover,
          errorWidget: (context, error, stackTrace) {
            debugPrint(stackTrace.toString());
            return Container(
              color: Colors.black.withOpacity(0.2),
              child: const Center(
                child: Icon(
                  Icons.image,
                  size: 50,
                  color: Colors.grey,
                  semanticLabel: 'Image of Underwater World Pattaya',
                ),
              ),
            );
          },
          progressIndicatorBuilder: (context, child, loadingProgress) =>
              AppProgressingIndicator(
            size: 50,
            semanticLabel: 'Loading Underwater World Pattaya',
            value: loadingProgress.progress,
          ),
        ),
      ),
    );
  }
}
