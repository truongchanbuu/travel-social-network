import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

import '../../../../cores/utils/extensions/string_extension.dart';
import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/currency_helper.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/ticket.dart';

class TotalPriceWidget extends StatefulWidget {
  final List<TicketEntity> tickets;
  final num totalPrice;
  final bool canTap;

  const TotalPriceWidget({
    super.key,
    required this.totalPrice,
    this.canTap = true,
    required this.tickets,
  });

  @override
  State<TotalPriceWidget> createState() => _TotalPriceWidgetState();
}

class _TotalPriceWidgetState extends State<TotalPriceWidget> {
  bool _isPopUp = false;

  @override
  void initState() {
    super.initState();
    _isPopUp = !widget.canTap;
  }

  static const TextStyle _textStyle = TextStyle(
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
        title: Text(
          S.current.totalPrice,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          S.current.paymentInfo,
          style: const TextStyle(
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
                CurrencyHelper.formatCurrency(widget.totalPrice),
                style: const TextStyle(
                  color: AppTheme.currencyTextColor,
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
          children: widget.tickets.map((ticket) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${ticket.category.name.toUpperCaseFirstLetter} (${ticket.quantity}x)',
                    style: _textStyle,
                  ),
                  Text(
                    CurrencyHelper.formatCurrency(
                      ticket.ticketPrice * ticket.quantity,
                    ),
                    style: _textStyle,
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
            backgroundColor: AppTheme.primaryColor,
            minimumSize: minBtnSize,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          child: Text(
            S.current.bookingNow,
            style: const TextStyle(
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
      shape: bottomSheetShape,
      context: context,
      builder: (context) => TotalPriceWidget(
        totalPrice: widget.totalPrice,
        canTap: false,
        tickets: widget.tickets,
      ),
    );
  }
}
