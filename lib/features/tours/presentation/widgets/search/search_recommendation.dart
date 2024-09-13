import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';

import './search_item.dart';
import './expanded_button.dart';

class SearchRecommendations extends StatefulWidget {
  const SearchRecommendations({super.key});

  @override
  State<SearchRecommendations> createState() => _SearchRecommendationsState();
}

class _SearchRecommendationsState extends State<SearchRecommendations> {
  bool _isExpanded = false;
  int minLines = 2;
  late int maxLines = minLines;

  List<String> recommendations = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    recommendations = [
      'Ha Noi Trip for 3 day 2 night',
      'Ho Chi Minh City Around Trip',
      'Bangkok - ThaiLand for 3 days',
      'Around Singapore',
      'Meeting the kangaroo at Australia',
      'Dynamic Life at New York City',
      'Around Singapore',
      'Meeting the kangaroo at Australia',
      'Dynamic Life at New York City',
    ]
      ..take(6)
      ..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    const double spacing = 10;

    return ExtendedWrap(
      textDirection: TextDirection.ltr,
      direction: Axis.horizontal,
      runSpacing: spacing,
      spacing: spacing,
      minLines: minLines,
      maxLines: maxLines,
      overflowWidget: ExpandedButton(
        isExpanded: _isExpanded,
        onPressed: () => setState(() {
          _isExpanded = !_isExpanded;
          maxLines = _isExpanded ? recommendations.length : minLines;
        }),
      ),
      children: recommendations.map(_buildRecommendationItem).toList(),
    );
  }

  Widget _buildRecommendationItem(String recommendation) {
    return SearchItem(title: recommendation);
  }
}
