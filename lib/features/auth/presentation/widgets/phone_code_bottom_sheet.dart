import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/constants/constants.dart';

import '../../../../cores/constants/country_codes.dart';
import '../../../../cores/constants/types.dart';

class PhoneCodeBottomSheet extends StatelessWidget {
  final List<CountryCode> codes;
  const PhoneCodeBottomSheet({
    super.key,
    this.codes = countryCodes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: TextField(
              cursorColor: primaryColor,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                hintText: 'Search for your country',
                prefixIcon: const Icon(Icons.search),
              ),
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: _buildCountryItem,
              itemCount: countryCodes.length,
              itemExtent: 50,
              semanticChildCount: countryCodes.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountryItem(BuildContext context, int index) {
    CountryCode countryCode = countryCodes[index];
    return ListTile(
      title: Text(countryCode['name'] ?? 'N/A'),
      leading: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CountryFlag.fromCountryCode(countryCode['code'] ?? 'N/A'),
          const SizedBox(width: 10),
          Text(
            countryCode['dial_code'] ?? '+??',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      titleAlignment: ListTileTitleAlignment.center,
      onTap: () {},
    );
  }
}