import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';

class PhoneInputField extends StatefulWidget {
  const PhoneInputField({super.key});

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDropDownButtonShown = true;
        bool isFlagShown = true;

        if (constraints.maxWidth < 560) {
          isDropDownButtonShown = false;
        }

        if (constraints.maxWidth < 345) {
          isFlagShown = false;
        }

        return Row(
          children: [
            Expanded(
              flex: 1,
              child: CountryCodePicker(
                mode: CountryCodePickerMode.bottomSheet,
                initialSelection: 'VN',
                barrierColor: Colors.transparent,
                showFlag: isFlagShown,
                showDropDownButton: isDropDownButtonShown,
                alignLeft: true,
                searchDecoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.primaryColor),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.primaryColor),
                  ),
                  hintText: S.current.phoneSearchHintText,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: S.current.phoneNumber,
                  semanticCounterText: S.current.semanticPhoneNumberCounterText,
                  border: const OutlineInputBorder(
                    borderRadius: defaultFieldBorderRadius,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.primaryColor),
                  ),
                  floatingLabelStyle:
                      const TextStyle(color: AppTheme.primaryColor),
                  counterText: '',
                ),
                maxLength: 15,
                textDirection: defaultTextDirection,
                cursorColor: AppTheme.primaryColor,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: _validatePhoneNumber,
                onChanged: (String? value) {},
              ),
            ),
          ],
        );
      },
    );
  }

  String? _validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber?.isEmpty ?? true) {
      return S.current.enterPhoneNumberRequirement;
    }

    final RegExp phoneNumberRegExp = RegExp(r'^(1)\d{10}$');
    if (!phoneNumberRegExp.hasMatch(phoneNumber!)) {
      return S.current.invalidPhoneNumberError;
    }

    return null;
  }
}
