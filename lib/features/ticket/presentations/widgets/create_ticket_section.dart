import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/enums/policy_type.dart';
import '../../../../cores/enums/ticket_category.dart';
import '../../../../cores/utils/formatters/number_input_formatter.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../policy/presentations/bloc/policy_bloc.dart';
import '../../../policy/presentations/pages/create_policy_page.dart';
import '../../../shared/widgets/app_progressing_indicator.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/long_text_field.dart';
import '../../domain/entities/ticket_type.dart';
import '../bloc/ticket_bloc.dart';

class CreateTicketSection extends StatefulWidget {
  final String tourId;
  final TicketTypeEntity? ticket;

  const CreateTicketSection({
    super.key,
    required this.tourId,
    this.ticket,
  });

  @override
  State<CreateTicketSection> createState() => CreateTicketSectionState();
}

class CreateTicketSectionState extends State<CreateTicketSection> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _quantityController;
  final CurrencyTextInputFormatter currencyFormatter =
      CurrencyTextInputFormatter.currency(
          maxValue: $1BMaxCurrency, minValue: $0Currency);
  List<DropdownMenuItem<TicketCategory>> items = [];
  late TicketTypeEntity ticket;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _quantityController = TextEditingController();
    items = TicketCategory.values
        .map(
          (category) => DropdownMenuItem(
            value: category,
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

    if (widget.ticket != null) {
      ticket = widget.ticket!;
      _initializeControllers();
    } else {
      context.read<TicketBloc>().add(InitialNewTicketEvent(widget.tourId));
    }
  }

  void _initializeControllers() {
    _nameController.text = ticket.ticketTypeName;
    _priceController.text =
        currencyFormatter.formatString(ticket.ticketPrice.toString());
    _quantityController.text = ticket.quantity.toString();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
  }

  static const SizedBox spacing = SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicketBloc, TicketState>(
      listener: (context, state) {
        if (state is TicketFailure) {
          showToast(state.message, context: context);
        }
      },
      builder: (context, state) {
        if (state is TicketActionLoading) {
          return const AppProgressingIndicator();
        }

        return _buildBody(state);
      },
    );
  }

  Widget _buildBody(TicketState state) {
    if (widget.ticket == null && state is! TicketLoaded) {
      return AppProgressingIndicator(text: S.current.loading);
    } else if (state is TicketLoaded) {
      ticket = state.ticket.toEntity();
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                label: S.current.ticketName,
                textEditingController: _nameController,
                isAnimated: false,
                hintTexts: [S.current.ticketName],
                onSaved: (value) => context
                    .read<TicketBloc>()
                    .add(UpdateTicketFieldEvent('ticketTypeName', value)),
                validator: (value) =>
                    _genericValidator(value, S.current.ticketName),
              ),
              spacing,
              _buildInfoGroup(ticket),
              spacing,
              CustomTextField(
                label: S.current.ticketCategory,
                isAnimated: false,
                replaceField: _buildTicketCategory(ticket),
              ),
              spacing,
              LongTextField(
                validator: (value) =>
                    _genericValidator(value, S.current.ticketDesc),
                title: S.current.ticketDesc,
                content: ticket.ticketDescription,
                onSaved: (value) => context
                    .read<TicketBloc>()
                    .add(UpdateTicketFieldEvent('ticketDescription', value)),
              ),
              spacing,
              LongTextField(
                validator: (value) =>
                    _genericValidator(value, S.current.ticketInfo),
                title: S.current.ticketInfo,
                content: ticket.ticketInfo,
                onSaved: (value) => context
                    .read<TicketBloc>()
                    .add(UpdateTicketFieldEvent('ticketInfo', value)),
              ),
              spacing,
              LongTextField(
                validator: (value) =>
                    _genericValidator(value, S.current.ticketRedemption),
                title: S.current.ticketRedemption,
                content: ticket.redemptionMethodDesc,
                onSaved: (value) => context
                    .read<TicketBloc>()
                    .add(UpdateTicketFieldEvent('redemptionMethodDesc', value)),
              ),
              spacing,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: S.current.refundPolicy,
                      readOnly: true,
                      hintTexts: [
                        ticket.refundPolicyId.isEmpty
                            ? S.current.refundPolicy
                            : ticket.refundPolicyId
                      ],
                      isAnimated: false,
                      onTap: () => _openPolicyPage(
                          PolicyType.refund, ticket.refundPolicyId),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      label: S.current.reschedulePolicy,
                      readOnly: true,
                      hintTexts: [
                        ticket.reschedulePolicyId.isEmpty
                            ? S.current.reschedule
                            : ticket.reschedulePolicyId
                      ],
                      isAnimated: false,
                      onTap: () => _openPolicyPage(
                          PolicyType.reschedule, ticket.reschedulePolicyId),
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

  Widget _buildInfoGroup(TicketTypeEntity ticket) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 2,
          child: CustomTextField(
            validator: _priceValidator,
            onSaved: (value) => context.read<TicketBloc>().add(
                UpdateTicketFieldEvent('ticketPrice', cleanNumberInput(value))),
            label: S.current.price,
            isAnimated: false,
            hintTexts: [
              currencyFormatter.formatString(ticket.ticketPrice.toString())
            ],
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              currencyFormatter
            ],
            keyboardType: TextInputType.number,
            textEditingController: _priceController,
          ),
        ),
        const SizedBox(width: defaultPadding),
        Expanded(
          child: CustomTextField(
            validator: _ticketQuantityValidator,
            label: S.current.quantity,
            isAnimated: false,
            hintTexts: [ticket.quantity.toString()],
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              NumberInputFormatter(numberFormat: NumberFormat.decimalPattern()),
              LengthLimitingTextInputFormatter(9),
            ],
            keyboardType: TextInputType.number,
            onSaved: (value) => context.read<TicketBloc>().add(
                UpdateTicketFieldEvent(
                    'quantity', cleanNumberInput(value).toInt())),
            textEditingController: _quantityController,
          ),
        ),
      ],
    );
  }

  Widget _buildTicketCategory(TicketTypeEntity ticket) {
    return DropdownButtonFormField<TicketCategory>(
      items: items,
      value: ticket.category,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderRadius: defaultFieldBorderRadius,
            borderSide: BorderSide(color: defaultFieldBorderColor, width: 1)),
      ),
      onChanged: (value) => context
          .read<TicketBloc>()
          .add(UpdateTicketFieldEvent('category', value ?? ticket.category)),
    );
  }

  void _openPolicyPage(PolicyType type, String policyId) async {
    final TicketBloc ticketBloc = context.read<TicketBloc>();

    var data = await Navigator.push(
      context,
      PageTransition(
        child: BlocProvider(
          create: (context) => getIt.get<PolicyBloc>(),
          child: CreatePolicyPage(policyType: type, policyId: policyId),
        ),
        duration: const Duration(milliseconds: 500),
        type: PageTransitionType.rightToLeft,
      ),
    );

    if (data is String && type == PolicyType.refund) {
      ticketBloc.add(UpdateTicketFieldEvent('refundPolicyId', data));
    } else if (data is String && type == PolicyType.reschedule) {
      ticketBloc.add(UpdateTicketFieldEvent('reschedulePolicyId', data));
    }
  }

  String? _genericValidator(String? value, String fieldName) {
    if ((value?.length ?? 0) < minLimitLength) {
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
      ticketTypeId: ticket.ticketTypeId,
      ticketTypeName: _nameController.text,
      tourId: ticket.tourId,
      ticketPrice: cleanNumberInput(_priceController.text),
      ticketDescription: ticket.ticketDescription,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      category: ticket.category,
      quantity: cleanNumberInput(_quantityController.text).toInt(),
      ticketInfo: ticket.ticketInfo,
      redemptionMethodDesc: ticket.redemptionMethodDesc,
      refundPolicyId: ticket.refundPolicyId,
      reschedulePolicyId: ticket.reschedulePolicyId,
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

  void deletePolicy() {
    if (ticket.refundPolicyId.isNotEmpty) {
      context.read<PolicyBloc>().add(DeletePolicyEvent(ticket.refundPolicyId));
    }

    if (ticket.reschedulePolicyId.isNotEmpty) {
      context
          .read<PolicyBloc>()
          .add(DeletePolicyEvent(ticket.reschedulePolicyId));
    }
  }
}
