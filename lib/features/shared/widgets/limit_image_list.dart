import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../pages/full_screen_image_page.dart';
import 'app_cached_image.dart';

class LimitImageList extends StatelessWidget {
  final double? imageSize;
  final String id;
  final List<String> imageUrls;
  final Widget? overflowWidget;

  const LimitImageList({
    super.key,
    required this.id,
    required this.imageUrls,
    this.imageSize,
    this.overflowWidget,
  });

  static const double defaultSize = 80;

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double size = imageSize ?? defaultSize;
    bool needToScroll = (size >= screenSize / 2) && overflowWidget != null;

    int itemQuantity = _determineQuantity(screenSize, size);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: needToScroll
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      child: Row(
        children: [
          Row(
            children: imageUrls.take(itemQuantity).map((url) {
              int index = imageUrls.indexOf(url);

              return Padding(
                padding: const EdgeInsets.only(right: 5),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImagePage(
                          imageUrls: imageUrls, initialPage: index),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        width: size,
                        height: size,
                        child: AppCachedImage(
                          imageUrl: url,
                          cacheKey: S.current.cacheKeyWithId(id, index),
                          errorImageSize: 20,
                          errorSemanticLabel: S.current.imageAtIndex(index),
                          loadingSemanticLabel:
                              S.current.loadingImageText(index),
                        ),
                      ),
                      if (isOverflowed(index, itemQuantity))
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Center(
                              child: Text(
                                '+${imageUrls.length - itemQuantity}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          if (overflowWidget != null) overflowWidget!,
        ],
      ),
    );
  }

  int _determineQuantity(double screenSize, double itemSize) {
    int result = (screenSize ~/ itemSize) - 1;
    return result <= 0 ? 1 : result;
  }

  bool isOverflowed(int index, int quantity) {
    return index == quantity - 1 && imageUrls.length - quantity > 0;
  }
}
