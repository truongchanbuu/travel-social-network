import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';

class TicketItem extends StatelessWidget {
  final String ticket;
  const TicketItem({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isOverflowed = constraints.maxWidth < 260;

        return Container(
          width: 500,
          margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ticket,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'See detail',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const Divider(color: Colors.grey, thickness: 0.5),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'VND 7,890,000',
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (!isOverflowed) _buildSelectButton(),
                ],
              ),
              if (isOverflowed) ...[
                const SizedBox(height: 10),
                _buildSelectButton(),
              ]
            ],
          ),
        );
      },
    );
  }

  Widget _buildSelectButton() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        elevation: 5,
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
      ),
      child: const Text(
        'Select',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
