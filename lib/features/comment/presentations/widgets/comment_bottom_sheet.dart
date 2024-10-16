import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../domain/entities/comment.dart';
import '../bloc/comment_bloc.dart';
import 'comment_input.dart';
import 'comment_item.dart';

class CommentBottomSheet extends StatelessWidget {
  final String postId;
  const CommentBottomSheet({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentActionLoading || state is CommentInitial) {
          return const AppProgressingIndicator();
        }

        return Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: Text(
                S.current.comment,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            _buildComments(
              state is ListOfCommentsReceived ? state.comments : [],
            ),
            CommentInput(postId: postId),
          ],
        );
      },
    );
  }

  Widget _buildComments(List<CommentEntity> comments) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => CommentItem(comment: comments[index]),
        itemCount: comments.length,
      ),
    );
  }
}
