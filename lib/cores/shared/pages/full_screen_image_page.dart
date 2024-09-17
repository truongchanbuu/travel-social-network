import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../constants/constants.dart';
import '../widgets/app_progressing_indicator.dart';
import '../widgets/error_image.dart';

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
        ),
      ),
    );
  }

  Widget _buildImageIndicator() {
    const double height = 80;

    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 5),
        itemCount: widget.imageUrls.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => _pageController.jumpToPage(index),
          child: Container(
            width: height,
            height: height,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color:
                    _currentIndex == index ? primaryColor : Colors.transparent,
                width: 5,
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: widget.imageUrls[index],
              fit: BoxFit.cover,
              cacheKey: '${widget.imageUrls[index]}-$index',
              errorWidget: (context, url, error) => ErrorImage(
                semanticLabel: 'Image at index $index',
              ),
              progressIndicatorBuilder: (context, url, loadingProgress) =>
                  _createLoadingWidget(loadingProgress.progress),
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
          childSize: MediaQuery.of(context).size,
          child: CachedNetworkImage(
            imageUrl: widget.imageUrls[index],
            fit: BoxFit.contain,
            alignment: Alignment.center,
            cacheKey: '${widget.imageUrls[index]}-$index',
            errorWidget: (context, error, stackTrace) => ErrorImage(
              semanticLabel: 'Image at index $index',
            ),
            progressIndicatorBuilder: (context, child, loadingProgress) =>
                _createLoadingWidget(loadingProgress.progress),
          ),
          heroAttributes:
              PhotoViewHeroAttributes(tag: '${widget.imageUrls[index]}-$index'),
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          basePosition: Alignment.center,
        ),
        loadingBuilder: (context, event) => _createLoadingWidget(
          event == null
              ? 0
              : event.cumulativeBytesLoaded /
                  num.parse('${event.expectedTotalBytes}'),
        ),
      );

  Widget _createLoadingWidget(double? loadingProgress) =>
      AppProgressingIndicator(
        size: 50,
        value: loadingProgress,
      );
}
