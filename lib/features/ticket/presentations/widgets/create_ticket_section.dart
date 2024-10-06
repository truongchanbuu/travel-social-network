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
  late final TextEditingController _refundController;
  late final TextEditingController _rescheduleController;
  final CurrencyTextInputFormatter currencyFormatter =
      CurrencyTextInputFormatter.currency(
          maxValue: $1BMaxCurrency, minValue: $0Currency);

  List<DropdownMenuItem<String>> items = [];
  late TicketTypeEntity ticket;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _quantityController = TextEditingController();
    _refundController = TextEditingController();
    _rescheduleController = TextEditingController();

    items = _generateDropdownItem();

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
    _quantityController.text =
        NumberFormat.decimalPattern().format(ticket.quantity);
    _refundController.text = ticket.refundPolicyId;
    _rescheduleController.text = ticket.reschedulePolicyId;
  }

  List<DropdownMenuItem<String>> _generateDropdownItem() {
    return TicketCategory.values
        .map(
          (category) => DropdownMenuItem<String>(
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
      _initializeControllers();
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
                onSaved: (value) => _genericOnSaved(
                    TicketTypeEntity.ticketInfoFieldName, value),
                onChanged: (value) => _genericOnSaved(
                    TicketTypeEntity.ticketTypeNameFieldName, value),
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
                onSaved: (value) => _genericOnSaved(
                    TicketTypeEntity.ticketDescriptionFieldName, value),
              ),
              spacing,
              LongTextField(
                validator: (value) =>
                    _genericValidator(value, S.current.ticketInfo),
                title: S.current.ticketInfo,
                content: ticket.ticketInfo,
                onSaved: (value) => _genericOnSaved(
                    TicketTypeEntity.ticketInfoFieldName, value),
              ),
              spacing,
              LongTextField(
                validator: (value) =>
                    _genericValidator(value, S.current.ticketRedemption),
                title: S.current.ticketRedemption,
                content: ticket.redemptionMethodDesc,
                onSaved: (value) => _genericOnSaved(
                    TicketTypeEntity.redemptionMethodDescFieldName, value),
              ),
              spacing,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      textEditingController: _refundController,
                      validator: (value) =>
                          _genericValidator(value, S.current.refundPolicy),
                      label: S.current.refundPolicy,
                      readOnly: true,
                      hintTexts: [
                        ticket.refundPolicyId.isEmpty
                            ? S.current.refundPolicy
                            : ticket.refundPolicyId
                      ],
                      isAnimated: false,
                      onSaved: (value) => _genericOnSaved(
                          TicketTypeEntity.refundPolicyIdFieldName, value),
                      onTap: () => _openPolicyPage(
                          PolicyType.refund, ticket.refundPolicyId),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      textEditingController: _rescheduleController,
                      validator: (value) =>
                          _genericValidator(value, S.current.reschedulePolicy),
                      label: S.current.reschedulePolicy,
                      readOnly: true,
                      hintTexts: [
                        ticket.reschedulePolicyId.isEmpty
                            ? S.current.reschedulePolicy
                            : ticket.reschedulePolicyId
                      ],
                      isAnimated: false,
                      onSaved: (value) => _genericOnSaved(
                          TicketTypeEntity.reschedulePolicyIdFieldName, value),
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
            onSaved: (value) => _genericOnSaved(
                TicketTypeEntity.ticketPriceFieldName,
                currencyFormatter.getDouble().toString()),
            onChanged: (value) => _genericOnSaved(
                TicketTypeEntity.ticketPriceFieldName,
                currencyFormatter.getDouble().toString()),
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
            onSaved: (value) => _genericOnSaved(
                TicketTypeEntity.quantityFieldName,
                NumberFormat.decimalPattern().parse(value!).toString()),
            onChanged: (value) {
              _genericOnSaved(TicketTypeEntity.quantityFieldName,
                  NumberFormat.decimalPattern().parse(value).toString());
            },
            textEditingController: _quantityController,
          ),
        ),
      ],
    );
  }

  Widget _buildTicketCategory(TicketTypeEntity ticket) {
    return DropdownButtonFormField<String>(
      items: items,
      value: ticket.category.name,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderRadius: defaultFieldBorderRadius,
            borderSide: BorderSide(color: defaultFieldBorderColor, width: 1)),
      ),
      onChanged: (value) =>
          _genericOnSaved(TicketTypeEntity.categoryFieldName, value),
    );
  }

  String? _genericValidator(String? value, String fieldName) {
    if ((value?.length ?? 0) < minLimitLength) {
      return S.current.lengthLimitError(fieldName);
    }

    return null;
  }

  void _genericOnSaved(String fieldName, String? value) {
    final TicketBloc ticketBloc = context.read<TicketBloc>();

    if (value?.isNotEmpty ?? false) {
      num? number = num.tryParse(value!);

      if (number != null && number != 0) {
        ticketBloc.add(UpdateTicketFieldEvent(fieldName, number));
      } else if (number == null) {
        ticketBloc.add(UpdateTicketFieldEvent(fieldName, value));
      }
    }
  }

  String? _ticketQuantityValidator(String? quantity) {
    if (quantity?.isEmpty ?? true) {
      return S.current.notAllowedEmpty;
    }

    int quantityNum = NumberFormat.decimalPattern().parse(quantity!).toInt();
    if (quantityNum == 0) {
      return S.current.notAllowedEmpty;
    }

    return null;
  }

  String? _priceValidator(String? price) {
    num priceNum = currencyFormatter.getDouble();

    if (priceNum <= 0) {
      return S.current.notAllowedEmpty;
    }

    return null;
  }

  void _openPolicyPage(PolicyType type, String policyId) async {
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
      _genericOnSaved(TicketTypeEntity.refundPolicyIdFieldName, data);
    } else if (data is String && type == PolicyType.reschedule) {
      _genericOnSaved(TicketTypeEntity.reschedulePolicyIdFieldName, data);
    }
  }

  TicketTypeEntity getData() {
    return TicketTypeEntity(
      ticketTypeId: ticket.ticketTypeId,
      ticketTypeName: _nameController.text,
      tourId: ticket.tourId,
      ticketPrice: currencyFormatter.getUnformattedValue(),
      ticketDescription: ticket.ticketDescription,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      category: ticket.category,
      quantity:
          NumberFormat.decimalPattern().parse(_quantityController.text).toInt(),
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
