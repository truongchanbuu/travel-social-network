import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentations/bloc/auth_bloc.dart';
import '../../../user/presentations/widgets/user_avatar.dart';
import '../bloc/post_bloc.dart';
import '../pages/post_upload_page.dart';

class SocialNetworkUploadField extends StatelessWidget {
  const SocialNetworkUploadField({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.select((AuthBloc authBloc) => authBloc.state.user);
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      color: context.isDarkMode
          ? AppTheme.primaryColorDark
          : AppTheme.secondaryColor,
      child: Row(
        children: [
          UserAvatar(user: currentUser),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              onTap: () => _onPost(context),
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(999)),
                ),
                hintText: S.current.howYourFeeling,
                hintStyle: const TextStyle(color: AppTheme.secondaryColorDark),
              ),
              readOnly: true,
            ),
          ),
        ],
      ),
    );
  }

  void _onPost(BuildContext context) async {
    final postBloc = context.read<PostBloc>();

    var data = await Navigator.push(
      context,
      PageTransition(
        child: BlocProvider(
          create: (context) => getIt.get<PostBloc>(),
          child: const PostUploadPage(),
        ),
        type: PageTransitionType.bottomToTop,
        duration: const Duration(milliseconds: pageChangeTransitionDuration),
      ),
    );

    if (data != null) {
      postBloc.add(GetPostsEvent());
    }
  }
}
