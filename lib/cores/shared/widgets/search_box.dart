import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(999);

    return Material(
      elevation: 10,
      borderRadius: borderRadius,
      child: TextField(
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide.none,
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
