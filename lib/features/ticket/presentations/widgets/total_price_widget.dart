import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/currency_util.dart';

class TotalPriceWidget extends StatefulWidget {
  final num totalPrice;
  final bool canTap;

  const TotalPriceWidget({
    super.key,
    required this.totalPrice,
    this.canTap = true,
  });

  @override
  State<TotalPriceWidget> createState() => _TotalPriceWidgetState();
}

class _TotalPriceWidgetState extends State<TotalPriceWidget> {
  bool _isPopUp = false;
  final List<Map<String, dynamic>> purchasedTickets = [
    {'category': 'Adult', 'quantity': 1, 'price': 50.00},
    {'category': 'Child', 'quantity': 2, 'price': 30.00},
    {'category': 'VIP', 'quantity': 1, 'price': 100.00},
    {'category': 'FREE', 'quantity': 10, 'price': 100.00},
  ];

  @override
  void initState() {
    super.initState();
    _isPopUp = !widget.canTap;
  }

  static const TextStyle textStyle = TextStyle(
    color: Colors.grey,
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTotalPrice(),
        if (_isPopUp) ...[
          _buildSelectedTicketDetailList(),
          const SizedBox(height: 10),
        ],
        _buildBookingButton(),
      ],
    );
  }

  Widget _buildTotalPrice() => ListTile(
        onTap: widget.canTap ? () => _showTotalPriceBottomSheet(context) : null,
        titleAlignment: ListTileTitleAlignment.center,
        title: const Text(
          'Total Price',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        subtitle: const Text(
          'Inclusive of taxes and fees',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                CurrencyUtils.formatCurrency(widget.totalPrice),
                style: const TextStyle(
                  color: currencyTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              _isPopUp
                  ? const Icon(Icons.keyboard_arrow_down, color: Colors.grey)
                  : const Icon(Icons.keyboard_arrow_up, color: Colors.grey),
            ],
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 15),
      );

  Widget _buildSelectedTicketDetailList() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: purchasedTickets.map((ticket) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${ticket['category']} (${ticket['quantity']}x)',
                    style: textStyle,
                  ),
                  Text(
                    CurrencyUtils.formatCurrency(
                      ticket['price'] * ticket['quantity'],
                    ),
                    style: textStyle,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );

  Widget _buildBookingButton() => Container(
        width: MediaQuery.of(context).size.width - (defaultPadding + 5) * 2,
        padding: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
          border: DashedBorder(
            dashLength: dashLength,
            top: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            minimumSize: const Size.fromHeight(60),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          child: const Text(
            'Booking Now',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      );

  void _showTotalPriceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      shape: const LinearBorder(),
      context: context,
      builder: (context) =>
          TotalPriceWidget(totalPrice: widget.totalPrice, canTap: false),
    );
  }
}
