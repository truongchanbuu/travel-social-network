import 'package:travel_social_network/cores/enums/policy_type.dart';
import 'package:travel_social_network/features/ticket/domain/entities/policy.dart';

List<PolicyEntity> refundPolicies = const [
  PolicyEntity(
    policyId: "RF-1",
    policyName: "Full Refund within 24 Hours",
    policyDescription:
        "Customers can receive a full refund if the cancellation is made within 24 hours of booking.",
    isAllowed: true,
    policyType: PolicyType.refund,
  ),
  PolicyEntity(
    policyId: "RF-2",
    policyName: "50% Refund within 3 Days",
    policyDescription:
        "50% of the total payment will be refunded if the cancellation is made within 3 days before the tour.",
    isAllowed: true,
    policyType: PolicyType.refund,
  ),
  PolicyEntity(
    policyId: "RF-3",
    policyName: "No Refund after Booking",
    policyDescription:
        "No refunds are available once the booking has been confirmed.",
    isAllowed: false,
    policyType: PolicyType.refund,
  ),
  PolicyEntity(
    policyId: "RF-4",
    policyName: "Partial Refund 7 Days Before Tour",
    policyDescription:
        "A partial refund of 30% is allowed if the cancellation is made 7 days prior to the tour start date.",
    isAllowed: true,
    policyType: PolicyType.refund,
  ),
  PolicyEntity(
    policyId: "RF-5",
    policyName: "Full Refund within 48 Hours",
    policyDescription:
        "Customers are entitled to a full refund if they cancel within 48 hours of booking.",
    isAllowed: true,
    policyType: PolicyType.refund,
  ),
  PolicyEntity(
    policyId: "RF-6",
    policyName: "No Refund within 24 Hours of Tour",
    policyDescription:
        "Refunds are not allowed if the cancellation is made less than 24 hours before the tour.",
    isAllowed: false,
    policyType: PolicyType.refund,
  ),
  PolicyEntity(
    policyId: "RF-7",
    policyName: "80% Refund within 2 Days",
    policyDescription:
        "80% of the payment will be refunded if the cancellation is made 2 days before the tour.",
    isAllowed: true,
    policyType: PolicyType.refund,
  ),
  PolicyEntity(
    policyId: "RF-8",
    policyName: "Full Refund on Medical Grounds",
    policyDescription:
        "A full refund will be granted if the cancellation is due to medical reasons and proper documentation is provided.",
    isAllowed: true,
    policyType: PolicyType.refund,
  ),
  PolicyEntity(
    policyId: "RF-9",
    policyName: "Flexible Refund for Emergencies",
    policyDescription:
        "Refunds are allowed for emergencies, subject to the approval of the tour management.",
    isAllowed: true,
    policyType: PolicyType.refund,
  ),
  PolicyEntity(
    policyId: "RF-10",
    policyName: "No Refund for Promotional Offers",
    policyDescription:
        "Refunds are not allowed for bookings made under promotional or discounted offers.",
    isAllowed: false,
    policyType: PolicyType.refund,
  ),
];

List<PolicyEntity> reschedulePolicies = const [
  PolicyEntity(
      policyId: "RS-1",
      policyName: "Reschedule up to 48 Hours Before Tour",
      policyDescription:
          "Customers can reschedule their tour up to 48 hours before the scheduled departure.",
      isAllowed: true,
      policyType: PolicyType.reschedule),
  PolicyEntity(
      policyId: "RS-2",
      policyName: "No Reschedule within 24 Hours",
      policyDescription:
          "Rescheduling is not allowed if the request is made within 24 hours of the tour.",
      isAllowed: false,
      policyType: PolicyType.reschedule),
  PolicyEntity(
      policyId: "RS-3",
      policyName: "One-Time Free Reschedule",
      policyDescription:
          "Customers are entitled to one free reschedule if requested 7 days before the tour date.",
      isAllowed: true,
      policyType: PolicyType.reschedule),
  PolicyEntity(
      policyId: "RS-4",
      policyName: "Reschedule at 20% Fee",
      policyDescription:
          "Customers can reschedule at a 20% fee of the total booking amount if the request is made within 48 hours of the tour.",
      isAllowed: true,
      policyType: PolicyType.reschedule),
  PolicyEntity(
      policyId: "RS-5",
      policyName: "No Reschedule for Group Tours",
      policyDescription: "Group tours cannot be rescheduled once booked.",
      isAllowed: false,
      policyType: PolicyType.reschedule),
  PolicyEntity(
      policyId: "RS-6",
      policyName: "Flexible Reschedule within 7 Days",
      policyDescription:
          "Rescheduling is allowed up to 7 days before the tour with no additional fees.",
      isAllowed: true,
      policyType: PolicyType.reschedule),
  PolicyEntity(
      policyId: "RS-7",
      policyName: "Emergency Reschedule Only",
      policyDescription:
          "Reschedules are allowed only in cases of emergencies with valid proof.",
      isAllowed: true,
      policyType: PolicyType.reschedule),
  PolicyEntity(
      policyId: "RS-8",
      policyName: "Reschedule at Additional 10% Cost",
      policyDescription:
          "Customers can reschedule their tour for an additional 10% of the booking cost.",
      isAllowed: true,
      policyType: PolicyType.reschedule),
  PolicyEntity(
      policyId: "RS-9",
      policyName: "Free Reschedule for VIP Members",
      policyDescription:
          "VIP members can reschedule their tour for free up to 48 hours before the tour.",
      isAllowed: true,
      policyType: PolicyType.reschedule),
  PolicyEntity(
      policyId: "RS-10",
      policyName: "No Reschedule for Last-Minute Bookings",
      policyDescription:
          "Reschedules are not allowed for last-minute bookings made within 24 hours of the tour.",
      isAllowed: false,
      policyType: PolicyType.reschedule),
];
