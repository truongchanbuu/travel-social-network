import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';
import '../constants/constants.dart';

String? genericValidator({
  required String? value,
  bool checkEmpty = true,
  int? minLength,
  String? label,
  String? emptyErrorMessage,
  String? lengthErrorMessage,
}) {
  if (checkEmpty && (value?.isEmpty ?? true)) {
    return emptyErrorMessage ?? S.current.notAllowedEmpty;
  }

  if (checkEmpty) {
    if (value!.length < (minLength ?? minLimitLength)) {
      return lengthErrorMessage ??
          S.current.lengthLimitError(label ?? '', minLength ?? minLimitLength);
    }
  }

  return null;
}

void genericOnValue({
  required Bloc bloc,
  required Function(String fieldName, dynamic value) updateEventConstructor,
  required String fieldName,
  required String? value,
}) {
  if (value?.isNotEmpty ?? false) {
    num? number = num.tryParse(value!);

    if (number != null && number != 0) {
      bloc.add(updateEventConstructor(fieldName, number));
    } else if (number == null) {
      bloc.add(updateEventConstructor(fieldName, value));
    }
  }
}
