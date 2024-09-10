import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final double elevation;
  const SearchBox({super.key, this.elevation = 0});

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(10);

    return Material(
      elevation: elevation,
      borderRadius: borderRadius,
      child: TextField(
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: elevation == 0
                ? const BorderSide(
                    width: 0.5,
                    color: Colors.grey,
                  )
                : BorderSide.none,
          ),
          hintText: 'Search your wonderful trips!',
          contentPadding: const EdgeInsets.all(18),
          suffixIcon: Container(
            padding: const EdgeInsets.all(15),
            child: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
