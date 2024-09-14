import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../cores/constants/constants.dart';

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
                searchDecoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  hintText: 'Search your country by code or name',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  semanticCounterText: 'Maximum length of phone number',
                  border: OutlineInputBorder(
                    borderRadius: inputFieldBorderRadius,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  floatingLabelStyle: const TextStyle(color: primaryColor),
                  counterText: '',
                ),
                maxLength: 15,
                textDirection: defaultTextDirection,
                cursorColor: primaryColor,
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
      return 'Please enter your phone number';
    }

    final RegExp phoneNumberRegExp = RegExp(r'^(1)\d{10}$');
    if (!phoneNumberRegExp.hasMatch(phoneNumber!)) {
      return 'Invalid phone number';
    }

    return null;
  }
}
