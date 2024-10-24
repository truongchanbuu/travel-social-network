import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentations/bloc/auth_bloc.dart';
import '../../../auth/presentations/widgets/icon_with_text.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final UserEntity user =
        context.select((AuthBloc authBloc) => authBloc.state.user);

    final screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = (screenWidth / (user.isLoggedIn ? 4 : 3) - 10);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.start,
        runSpacing: 10,
        children: [
          SizedBox(
            width: itemWidth,
            child: IconWithText(
              iconData: Icons.info_outline,
              text: S.current.aboutUs,
            ),
          ),
          SizedBox(
            width: itemWidth,
            child: IconWithText(
              iconData: Icons.star_border,
              text: S.current.rateForUs,
            ),
          ),
          SizedBox(
            width: itemWidth,
            child: IconWithText(
              iconData: Icons.book_outlined,
              text: S.current.termAndCondition,
            ),
          ),
          if (user.isLoggedIn)
            SizedBox(
              width: itemWidth,
              child: IconWithText(
                iconData: Icons.tour_outlined,
                text: S.current.myTour,
              ),
            ),
        ],
      ),
    );
  }
}
