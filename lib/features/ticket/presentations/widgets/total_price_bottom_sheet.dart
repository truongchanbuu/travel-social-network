// import 'package:flutter/material.dart';
//
// import '../../../../cores/utils/currency_util.dart';
// import 'total_price_widget.dart';
//
// class TotalPriceBottomSheet extends StatelessWidget {
//   final num totalPrice;
//   const TotalPriceBottomSheet({super.key, required this.totalPrice});
//
//   @override
//   Widget build(BuildContext context) {

//
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TotalPriceWidget(
//           totalPrice: totalPrice,
//           icon: Icons.keyboard_arrow_up,
//           canTap: false,
//         ),
//         Column(
//           children: purchasedTickets.map((ticket) {
//             return Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '${ticket['category']} (${ticket['quantity']}x)',
//                     style: textStyle,
//                   ),
//                   Text(
//                     CurrencyUtils.formatCurrency(
//                       ticket['price'] * ticket['quantity'],
//                     ),
//                     style: textStyle,
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
