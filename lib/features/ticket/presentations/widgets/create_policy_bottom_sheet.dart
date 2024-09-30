import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/enums/policy_type.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/long_text_field.dart';

class CreatePolicyBottomSheet extends StatefulWidget {
  final PolicyType policyType;

  const CreatePolicyBottomSheet({
    super.key,
    required this.policyType,
  });

  @override
  State<CreatePolicyBottomSheet> createState() =>
      _CreatePolicyBottomSheetState();
}

class _CreatePolicyBottomSheetState extends State<CreatePolicyBottomSheet> {
  PolicyType? selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = widget.policyType;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
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
          CustomTextField(
            label: S.current.policyName,
            hintTexts: const [
              'Easy to refund...',
              'Reschedule anytime...',
              '...'
            ],
          ),
          const SizedBox(height: 10),
          LongTextField(title: S.current.policyDesc),
        ],
      ),
    );
  }
}
