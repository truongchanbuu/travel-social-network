import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import 'create_tour_field.dart';
import 'create_tour_search_field.dart';
import 'tour_desc_field.dart';

class CreateTourDetails extends StatefulWidget {
  const CreateTourDetails({super.key});

  @override
  State<CreateTourDetails> createState() => _CreateTourDetailsState();
}

class _CreateTourDetailsState extends State<CreateTourDetails> {
  late final GlobalKey<FormState> _formKey;
  String? _tourName;
  String? _tourDesc;
  String? _departure;
  String? _destination;
  Duration? _duration;

  List<DropdownMenuItem> _dropDownItems = List.empty(growable: true);
  String? _currentDropdownTimeUnit;

  @override
  void initState() {
    super.initState();
    _dropDownItems = [
      DropdownMenuItem(
        value: S.current.hour,
        child: Text(
          S.current.hour,
          overflow: defaultTextOverflow,
          textDirection: defaultTextDirection,
        ),
      ),
      DropdownMenuItem(
        value: S.current.day,
        child: Text(
          S.current.day,
          overflow: defaultTextOverflow,
          textDirection: defaultTextDirection,
        ),
      ),
      DropdownMenuItem(
        value: S.current.week,
        child: Text(
          S.current.week,
          overflow: defaultTextOverflow,
          textDirection: defaultTextDirection,
        ),
      ),
      DropdownMenuItem(
        value: S.current.month,
        child: Text(
          S.current.month,
          overflow: defaultTextOverflow,
          textDirection: defaultTextDirection,
        ),
      ),
      DropdownMenuItem(
        value: S.current.year,
        child: Text(
          S.current.year,
          overflow: defaultTextOverflow,
          textDirection: defaultTextDirection,
        ),
      ),
    ];
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
          CreateTourField(
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
          TourDescField(onSaved: (value) => _tourDesc = value),
          const SizedBox(height: 10),
          CreateTourSearchField(
            validator: _departureValidator,
            title: S.current.departure,
            onSelected: (value) => _departure = value,
          ),
          const SizedBox(height: 10),
          CreateTourSearchField(
            validator: _destValidator,
            title: S.current.destination,
            onSelected: (value) => _destination = value,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                flex: 2,
                child: CreateTourField(
                  onSaved: _durationOnSaved,
                  validator: _durationValidator,
                  onEditingCompleted: _tourDetailValidator,
                  textEditingController: TextEditingController(text: '1'),
                  label: S.current.duration,
                  singleHintText: S.current.durationHintText,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.go,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              const SizedBox(width: 5),
              Flexible(
                flex: 1,
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                  icon: const SizedBox.shrink(),
                  value: _currentDropdownTimeUnit,
                  items: _dropDownItems,
                  alignment: Alignment.center,
                  padding: EdgeInsets.zero,
                  style: const TextStyle(overflow: defaultTextOverflow),
                  iconSize: 0,
                  onChanged: (value) => _currentDropdownTimeUnit = value,
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: _tourDetailValidator,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: inputFieldBorderRadius,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  S.current.next,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
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

    if (numVal < 0 || numVal > 366) {
      return S.current.invalidDurationError;
    }

    return null;
  }

  String? _tourNameValidator(String? value) {
    if ((value?.isEmpty ?? true) || value!.length < 10) {
      return S.current.invalidTourNameError;
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

    return null;
  }

  void _tourDetailValidator() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      print(
          '$_tourName - $_tourDesc - $_duration - $_departure - $_destination');
    }
  }
}
