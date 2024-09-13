import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';

class SearchBox extends StatelessWidget {
  final double elevation;
  final double radius;
  final Color? fillColor;
  final bool enabled;
  final String? hintText;
  final bool searchIcon;
  final bool autofocus;
  final TextEditingController? controller;
  final VoidCallback? onTap;

  const SearchBox({
    super.key,
    this.elevation = 0,
    this.radius = 999,
    this.fillColor,
    this.enabled = false,
    this.hintText,
    this.searchIcon = true,
    this.controller,
    this.autofocus = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(radius);

    return Material(
      elevation: elevation,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        splashColor: Colors.grey,
        child: TextField(
          autofocus: autofocus,
          controller: controller,
          enabled: enabled,
          cursorColor: primaryColor,
          textInputAction: TextInputAction.search,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: fillColor,
            filled: fillColor != null,
            focusColor: primaryColor,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
            ),
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: elevation == 0
                  ? const BorderSide(
                      width: 0.5,
                      color: Colors.grey,
                    )
                  : BorderSide.none,
            ),
            hintText: hintText,
            contentPadding: const EdgeInsets.all(18),
            suffixIcon: searchIcon
                ? Container(
                    padding: const EdgeInsets.all(15),
                    child: const Icon(Icons.search),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
