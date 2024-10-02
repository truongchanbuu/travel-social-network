import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/widgets/quill_content.dart';

class TourDescModal extends StatelessWidget {
  final String content;
  const TourDescModal({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                S.current.tourDescDetail,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: defaultPadding,
                right: defaultPadding,
                bottom: defaultPadding,
              ),
              child: QuillContent(content: content, isScrollable: true),
            ),
          ),
        ],
      ),
    );
  }
}
