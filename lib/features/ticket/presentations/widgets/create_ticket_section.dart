import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/enums/ticket_category.dart';
import '../../../../cores/utils/formatters/number_input_formatter.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/long_text_field.dart';

class CreateTicketSection extends StatefulWidget {
  const CreateTicketSection({super.key});

  @override
  State<CreateTicketSection> createState() => _CreateTicketSectionState();
}

class _CreateTicketSectionState extends State<CreateTicketSection> {
  List<DropdownMenuItem> items = List.empty(growable: true);
  String? _ticketCategory;
  String _quantity = '1';

  @override
  void initState() {
    super.initState();
    items = TicketCategory.values
        .map(
          (category) => DropdownMenuItem(
            value: category.name,
            child: Text(
              category.name.replaceAll('_', ' ').toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 15,
              ),
            ),
          ),
        )
        .toList();
    _ticketCategory = TicketCategory.standard.name;
  }

  static const SizedBox spacing = SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          CustomTextField(label: S.current.ticketName),
          spacing,
          _buildInfoGroup(),
          spacing,
          CustomTextField(
            label: S.current.ticketCategory,
            replaceField: _buildTicketCategory(),
          ),
          spacing,
          LongTextField(
            title: S.current.ticketDesc,
            onSaved: (value) {},
          ),
          spacing,
          LongTextField(
            title: S.current.ticketInfo,
            onSaved: (value) {},
          ),
          spacing,
          LongTextField(
            title: S.current.ticketRedemption,
            onSaved: (value) {},
          )
        ],
      ),
    );
  }

  Widget _buildInfoGroup() {
    final CurrencyTextInputFormatter formatter =
        CurrencyTextInputFormatter.currency(maxValue: 1000000000, minValue: 0);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 2,
          child: CustomTextField(
            label: S.current.price,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              formatter
            ],
            keyboardType: TextInputType.number,
            textEditingController:
                TextEditingController(text: formatter.formatString('0')),
          ),
        ),
        const SizedBox(width: defaultPadding),
        Expanded(
          child: CustomTextField(
            label: S.current.quantity,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              NumberInputFormatter(numberFormat: NumberFormat.decimalPattern()),
              LengthLimitingTextInputFormatter(9),
            ],
            keyboardType: TextInputType.number,
            singleHintText: _quantity,
          ),
        ),
      ],
    );
  }

  Widget _buildTicketCategory() {
    return DropdownButtonFormField(
      items: items,
      value: _ticketCategory,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderRadius: defaultFieldBorderRadius,
            borderSide: BorderSide(color: defaultFieldBorderColor, width: 1)),
      ),
      onChanged: (value) => _ticketCategory = value,
    );
  }
}
