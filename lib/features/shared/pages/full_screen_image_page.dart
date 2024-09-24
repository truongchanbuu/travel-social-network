import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../cores/constants/constants.dart';
import '../../../generated/l10n.dart';
import '../widgets/app_cached_image.dart';

class FullScreenImagePage extends StatefulWidget {
  final List<String> imageUrls;
  final int initialPage;
  const FullScreenImagePage({
    super.key,
    required this.imageUrls,
    this.initialPage = 0,
  });

  @override
  State<FullScreenImagePage> createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  late int _currentIndex;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialPage;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildPhotoGallery(),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildImageIndicator(),
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      title: Text(
        '${_currentIndex + 1} / ${widget.imageUrls.length}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildImageIndicator() {
    return SizedBox(
      height: imageIndicatorHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.imageUrls.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => _pageController.jumpToPage(index),
          child: Container(
            width: imageIndicatorHeight,
            height: imageIndicatorHeight,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color:
                    _currentIndex == index ? primaryColor : Colors.transparent,
                width: 5,
              ),
            ),
            child: AppCachedImage(
              imageUrl: widget.imageUrls[index],
              cacheKey: '${widget.imageUrls[index]}-$index',
              errorSemanticLabel: S.current.image,
              loadingSemanticLabel: S.current.loadingImageText(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoGallery() => PhotoViewGallery.builder(
        onPageChanged: (index) => setState(() => _currentIndex = index),
        pageController: _pageController,
        itemCount: widget.imageUrls.length,
        builder: (context, index) => PhotoViewGalleryPageOptions.customChild(
          child: AppCachedImage(
            imageUrl: widget.imageUrls[index],
            cacheKey: '${widget.imageUrls[index]}-$index',
            errorSemanticLabel: S.current.imageAtIndex(index),
            loadingSemanticLabel: S.current.loadingImageText(index),
          ),
          heroAttributes:
              PhotoViewHeroAttributes(tag: '${widget.imageUrls[index]}-$index'),
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          basePosition: Alignment.center,
        ),
      );
}
