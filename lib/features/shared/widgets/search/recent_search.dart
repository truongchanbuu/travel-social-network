import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import 'expanded_button.dart';
import 'search_item.dart';

class RecentSearch extends StatefulWidget {
  final List<String> recentSearches;
  const RecentSearch({super.key, required this.recentSearches});

  @override
  State<RecentSearch> createState() => _RecentSearchState();
}

class _RecentSearchState extends State<RecentSearch> {
  bool _isExpanded = false;
  int minLines = 2;
  late int maxLines = minLines;

  @override
  Widget build(BuildContext context) {
    const double spacing = 10;

    return ExtendedWrap(
      textDirection: defaultTextDirection,
      direction: Axis.horizontal,
      runSpacing: spacing,
      spacing: spacing,
      minLines: minLines,
      maxLines: maxLines,
      overflowWidget: ExpandedButton(
        isExpanded: _isExpanded,
        onPressed: () => setState(() {
          _isExpanded = !_isExpanded;
          maxLines = _isExpanded ? widget.recentSearches.length : minLines;
        }),
      ),
      children: widget.recentSearches.map(_buildRecentSearchItem).toList(),
    );
  }

  Widget _buildRecentSearchItem(String recentSearch) {
    return SearchItem(title: recentSearch);
  }
}
