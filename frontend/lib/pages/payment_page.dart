// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:frontend/config.dart';
// import 'package:frontend/models/cart.dart';
// import 'package:frontend/providers.dart';
// import 'package:snippet_coder_utils/FormHelper.dart';
// import 'package:snippet_coder_utils/ProgressHUD.dart';

// class PaymentPage extends ConsumerStatefulWidget {
//   const PaymentPage({super.key});

//   @override
//   PaymentPageState createState() => PaymentPageState();
// }

// class PaymentPageState extends ConsumerState<PaymentPage> {
//   static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
//   String cardHolderName = "";
//   String cardNumber = "";
//   String cardExp = "";
//   String cardCVC = "";
//   @override
//   Widget build(BuildContext context) {
//     final orderPaymentModel = ref.watch(orderPaymentProvider);
//     return Scaffold(
//       appBar: AppBar(title: const Text("Payment")),
//       body: ProgressHUD(
//         inAsyncCall: orderPaymentModel.isLoading,
//         opacity: 0.3,
//         key: UniqueKey(),
//         child: Form(key: globalKey, child: _paymentUI(context, ref)),
//       ),
//     );
//   }

//   _paymentUI(BuildContext context, WidgetRef ref) {
//     final cartProvider = ref.watch(cartItemsProvider);

//     if (cartProvider.cartModel != null) {
//       return SingleChildScrollView(
//         child: Column(
//           children: [
//             const Text(
//               "Total Amount",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: 15),
//             Text(
//               "${Config.currency}${cartProvider.cartModel!.grandTotal.toString()}",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 25,
//                 color: Colors.green,
//               ),
//             ),
//             SizedBox(height: 15),
//             FormHelper.inputFieldWidgetWithLabel(
//               context,
//               "cardHolderName",
//               "Card Holder",
//               "Your name and surname",
//               (onValidate) {
//                 if (onValidate.isEmpty) {
//                   return "* Required";
//                 }
//               },
//               (onSaved) {
//                 cardHolderName = onSaved.toString().trim();
//               },
//               showPrefixIcon: true,
//               prefixIcon: const Icon(Icons.face),
//               borderRadius: 10,
//               contentPadding: 14,
//               paddingLeft: 0,
//               paddingRight: 0,
//               prefixIconPaddingLeft: 10,
//               borderColor: Colors.grey.shade200,
//               textColor: Colors.black,
//               prefixIconColor: Colors.black,
//               hintColor: Colors.black.withOpacity(.6),
//               backgroundColor: Colors.grey.shade100,
//               borderFocusColor: Colors.grey.shade200,
//             ),
//             SizedBox(height: 15),
//             FormHelper.inputFieldWidgetWithLabel(
//               context,
//               "cardNumber",
//               "Card Number",
//               "Card Number",
//               (onValidate) {
//                 if (onValidate.isEmpty) {
//                   return "* Required";
//                 }
//               },
//               (onSaved) {
//                 cardNumber = onSaved.toString().trim();
//               },
//               showPrefixIcon: true,
//               prefixIcon: const Icon(Icons.face),
//               borderRadius: 10,
//               contentPadding: 14,
//               paddingLeft: 0,
//               paddingRight: 0,
//               prefixIconPaddingLeft: 10,
//               borderColor: Colors.grey.shade200,
//               textColor: Colors.black,
//               prefixIconColor: Colors.black,
//               hintColor: Colors.black.withOpacity(.6),
//               backgroundColor: Colors.grey.shade100,
//               borderFocusColor: Colors.grey.shade200,
//             ),
//             SizedBox(height: 15),
//             Row(
//               children: [
//                 FormHelper.inputFieldWidgetWithLabel(
//                   context,
//                   "validExp",
//                   "Valid Until",
//                   "Month / Year",
//                   (onValidate) {
//                     if (onValidate.isEmpty) {
//                       return "* Required";
//                     }
//                   },
//                   (onSaved) {
//                     cardExp = onSaved.toString().trim();
//                   },
//                   showPrefixIcon: true,
//                   prefixIcon: const Icon(Icons.face),
//                   borderRadius: 10,
//                   contentPadding: 14,
//                   paddingLeft: 0,
//                   paddingRight: 0,
//                   prefixIconPaddingLeft: 10,
//                   borderColor: Colors.grey.shade200,
//                   textColor: Colors.black,
//                   prefixIconColor: Colors.black,
//                   hintColor: Colors.black.withOpacity(.6),
//                   backgroundColor: Colors.grey.shade100,
//                   borderFocusColor: Colors.grey.shade200,
//                 ),
//                 Flexible(
//                   child: FormHelper.inputFieldWidgetWithLabel(
//                     context,
//                     "CVC",
//                     "CVC",
//                     "CVC",
//                     (onValidate) {
//                       if (onValidate.isEmpty) {
//                         return "* Required";
//                       }
//                     },
//                     (onSaved) {
//                       cardCVC = onSaved.toString().trim();
//                     },
//                     showPrefixIcon: true,
//                     prefixIcon: const Icon(Icons.face),
//                     borderRadius: 10,
//                     contentPadding: 14,
//                     paddingLeft: 0,
//                     paddingRight: 0,
//                     prefixIconPaddingLeft: 10,
//                     borderColor: Colors.grey.shade200,
//                     textColor: Colors.black,
//                     prefixIconColor: Colors.black,
//                     hintColor: Colors.black.withOpacity(.6),
//                     backgroundColor: Colors.grey.shade100,
//                     borderFocusColor: Colors.grey.shade200,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 15),
//             Center(
//               child: FormHelper.submitButton(
//                 "Proccess to Confirm",
//                 () {},
//                 btnColor: Colors.blue,
//                 borderColor: Colors.white,
//                 txtColor: Colors.white,
//                 width: 250,
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//     return const CircularProgressIndicator();
//   }
// }
