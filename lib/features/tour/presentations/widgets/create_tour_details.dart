import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/utils/form_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../../shared/presentations/widgets/custom_text_field.dart';
import '../../../shared/presentations/widgets/duration_picker.dart';
import '../../../shared/presentations/widgets/long_text_field.dart';
import '../../../shared/presentations/widgets/search_field.dart';
import '../../domain/entities/tour.dart';
import '../bloc/tour_bloc.dart';

class CreateTourDetails extends StatefulWidget {
  final TourEntity tour;
  const CreateTourDetails({super.key, required this.tour});

  @override
  State<CreateTourDetails> createState() => CreateTourDetailsState();
}

class CreateTourDetailsState extends State<CreateTourDetails> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _durationController;
  late final TextEditingController _tourNameController;
  late final TextEditingController _tourDepartureController;
  late final TextEditingController _tourDestController;
  late TourEntity tour;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _durationController = TextEditingController();
    _tourNameController = TextEditingController();
    _tourDepartureController = TextEditingController();
    _tourDestController = TextEditingController();

    tour = widget.tour;

    _initControllers();
  }

  void _initControllers() {
    _durationController.text = tour.duration;
    _tourNameController.text = tour.tourName;
    _tourDepartureController.text = tour.departure;
    _tourDestController.text = tour.destination;
  }

  @override
  void dispose() {
    _durationController.dispose();
    _tourNameController.dispose();
    _tourDepartureController.dispose();
    _tourDestController.dispose();
    super.dispose();
  }

  static const spacing = SizedBox(height: 10);
  static const tourNameHints = [
    'Singapore Tour with Significant Lion State Visit',
    'Culture Heritage Tour at Ha Long Bay',
    'Historical Landmarks Exploration at Ho Chi Minh Museum',
    'Sunset Beach Tour at Da Nang City',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TourBloc, TourState>(
      builder: (context, state) {
        if (state is TourActionLoading) {
          return const AppProgressingIndicator();
        } else if (state is TourLoaded) {
          tour = state.tour;
          _initControllers();
        }

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                textEditingController: _tourNameController,
                validator: (value) => genericValidator(
                    label: S.current.tourNameLabel, value: value),
                // onSaved: (value) =>
                //     _genericOnValue(TourEntity.tourNameFieldName, value),
                onChanged: (value) =>
                    _genericOnValue(TourEntity.tourNameFieldName, value),
                label: S.current.tourNameLabel,
                hintTexts: tourNameHints,
              ),
              spacing,
              LongTextField(
                content: tour.tourDescription,
                title: S.current.tourDescLabel,
                onSaved: (value) =>
                    _genericOnValue(TourEntity.tourDescriptionFieldName, value),
                validator: (value) => genericValidator(
                    value: value, label: S.current.tourDescLabel),
              ),
              spacing,
              SearchField(
                textEditingController: _tourDepartureController,
                validator: (value) =>
                    genericValidator(value: value, label: S.current.departure),
                title: S.current.departure,
                onSelected: (value) =>
                    _genericOnValue(TourEntity.departureFieldName, value),
                onChanged: (value) =>
                    _genericOnValue(TourEntity.departureFieldName, value),
              ),
              spacing,
              SearchField(
                textEditingController: _tourDestController,
                validator: _destValidator,
                title: S.current.destination,
                onSelected: (value) =>
                    _genericOnValue(TourEntity.destinationFieldName, value),
                onChanged: (value) =>
                    _genericOnValue(TourEntity.destinationFieldName, value),
              ),
              spacing,
              LongTextField(
                title: S.current.tourItinerary,
                onSaved: (value) =>
                    _genericOnValue(TourEntity.tourScheduleFieldName, value),
                // content: tour.tourSchedule,
              ),
              spacing,
              CustomTextField(
                // inputFormatters: const [DurationInputFormatter()],
                textEditingController: _durationController,
                onSaved: (value) =>
                    _genericOnValue(TourEntity.durationFieldName, value),
                onChanged: (value) =>
                    _genericOnValue(TourEntity.durationFieldName, value),
                validator: _durationValidator,
                hintTexts: [S.current.durationHintText],
                isAnimated: false,
                label: S.current.duration,
                readOnly: true,
                onTap: _selectDuration,
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectDuration() async {
    var data = await showDialog(
      context: context,
      builder: (context) => DurationPicker(initialDuration: tour.duration),
    );

    if (data != null && data is String) {
      _genericOnValue(TourEntity.durationFieldName, data);
    }
  }

  void _genericOnValue(String fieldName, String? value) {
    final TourBloc tourBloc = context.read<TourBloc>();
    genericOnValue(
      bloc: tourBloc,
      updateEventConstructor: (fieldName, value) =>
          UpdateTourFieldEvent(fieldName, value),
      fieldName: fieldName,
      value: value,
    );
  }

  String? _durationValidator(String? value) {
    String? message =
        genericValidator(value: value, label: S.current.duration, minLength: 0);
    if (message != null) return message;

    if (value!.startsWith('0')) {
      return S.current.invalidDurationError;
    }

    return null;
  }

  String? _destValidator(String? value) {
    String? message = genericValidator(
        value: value, label: S.current.destination, minLength: 5);

    if (message != null) return message;
    if (tour.departure.isNotEmpty && tour.destination == tour.departure) {
      return S.current.duplicateLocation;
    }

    return null;
  }

  bool validateForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      return true;
    }

    return false;
  }
}
