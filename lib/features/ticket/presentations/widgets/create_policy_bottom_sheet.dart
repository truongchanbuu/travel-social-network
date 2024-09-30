import 'package:flutter/material.dart';

import '../../../../cores/enums/policy_type.dart';
import '../../../shared/widgets/custom_text_field.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(''),
        CustomTextField(label: ''),
      ],
    );
  }
}
