import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/enums/policy_type.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../domain/entities/policy.dart';
import 'create_policy_bottom_sheet.dart';

class CreatePolicySection extends StatefulWidget {
  final PolicyEntity refundPolicy;
  final PolicyEntity reschedulePolicy;
  final void Function(PolicyEntity refundPolicy, PolicyEntity reschedulePolicy)
      onSaved;

  const CreatePolicySection({
    super.key,
    required this.refundPolicy,
    required this.reschedulePolicy,
    required this.onSaved,
  });

  @override
  State<CreatePolicySection> createState() => _CreatePolicySectionState();
}

class _CreatePolicySectionState extends State<CreatePolicySection> {
  late PolicyEntity refundPolicy;
  late PolicyEntity reschedulePolicy;

  @override
  void initState() {
    super.initState();
    refundPolicy = widget.refundPolicy;
    reschedulePolicy = widget.reschedulePolicy;
  }

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
                textEditingController:
                    TextEditingController(text: refundPolicy.policyName),
              ),
            ),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: CustomTextField(
                onTap: () => _createPolicy(PolicyType.reschedule),
                label: S.current.reschedulePolicy,
                singleHintText: S.current.reschedulePolicy,
                textEditingController:
                    TextEditingController(text: reschedulePolicy.policyName),
              ),
            ),
          ],
        ));
  }

  void _createPolicy(PolicyType type) async {
    var data = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: bottomSheetShape,
      builder: (context) => CreatePolicyBottomSheet(
        policyType: type,
        policy: type == PolicyType.refund ? refundPolicy : reschedulePolicy,
      ),
    );

    if (data is PolicyEntity) {
      if (data.policyType == PolicyType.refund) {
        refundPolicy = refundPolicy.copyWith(
          policyName: data.policyName,
          policyDescription: data.policyDescription,
          isAllowed: data.isAllowed,
        );
      } else {
        reschedulePolicy = reschedulePolicy.copyWith(
          policyName: data.policyName,
          policyDescription: data.policyDescription,
          isAllowed: data.isAllowed,
        );
      }

      setState(() {});
      widget.onSaved(refundPolicy, reschedulePolicy);
    }
  }
}
