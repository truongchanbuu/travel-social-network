import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';

class CreateTourDatesSection extends StatefulWidget {
  const CreateTourDatesSection({super.key});

  @override
  State<CreateTourDatesSection> createState() => _CreateTourDatesSectionState();
}

class _CreateTourDatesSectionState extends State<CreateTourDatesSection> {
  bool _isHover = false;
  List<DateTime> dates = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: dates.map(_buildDateTimeItem).toList(),
        ),
        _buildDateTimeItem(null),
      ],
    );
  }

  Widget _buildDateTimeItem(DateTime? date) {
    return InkWell(
      onHover: (value) => setState(() => _isHover = value),
      onTap: _addDate,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(999)),
          color: (date != null || _isHover) ? primaryColor : Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 5,
              color: Colors.grey.withOpacity(0.4),
            )
          ],
        ),
        padding:
            const EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 18),
        child: Row(
          children: [
            if (date == null)
              Icon(Icons.add, color: _isHover ? Colors.white : primaryColor),
            Text(
              date == null ? S.current.addDate : date.toString(),
              style: TextStyle(
                color: (date != null || _isHover) ? Colors.white : primaryColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              textDirection: defaultTextDirection,
              overflow: defaultTextOverflow,
            ),
          ],
        ),
      ),
    );
  }

  void _addDate() {}
}
