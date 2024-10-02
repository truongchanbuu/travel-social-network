import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_social_network/features/tour/presentation/widgets/duration_dropdown.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/long_text_field.dart';
import '../../../shared/widgets/search_field.dart';

class CreateTourDetails extends StatefulWidget {
  const CreateTourDetails({super.key});

  @override
  State<CreateTourDetails> createState() => _CreateTourDetailsState();
}

class _CreateTourDetailsState extends State<CreateTourDetails> {
  late final GlobalKey<FormState> _formKey;
  String? _currentDropdownTimeUnit;
  String? _tourName;
  String? _tourDesc;
  String? _departure;
  String? _destination;
  String? _tourItinerary;
  Duration? _duration;

  @override
  void initState() {
    super.initState();
    _currentDropdownTimeUnit = S.current.day;
    _formKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            validator: _tourNameValidator,
            onSaved: (value) => _tourName = value,
            label: S.current.tourNameLabel,
            hintTexts: const [
              'Singapore Tour with Significant Lion State Visit',
              'Culture Heritage Tour at Ha Long Bay',
              'Historical Landmarks Exploration at Ho Chi Minh Museum',
              'Sunset Beach Tour at Da Nang',
            ],
          ),
          const SizedBox(height: 10),
          LongTextField(
            title: S.current.tourDescLabel,
            onSaved: (value) => _tourDesc = value,
            validator: _tourDescValidator,
          ),
          const SizedBox(height: 10),
          SearchField(
            validator: _departureValidator,
            title: S.current.departure,
            onSelected: (value) => _departure = value,
          ),
          const SizedBox(height: 10),
          SearchField(
            validator: _destValidator,
            title: S.current.destination,
            onSelected: (value) => _destination = value,
          ),
          const SizedBox(height: 10),
          LongTextField(
            title: S.current.tourItinerary,
            onSaved: (value) => _tourItinerary = value,
          ),
          const SizedBox(height: 10),
          DurationDropdown(
            timeUnit: S.current.day,
            onSaved: _durationOnSaved,
            validator: _durationValidator,
          ),
        ],
      ),
    );
  }

  String? _tourNameValidator(String? value) {
    if ((value?.isEmpty ?? true) || value!.length < 10) {
      return S.current.lengthLimitError(S.current.tourNameLabel);
    }

    return null;
  }

  String? _departureValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return S.current.invalidDepartureError;
    }

    return null;
  }

  String? _destValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return S.current.invalidDestinationError;
    }

    if (_departure != null && _departure == _destination) {
      return S.current.duplicateLocation;
    }

    return null;
  }

  String? _tourDescValidator(String? value) {
    if ((value?.isEmpty ?? true) || value!.length < 10) {
      return S.current.lengthLimitError(S.current.tourDescLabel);
    }

    return null;
  }

  int _getDurationValue(String? value) =>
      value?.isEmpty ?? true ? -1 : int.parse(value!);

  void _durationOnSaved(value) {
    int intValue = _getDurationValue(value);
    switch (_currentDropdownTimeUnit?.toLowerCase()) {
      case 'day':
        _duration = Duration(days: intValue);
        break;
      case 'hour':
        _duration = Duration(hours: intValue);
        break;
      case 'minute':
        _duration = Duration(minutes: intValue);
        break;
      case 'second':
        _duration = Duration(seconds: intValue);
        break;
      default:
        throw ArgumentError('Invalid unit: $_currentDropdownTimeUnit');
    }
  }

  String? _durationValidator(String? value) {
    int numVal = _getDurationValue(value);
    if (numVal <= 0 || numVal > 366) {
      return S.current.invalidDurationError;
    }

    return null;
  }

  void _tourDetailValidator() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      print(
          '$_tourName - $_tourDesc -  $_departure - $_destination - $_duration');
    }
  }
}
