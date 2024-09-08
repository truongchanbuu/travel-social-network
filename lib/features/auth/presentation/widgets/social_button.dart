import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String title;
  final Color? textColor;
  final Widget? leading;
  final Color? buttonColor;

  const SocialButton({
    super.key,
    required this.title,
    this.textColor,
    this.leading,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = MediaQuery.of(context).size.width / 1.5;

        if (constraints.maxWidth <= 575.8) {
          width = MediaQuery.of(context).size.width - 100;
        }

        return SizedBox(
          width: width,
          child: ListTile(
            leading: leading,
            title: Center(
              child: Text(
                title,
                semanticsLabel: title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            titleTextStyle: TextStyle(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: buttonColor == null
                  ? const BorderSide(width: 1, color: Colors.black)
                  : BorderSide.none,
            ),
            titleAlignment: ListTileTitleAlignment.center,
            tileColor: buttonColor,
            onTap: () {},
          ),
        );
      },
    );
  }
}
