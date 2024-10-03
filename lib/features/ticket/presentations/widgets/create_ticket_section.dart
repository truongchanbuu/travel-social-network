import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/enums/policy_type.dart';
import '../../../../cores/enums/ticket_category.dart';
import '../../../../cores/utils/enum_utils.dart';
import '../../../../cores/utils/formatters/number_input_formatter.dart';
import '../../../../generated/l10n.dart';
import '../../../policy/presentations/pages/create_policy_page.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/long_text_field.dart';
import '../../domain/entities/ticket_type.dart';

class CreateTicketSection extends StatefulWidget {
  final TicketTypeEntity? ticket;
  const CreateTicketSection({super.key, this.ticket});

  @override
  State<CreateTicketSection> createState() => CreateTicketSectionState();
}

class CreateTicketSectionState extends State<CreateTicketSection> {
  late final GlobalKey<FormState> _formKey;

  List<DropdownMenuItem> items = List.empty(growable: true);

  String? _ticketName;
  String? _ticketDesc;
  String? _ticketInfo;
  String? _ticketRedemption;
  String? _ticketCategory;
  String? _refundPolicyId;
  String? _reschedulePolicyId;
  int _quantity = 0;
  num _price = 0;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
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

    _ticketName = widget.ticket?.ticketTypeName;
    _ticketDesc = widget.ticket?.ticketDescription;
    _ticketInfo = widget.ticket?.ticketInfo;
    _ticketRedemption = widget.ticket?.redemptionMethodDesc;
    _ticketCategory =
        widget.ticket?.category.name ?? TicketCategory.standard.name;
    _quantity = widget.ticket?.quantity ?? _quantity;
    _price = widget.ticket?.ticketPrice ?? _price;
    _refundPolicyId = widget.ticket?.refundPolicyId;
    _reschedulePolicyId = widget.ticket?.reschedulePolicyId;
  }

  static const SizedBox spacing = SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                label: S.current.ticketName,
                textEditingController: TextEditingController(text: _ticketName),
                isAnimated: false,
                hintTexts: [S.current.ticketName],
                onSaved: (value) => _ticketName = value,
                onChanged: (value) => _ticketName = value,
                validator: (value) =>
                    _genericValidator(value, S.current.ticketName),
              ),
              spacing,
              _buildInfoGroup(),
              spacing,
              CustomTextField(
                label: S.current.ticketCategory,
                isAnimated: false,
                replaceField: _buildTicketCategory(),
              ),
              spacing,
              LongTextField(
                validator: (value) =>
                    _genericValidator(value, S.current.ticketDesc),
                title: S.current.ticketDesc,
                content: _ticketDesc,
                onSaved: (value) => _ticketDesc = value,
              ),
              spacing,
              LongTextField(
                validator: (value) =>
                    _genericValidator(value, S.current.ticketInfo),
                title: S.current.ticketInfo,
                content: _ticketInfo,
                onSaved: (value) => _ticketInfo = value,
              ),
              spacing,
              LongTextField(
                validator: (value) =>
                    _genericValidator(value, S.current.ticketRedemption),
                title: S.current.ticketRedemption,
                content: _ticketRedemption,
                onSaved: (value) => _ticketRedemption = value,
              ),
              spacing,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: S.current.refundPolicy,
                      readOnly: true,
                      hintTexts: [_refundPolicyId ?? S.current.refundPolicy],
                      isAnimated: false,
                      onTap: () => _openPolicyPage(PolicyType.refund),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      label: S.current.reschedulePolicy,
                      readOnly: true,
                      hintTexts: [
                        _reschedulePolicyId ?? S.current.reschedulePolicy
                      ],
                      isAnimated: false,
                      onTap: () => _openPolicyPage(PolicyType.reschedule),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
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
            validator: _priceValidator,
            onSaved: (value) => _price = cleanNumberInput(value),
            onChanged: (value) => _price = cleanNumberInput(value),
            label: S.current.price,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              formatter
            ],
            keyboardType: TextInputType.number,
            textEditingController: TextEditingController(
                text: formatter.formatString(_price.toString())),
          ),
        ),
        const SizedBox(width: defaultPadding),
        Expanded(
          child: CustomTextField(
            validator: _ticketQuantityValidator,
            label: S.current.quantity,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              NumberInputFormatter(numberFormat: NumberFormat.decimalPattern()),
              LengthLimitingTextInputFormatter(9),
            ],
            keyboardType: TextInputType.number,
            onSaved: (value) => _quantity = cleanNumberInput(value).toInt(),
            onChanged: (value) => _quantity = cleanNumberInput(value).toInt(),
            textEditingController: TextEditingController(text: '$_quantity'),
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

  void _openPolicyPage(PolicyType type) async {
    var data = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreatePolicyPage(policyType: type),
        ));

    if (data is String && type == PolicyType.refund) {
      _refundPolicyId = data;
    } else if (data is String && type == PolicyType.reschedule) {
      _reschedulePolicyId = data;
    }
  }

  String? _genericValidator(String? value, String fieldName) {
    if ((value?.length ?? 0) < 10) {
      return S.current.lengthLimitError(fieldName);
    }
    return null;
  }

  String? _ticketQuantityValidator(String? quantity) {
    if (quantity?.isEmpty ?? true) {
      return S.current.notAllowedEmpty;
    }

    int quantityNum = cleanNumberInput(quantity).toInt();

    if (quantityNum == 0) {
      return S.current.notAllowedEmpty;
    }

    return null;
  }

  String? _priceValidator(String? price) {
    num priceNum = cleanNumberInput(price);

    if (priceNum <= 0) {
      return S.current.notAllowedEmpty;
    }

    return null;
  }

  num cleanNumberInput(String? value) {
    final cleanedInput = value?.replaceAll(RegExp(r'[^\d.]'), '');
    return (cleanedInput?.isNotEmpty ?? false) ? num.parse(cleanedInput!) : 0.0;
  }

  TicketTypeEntity getData() {
    return TicketTypeEntity(
      ticketTypeId: '',
      ticketTypeName: _ticketName!,
      tourId: '',
      ticketPrice: _price,
      ticketDescription: _ticketDesc!,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      category: stringToEnum(_ticketCategory!, TicketCategory.values),
      quantity: _quantity,
      ticketInfo: _ticketInfo!,
      redemptionMethodDesc: _ticketRedemption!,
      refundPolicyId: '',
      reschedulePolicyId: '',
      createdAt: DateTime.now(),
    );
  }

  bool validateForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      return true;
    }

    return false;
  }
}
