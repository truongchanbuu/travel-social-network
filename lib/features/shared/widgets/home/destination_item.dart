import 'package:flutter/material.dart';

class DestinationItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  const DestinationItem({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    const double width = 200;
    const double height = 200;

    return GestureDetector(
      onTap: () {},
      child: GridTile(
        footer: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: Card(
          elevation: 10,
          shadowColor: Colors.grey,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image(
            width: width,
            height: height,
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const SizedBox(
              width: width,
              height: height,
              child: Center(
                child: Icon(Icons.image),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
