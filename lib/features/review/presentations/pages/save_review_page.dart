import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:travel_social_network/features/shared/presentations/widgets/app_progressing_indicator.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/form_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/add_image_view.dart';
import '../../../shared/presentations/widgets/custom_text_field.dart';
import '../../../shared/presentations/widgets/default_white_appbar.dart';
import '../../domain/entities/review.dart';
import '../bloc/review_bloc.dart';

class SaveReviewPage extends StatefulWidget {
  final String? reviewId;
  final String postId;
  const SaveReviewPage({super.key, required this.postId, this.reviewId});

  @override
  State<SaveReviewPage> createState() => _SaveReviewPageState();
}

class _SaveReviewPageState extends State<SaveReviewPage> {
  late final GlobalKey<FormState> _formKey;
  double _rating = 5;
  late String userId;
  ReviewEntity? review;
  List<ImageFile> images = [];

  late final TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _contentController = TextEditingController();

    // TODO: MUST HAVE
    userId = 'TCB';

    if (widget.reviewId?.isNotEmpty ?? false) {
      context.read<ReviewBloc>().add(GetReviewByIdEvent(widget.reviewId!));
    } else {
      context
          .read<ReviewBloc>()
          .add(InitializeNewReviewEvent(tourId: widget.postId, userId: userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: defaultWhiteAppBar(titleText: S.current.reviews(0)),
        body: BlocConsumer<ReviewBloc, ReviewState>(
          listener: (context, state) {
            if (state is ReviewActionFailure) {
              showToast(state.message, context: context);
            } else if (state is ReviewActionSuccess) {
              showToast(S.current.success, context: context);
              Navigator.pop(context, state.review);
            }
          },
          builder: (context, state) {
            if (state is ReviewInitial) {
              return const AppProgressingIndicator();
            } else if (state is ReviewLoaded) {
              review = state.review;
              _rating = state.review.rating;
              _contentController.text = state.review.content;
              images = state.review.images.map((imgUrl) {
                int index = state.review.images.indexOf(imgUrl);
                return ImageFile(
                  UniqueKey().toString(),
                  name: 'Review image $index',
                  path: imgUrl,
                  extension: 'jpg',
                );
              }).toList();
            } else if (state is ReviewImageLoaded) {
              images = state.images;
            }

            return SizedBox(
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
                        onValueChanged: (value) => context
                            .read<ReviewBloc>()
                            .add(UpdateReviewFieldEvent(
                                ReviewEntity.ratingFieldName, value)),
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
                          textEditingController: _contentController,
                          validator: (value) => genericValidator(
                            value: value,
                            label: S.current.reviews(1),
                            minLength: 0,
                          ),
                          label: '',
                          isAnimated: false,
                          hintTexts: [S.current.reviewHint],
                          maxLines: 7,
                        ),
                      ),
                    ),
                    state is! ReviewLoaded || state is! ReviewImageLoaded
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: AddImageView(
                              images: images,
                              onImageSaved: (images) => context
                                  .read<ReviewBloc>()
                                  .add(UploadImageEvent(images)),
                            ),
                          )
                        : const AppProgressingIndicator(),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: review != null
                            ? () => _submitReview(review!)
                            : null,
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
            );
          },
        ),
      ),
    );
  }

  void _submitReview(ReviewEntity review) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      context.read<ReviewBloc>().add(
            CreateReviewEvent(
              review.copyWith(
                content: _contentController.text,
                rating: _rating,
              ),
              images,
            ),
          );
    }
  }
}
