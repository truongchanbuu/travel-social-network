import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/enums/policy_type.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/widgets/custom_text_field.dart';
import 'create_policy_bottom_sheet.dart';

class CreatePolicySection extends StatefulWidget {
  const CreatePolicySection({super.key});

  @override
  State<CreatePolicySection> createState() => _CreatePolicySectionState();
}

class _CreatePolicySectionState extends State<CreatePolicySection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Row(
          children: [
            Expanded(
              child: CustomTextField(
                onTap: () => _createPolicy(PolicyType.refund),
                label: S.current.refundPolicy,
                singleHintText: S.current.refundPolicy,
              ),
            ),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: CustomTextField(
                label: S.current.reschedulePolicy,
                singleHintText: S.current.reschedulePolicy,
              ),
            ),
          ],
        ));
  }

  void _createPolicy(PolicyType type) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      shape: bottomSheetShape,
      builder: (context) => CreatePolicyBottomSheet(policyType: type),
    );
  }
}
