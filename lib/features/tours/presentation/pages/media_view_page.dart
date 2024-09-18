import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../cores/shared/pages/full_screen_image_page.dart';
import '../../../../cores/shared/widgets/app_progressing_indicator.dart';
import '../../../../cores/shared/widgets/error_image.dart';

class MediaViewPage extends StatefulWidget {
  final String tourId;
  final String tourName;
  final List<String> imageUrls;
  const MediaViewPage({
    super.key,
    required this.tourId,
    required this.tourName,
    required this.imageUrls,
  });

  @override
  State<MediaViewPage> createState() => _MediaViewPageState();
}

class _MediaViewPageState extends State<MediaViewPage> {
  bool _isListView = true;

  @override
  Widget build(BuildContext context) {
    double itemExtent = MediaQuery.of(context).size.height / 4;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: _buildBody(itemExtent),
    );
  }

  Widget _buildBody(double itemExtent) => Padding(
        padding: const EdgeInsets.all(10),
        child: _isListView
            ? _buildMediaListView(itemExtent)
            : _buildMediaGridView(itemExtent),
      );

  AppBar _buildAppBar() {
    return AppBar(
      leading: BackButton(
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        _isListView
            ? IconButton(
                onPressed: () => setState(() => _isListView = false),
                icon: const Icon(Icons.grid_view))
            : IconButton(
                onPressed: () => setState(() => _isListView = true),
                icon: const Icon(Icons.list))
      ],
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: const Text(
        'All Images and Videos',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildMediaListView(double itemExtent) => ListView.builder(
        itemBuilder: _buildMediaItem,
        itemCount: widget.imageUrls.length,
        itemExtent: itemExtent,
      );

  Widget _buildMediaGridView(double itemExtent) => GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: itemExtent,
          mainAxisExtent: itemExtent,
        ),
        itemBuilder: _buildMediaItem,
        itemCount: widget.imageUrls.length,
      );

  Widget _buildMediaItem(BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullScreenImagePage(
                imageUrls: widget.imageUrls,
                initialPage: index,
              ),
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: widget.imageUrls[index],
            fit: BoxFit.cover,
            alignment: Alignment.center,
            cacheKey: '${widget.tourId}_img_$index',
            errorWidget: (context, error, stackTrace) => ErrorImage(
              semanticLabel: 'Image of ${widget.tourName}',
            ),
            progressIndicatorBuilder: (context, child, loadingProgress) =>
                AppProgressingIndicator(
              size: 50,
              semanticLabel:
                  'Loading the image at $index index for tour with name ${widget.tourName}',
              value: loadingProgress.progress,
            ),
          ),
        ),
      );
}
