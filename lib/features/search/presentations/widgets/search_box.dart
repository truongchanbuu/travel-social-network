import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/app_theme.dart';

class SearchBox extends StatelessWidget {
  final double elevation;
  final double radius;
  final Color? fillColor;
  final bool enabled;
  final List<String> hintTexts;
  final bool searchIcon;
  final bool autofocus;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final Animationtype animationType;

  const SearchBox({
    super.key,
    this.elevation = 0,
    this.radius = 999,
    this.fillColor,
    this.enabled = false,
    this.hintTexts = const [],
    this.searchIcon = true,
    this.controller,
    this.autofocus = false,
    this.animationType = Animationtype.slide,
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
        child: AnimatedTextField(
          animationType: animationType,
          autofocus: autofocus,
          controller: controller,
          enabled: enabled,
          cursorColor: AppTheme.primaryColor,
          textInputAction: TextInputAction.search,
          keyboardType: TextInputType.text,
          hintTexts: hintTexts,
          hintTextStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            fillColor: fillColor,
            filled: fillColor != null,
            focusColor: AppTheme.primaryColor,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.primaryColor),
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
