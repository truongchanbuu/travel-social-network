import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';

class DateTimeItem extends StatefulWidget {
  final String date;
  final bool isSelected;
  final void Function()? onTap;

  const DateTimeItem({
    super.key,
    required this.date,
    this.isSelected = false,
    this.onTap,
  });

  @override
  State<DateTimeItem> createState() => _DateTimeItemState();
}

class _DateTimeItemState extends State<DateTimeItem> {
  bool _isHover = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.isSelected;
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(999)),
      onHover: (value) => setState(() => _isHover = value),
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(999)),
          color: _isHover || isSelected ? primaryColor : Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 5,
              color: Colors.grey.withOpacity(0.5),
            )
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.date,
              style: TextStyle(
                color: _isHover || isSelected ? Colors.white : primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
