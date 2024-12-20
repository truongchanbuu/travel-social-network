import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentations/bloc/auth_bloc.dart';
import '../../../tour/presentations/bloc/tour_bloc.dart';
import '../bloc/review_bloc.dart';
import '../pages/save_review_page.dart';

class NoReviewsWidget extends StatelessWidget {
  final String postId;
  const NoReviewsWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc authBloc) => authBloc.state.user);
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
              onPressed: user.isLoggedIn
                  ? () => _openCommentPage(context, user.id)
                  : null,
              child: Text(
                user.isLoggedIn
                    ? S.current.commentLabel
                    : S.current.loginToReview,
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _openCommentPage(BuildContext context, String userId) {
    Navigator.push(
      context,
      PageTransition(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt.get<ReviewBloc>()),
            BlocProvider(create: (context) => getIt.get<TourBloc>()),
          ],
          child: SaveReviewPage(
            postId: postId,
            userId: userId,
          ),
        ),
        type: PageTransitionType.bottomToTop,
      ),
    );
  }
}
