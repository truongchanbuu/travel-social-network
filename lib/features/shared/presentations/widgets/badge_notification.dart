import 'package:flutter/material.dart';

class BadgeNotification extends StatefulWidget {
  final int badges;
  const BadgeNotification({
    super.key,
    this.badges = 0,
  });

  @override
  State<BadgeNotification> createState() => _BadgeNotificationState();
}

class _BadgeNotificationState extends State<BadgeNotification> {
  @override
  Widget build(BuildContext context) {
    return Badge(
      isLabelVisible: widget.badges != 0,
      label: Text(widget.badges.toString()),
      textColor: Colors.white,
      largeSize: 20,
      alignment: FractionalOffset.topRight,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
          ),
          padding: const EdgeInsets.all(10),
          child: const Icon(Icons.notifications_outlined),
        ),
      ),
    );
  }
}
