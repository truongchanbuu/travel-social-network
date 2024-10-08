import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import 'full_screen_image_page.dart';
import '../widgets/app_cached_image.dart';

class MediaViewPage extends StatefulWidget {
  final String prefixValueKey;
  final String? nameOfCollection;
  final List<String> imageUrls;
  const MediaViewPage({
    super.key,
    required this.prefixValueKey,
    this.nameOfCollection,
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

  AppBar _buildAppBar() =>  AppBar(
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
      title: Text(
        S.current.allImagesAndVideos,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );

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
          onTap: () => _showFullScreenImage(context, index),
          child: AppCachedImage(
            imageUrl: widget.imageUrls[index],
            cacheKey: S.current.cacheKeyWithId(widget.prefixValueKey, index),
            errorSemanticLabel: S.current.imageCollectionText(
                widget.nameOfCollection?.isNotEmpty == true
                    ? ' of ${widget.nameOfCollection}'
                    : ''),
            loadingSemanticLabel: S.current.loadingImageText(index),
          ),
        ),
      );

  void _showFullScreenImage(BuildContext context, int index) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullScreenImagePage(
            imageUrls: widget.imageUrls,
            initialPage: index,
          ),
        ),
      );
}
