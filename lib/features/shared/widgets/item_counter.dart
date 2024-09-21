import 'package:flutter/material.dart';

import '../../../cores/constants/constants.dart';

class ItemCounter extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;

  const ItemCounter({
    super.key,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue = 10,
  });

  @override
  State<ItemCounter> createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  void _decrease() {
    if (_currentValue > widget.minValue) {
      setState(() => _currentValue--);
    }
  }

  void _increase() {
    if (_currentValue < widget.maxValue) {
      setState(() => _currentValue++);
    }
  }

  final BorderRadius borderRadius = const BorderRadius.all(Radius.circular(5));
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCounterButton(
          Icons.remove,
          _currentValue > widget.minValue ? _decrease : null,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.black54),
            borderRadius: borderRadius,
          ),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 50,
          alignment: Alignment.center,
          child: Text(
            '$_currentValue',
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        _buildCounterButton(
          Icons.add,
          _currentValue < widget.maxValue ? _increase : null,
        ),
      ],
    );
  }

  Widget _buildCounterButton(IconData icon, VoidCallback? onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.grey.withOpacity(0.1),
        ),
        padding: const EdgeInsets.all(15),
        child: Icon(
          icon,
          size: 16,
          color: onPressed == null ? Colors.grey : primaryColor,
        ),
      ),
    );
  }
}
