import 'package:flutter/material.dart';
import 'package:travel_social_network/features/ticket/domain/entities/policy.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/enums/policy_type.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/long_text_field.dart';

class CreatePolicyBottomSheet extends StatefulWidget {
  final PolicyEntity? policy;
  final PolicyType policyType;

  const CreatePolicyBottomSheet({
    super.key,
    required this.policyType,
    this.policy,
  });

  @override
  State<CreatePolicyBottomSheet> createState() =>
      _CreatePolicyBottomSheetState();
}

class _CreatePolicyBottomSheetState extends State<CreatePolicyBottomSheet> {
  late final GlobalKey<FormState> _formKey;

  String? _policyName;
  String? _policyDesc;
  PolicyType? selectedType;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();

    _policyName = widget.policy?.policyName;
    _policyDesc = widget.policy?.policyDescription;
    selectedType = widget.policy?.policyType ?? widget.policyType;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      selectedType == PolicyType.refund
                          ? S.current.refundPolicy
                          : S.current.reschedulePolicy,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ),
            CustomTextField(
              validator: _policyNameValidator,
              label: S.current.policyName,
              textEditingController: TextEditingController(text: _policyName),
              onSaved: (value) => _policyName = value,
              hintTexts: const [
                'Easy to refund...',
                'Reschedule anytime...',
                '50% refund...',
                '...'
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
                onPressed: _acceptPolicy,
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

  void _acceptPolicy() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      Navigator.pop(
        context,
        PolicyEntity(
          policyId: 'TEMPLATE',
          policyName: _policyName!,
          policyDescription: _policyDesc!,
          isAllowed: true,
          policyType: widget.policyType,
        ),
      );
    }
  }
}
