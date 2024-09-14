import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

import './phone_code_bottom_sheet.dart';

class PhoneCodeDropdown extends StatefulWidget {
  const PhoneCodeDropdown({super.key});

  @override
  State<PhoneCodeDropdown> createState() => _PhoneCodeDropdownState();
}

class _PhoneCodeDropdownState extends State<PhoneCodeDropdown> {
  late String phoneCode;
  late String dialCode;

  @override
  void initState() {
    super.initState();
    phoneCode = 'VN';
    dialCode = '+84';
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _showCountryBottomSheet,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CountryFlag.fromCountryCode(
                phoneCode,
                width: 24,
                height: 24,
                shape: const Circle(),
              ),
              const SizedBox(width: 10),
              Text(dialCode),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }

  void _showCountryBottomSheet() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (context) => const PhoneCodeBottomSheet(),
    );
  }
}
