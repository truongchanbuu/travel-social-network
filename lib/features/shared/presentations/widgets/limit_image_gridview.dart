import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../generated/l10n.dart';
import '../pages/full_screen_image_page.dart';
import 'app_cached_image.dart';

class LimitImageGridView extends StatelessWidget {
  final List<String> images;
  const LimitImageGridView({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      children: _buildImages(context),
    );
  }

  List<Widget> _buildImages(BuildContext context) {
    if (images.length == 1) {
      return [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: _buildImageItem(context, 0),
        )
      ];
    }

    if (images.length == 2) {
      return [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 2,
          child: _buildImageItem(context, 0),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 2,
          child: _buildImageItem(context, 1),
        ),
      ];
    }

    if (images.length == 3) {
      return [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: _buildImageItem(context, 0),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: _buildImageItem(context, 1),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: _buildImageItem(context, 2),
        ),
      ];
    }

    if (images.length == 4) {
      return [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: _buildImageItem(context, 0),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: _buildImageItem(context, 1),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: _buildImageItem(context, 2),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: _buildImageItem(context, 3),
        ),
      ];
    }

    return [
      StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        child: _buildImageItem(context, 0),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        child: _buildImageItem(context, 1),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        child: _buildImageItem(context, 2),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        child: GestureDetector(
          onTap: () => _openFullViewPage(context, 3),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildImageItem(context, 3),
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    '+${images.length - 4}',
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  Widget _buildImageItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => _openFullViewPage(context, index),
      child: AppCachedImage(
        cacheKey: '${index}_${images[index]}',
        imageUrl: images[index],
        errorSemanticLabel: S.current.errorImage,
        loadingSemanticLabel: S.current.loading,
      ),
    );
  }

  void _openFullViewPage(BuildContext context, int index) {
    Navigator.push(
      context,
      PageTransition(
        child: FullScreenImagePage(
          imageUrls: images,
          initialPage: index,
        ),
        type: PageTransitionType.scale,
        fullscreenDialog: true,
        alignment: Alignment.center,
      ),
    );
  }
}
