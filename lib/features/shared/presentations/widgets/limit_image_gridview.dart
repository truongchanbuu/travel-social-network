import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../generated/l10n.dart';
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
      children: _buildImages(),
    );
  }

  List<Widget> _buildImages() {
    if (images.length == 1) {
      return [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: _buildImageItem(0),
        )
      ];
    }

    if (images.length == 2) {
      return [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 2,
          child: _buildImageItem(0),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 2,
          child: _buildImageItem(1),
        ),
      ];
    }

    if (images.length == 3) {
      return [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: _buildImageItem(0),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: _buildImageItem(1),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: _buildImageItem(2),
        ),
      ];
    }

    if (images.length == 4) {
      return [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: _buildImageItem(0),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: _buildImageItem(1),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: _buildImageItem(2),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: _buildImageItem(3),
        ),
      ];
    }

    return [
      StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        child: _buildImageItem(0),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        child: _buildImageItem(1),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        child: _buildImageItem(2),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildImageItem(3),
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
    ];
  }

  Widget _buildImageItem(int index) {
    return AppCachedImage(
      cacheKey: '$index - ${images[index]}',
      imageUrl: images[index],
      errorSemanticLabel: S.current.errorImage,
      loadingSemanticLabel: S.current.loading,
    );
  }
}
