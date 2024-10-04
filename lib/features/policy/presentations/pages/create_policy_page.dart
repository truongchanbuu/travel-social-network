import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/enums/policy_type.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/widgets/app_progressing_indicator.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/long_text_field.dart';
import '../../data/models/policy.dart';
import '../../domain/entities/policy.dart';
import '../bloc/policy_bloc.dart';

class CreatePolicyPage extends StatefulWidget {
  final String? policyId;
  final PolicyType policyType;

  const CreatePolicyPage({
    super.key,
    required this.policyType,
    this.policyId,
  });

  @override
  State<CreatePolicyPage> createState() => _CreatePolicyPageState();
}

class _CreatePolicyPageState extends State<CreatePolicyPage> {
  late final GlobalKey<FormState> _formKey;
  late Map<String, bool> policyLabels;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();

    if (widget.policyId?.isNotEmpty ?? false) {
      context.read<PolicyBloc>().add(GetPolicyById(widget.policyId!));
    } else {
      context.read<PolicyBloc>().add(InitializeNewPolicy(widget.policyType));
    }

    policyLabels = {
      S.current.easyToRefund: true,
      S.current.easyToReschedule: true,
      S.current.cannotBeRescheduled: false,
      S.current.nonRefundable: false,
    };
    policyLabels = {
      for (var entry in policyLabels.entries.where(
        (entry) => entry.key.toLowerCase().contains(
              widget.policyType == PolicyType.refund
                  ? S.current.refund.toLowerCase()
                  : S.current.reschedule.toLowerCase(),
            ),
      ))
        entry.key: entry.value
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PolicyBloc, PolicyState>(
      listener: (context, state) {
        if (state is PolicyActionSuccess) {
          showToast(S.current.success, context: context);
          Navigator.pop(context, state.policy.policyId);
        } else if (state is PolicyFailure) {
          showToast(state.message, context: context);
        }
      },
      builder: (context, state) {
        if (state is PolicyActionLoading) {
          return const AppProgressingIndicator();
        }

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(onPressed: _confirmedToLeave),
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Text(
                widget.policyType == PolicyType.refund
                    ? S.current.refundPolicy
                    : S.current.reschedulePolicy,
              ),
            ),
            body: _buildBody(state),
          ),
        );
      },
    );
  }

  Widget _buildBody(PolicyState state) {
    if (state is! PolicyLoaded) {
      return const AppProgressingIndicator();
    }

    final PolicyEntity policy = state.policy.toEntity();

    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              validator: _policyNameValidator,
              label: S.current.policyName,
              replaceField: _buildDropdownButton(policy),
            ),
            const SizedBox(height: 10),
            LongTextField(
              title: S.current.policyDesc,
              content: policy.policyDescription,
              onSaved: (value) => context
                  .read<PolicyBloc>()
                  .add(UpdatePolicyDescription(value ?? '')),
              validator: _policyDescValidator,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _acceptPolicy(context, policy),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: defaultFieldBorderRadius),
                minimumSize: const Size.fromHeight(55),
              ),
              child: Text(
                S.current.accept,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  DropdownButtonFormField _buildDropdownButton(PolicyEntity policy) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      items: policyLabels.entries
          .map((data) => DropdownMenuItem(
                value: data.key,
                child: Text(data.key),
              ))
          .toList(),
      value: policy.policyName.isEmpty
          ? policyLabels.keys.first
          : policy.policyName,
      validator: _policyNameValidator,
      onChanged: (value) {
        if (value != null) {
          context.read<PolicyBloc>().add(UpdatePolicyName(value));
          context
              .read<PolicyBloc>()
              .add(UpdatePolicyAllowed(policyLabels[value] ?? false));
        }
      },
    );
  }

  String? _policyNameValidator(String? name) {
    if (name?.isEmpty ?? true) {
      return S.current.notAllowedEmpty;
    }

    return null;
  }

  String? _policyDescValidator(String? desc) {
    if ((desc?.length ?? 0) < minLimitLength) {
      return S.current.lengthLimitError(S.current.policyDesc);
    }
    return null;
  }

  void _acceptPolicy(BuildContext context, PolicyEntity policy) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      context
          .read<PolicyBloc>()
          .add(CreatePolicyEvent(Policy.fromEntity(policy)));
    }
  }

  void _confirmedToLeave() {
    showDialog(context: context, builder: (context) => const ConfirmDialog());
  }
}
