import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final double elevation;
  final double radius;
  final Color? fillColor;
  final bool enabled;
  final String? hintText;
  const SearchBox({
    super.key,
    this.elevation = 0,
    this.radius = 999,
    this.fillColor,
    this.enabled = false,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(radius);

    return Material(
      elevation: elevation,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: () {},
        borderRadius: borderRadius,
        splashColor: Colors.grey,
        child: TextField(
          enabled: enabled,
          textInputAction: TextInputAction.search,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: fillColor,
            filled: fillColor != null,
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
            suffixIcon: Container(
              padding: const EdgeInsets.all(15),
              child: const Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
