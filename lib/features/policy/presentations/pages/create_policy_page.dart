import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:uuid/uuid.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/enums/policy_type.dart';
import '../../../../generated/l10n.dart';
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
  PolicyEntity? _policy;

  bool _isAllowed = false;
  String? _policyName;
  String? _policyDesc;
  late PolicyType selectedType;

  @override
  void initState() {
    super.initState();
    if (widget.policyId != null) {
      context.read<PolicyBloc>().add(GetPolicyById(widget.policyId!));
    }
    selectedType = widget.policyType;
    _formKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PolicyBloc, PolicyState>(
      builder: (context, state) {
        if (state is PolicyGetSuccess) {
          _policy = state.policy.toEntity();
          selectedType = _policy!.policyType;
          _policyName = _policy!.policyName;
          _policyDesc = _policy!.policyDescription;
          _isAllowed = _policy!.isAllowed;
        }

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Text(
                selectedType == PolicyType.refund
                    ? S.current.refundPolicy
                    : S.current.reschedulePolicy,
              ),
            ),
            body: _buildBody(),
          ),
        );
      },
      listener: (context, state) {
        if (state is PolicyCreateSuccess) {
          showToast(S.current.success, context: context);
          Navigator.pop(context, state.policy.policyId);
        } else if (state is PolicyFailure) {
          showToast(state.message, context: context);
        }
      },
    );
  }

  Widget _buildBody() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CustomTextField(
                    validator: _policyNameValidator,
                    label: S.current.policyName,
                    textEditingController:
                        TextEditingController(text: _policyName),
                    onSaved: (value) => _policyName = value,
                    onChanged: (value) => _policyName = value,
                    hintTexts: const [
                      'Easy to refund...',
                      'Reschedule anytime...',
                      '50% refund...',
                      '...'
                    ],
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                      value: _isAllowed,
                      title: Text(S.current.isAllow),
                      onChanged: (value) =>
                          setState(() => _isAllowed = value ?? _isAllowed)),
                )
              ],
            ),
            const SizedBox(height: 10),
            LongTextField(
              title: S.current.policyDesc,
              content: _policyDesc,
              onSaved: (value) => _policyDesc = value,
              validator: _policyDescValidator,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => _acceptPolicy(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: defaultFieldBorderRadius,
                  ),
                  minimumSize: const Size.fromHeight(55),
                ),
                child: Text(
                  S.current.accept,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  String? _policyNameValidator(String? name) {
    if ((name?.length ?? 0) < 10) {
      return S.current.lengthLimitError(S.current.policyName);
    }

    return null;
  }

  String? _policyDescValidator(String? desc) {
    if ((desc?.length ?? 0) < 10) {
      return S.current.lengthLimitError(S.current.policyDesc);
    }

    return null;
  }

  void _acceptPolicy(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<PolicyBloc>().add(CreatePolicyEvent(
            Policy.fromEntity(
              PolicyEntity(
                policyId: 'POLICY-${const Uuid().v4()}',
                policyName: _policyName!,
                policyDescription: _policyDesc!,
                isAllowed: _isAllowed,
                policyType: widget.policyType,
              ),
            ),
          ));
    }
  }
}
