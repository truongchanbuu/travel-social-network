import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/form_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/add_image_view.dart';
import '../../../shared/presentations/widgets/custom_text_field.dart';
import '../../../shared/presentations/widgets/default_white_appbar.dart';
import '../bloc/review_bloc.dart';

class CreateReviewPage extends StatefulWidget {
  final String postId;
  const CreateReviewPage({super.key, required this.postId});

  @override
  State<CreateReviewPage> createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  late final GlobalKey<FormState> _formKey;
  double _rating = 5;
  String? _review;
  late String userId;
  List<ImageFile> images = [];

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();

    // TODO: MUST HAVE
    userId = 'TCB';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: defaultWhiteAppBar(titleText: S.current.reviews(0)),
        body: BlocListener<ReviewBloc, ReviewState>(
          listener: (context, state) {
            if (state is ReviewActionFailure) {
              showToast(state.message, context: context);
            } else if (state is ReviewActionSuccess) {
              showToast(S.current.success, context: context);
              Navigator.pop(context);
            }
          },
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.current.rateYourExperience,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: RatingStars(
                      onValueChanged: (value) =>
                          setState(() => _rating = value),
                      starSize: 40,
                      starSpacing: 10,
                      value: _rating,
                      valueLabelVisibility: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      S.current.tapToRate,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: CustomTextField(
                        validator: (value) => genericValidator(
                          value: value,
                          label: S.current.reviews(1),
                          minLength: 0,
                        ),
                        label: '',
                        onSaved: (value) => _review = value,
                        isAnimated: false,
                        hintTexts: [S.current.reviewHint],
                        maxLines: 7,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: AddImageView(
                      onImageSaved: (images) => this.images = images,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: _submitReview,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        minimumSize: minBtnSize,
                        shape: bottomSheetShape,
                      ),
                      child: Text(
                        S.current.submit,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitReview() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      context.read<ReviewBloc>().add(
            CreateReviewEvent(
              userId: userId,
              tourId: widget.postId,
              content: _review!,
              rating: _rating,
              images: images,
            ),
          );
    }
  }
}
