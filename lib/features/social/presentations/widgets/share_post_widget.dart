import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../user/presentations/bloc/user_cubit.dart';
import '../../domain/entities/post.dart';
import 'post_content.dart';
import 'post_header.dart';

class SharePostWidget extends StatelessWidget {
  final PostEntity post;
  const SharePostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 2,
            color: Colors.black12,
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: BlocProvider.value(
        value: context.read<UserCubit>()..getUser(post.userId),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            PostHeader(
              post: post,
              isMoreActionShowed: false,
            ),
            PostContent(post: post),
          ],
        ),
      ),
    );
  }
}
