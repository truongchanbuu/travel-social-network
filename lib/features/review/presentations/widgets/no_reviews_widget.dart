import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../bloc/review_bloc.dart';
import '../pages/create_review_page.dart';

class NoReviewsWidget extends StatelessWidget {
  final String postId;
  const NoReviewsWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.center,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.comment,
              color: Colors.grey,
              size: 25,
            ),
            const SizedBox(height: 6),
            Text(
              S.current.noReviews,
              textAlign: TextAlign.center,
              textDirection: defaultTextDirection,
              overflow: defaultTextOverflow,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            TextButton(
              onPressed: () => _openCommentPage(context),
              child: Text(
                S.current.comment,
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _openCommentPage(BuildContext context) {
    Navigator.push(
      context,
      PageTransition(
        child: BlocProvider(
          create: (context) => getIt.get<ReviewBloc>(),
          child: CreateReviewPage(postId: postId),
        ),
        type: PageTransitionType.bottomToTop,
      ),
    );
  }
}
