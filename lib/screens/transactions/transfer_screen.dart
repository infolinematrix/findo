// import 'package:findo/constants/constants.dart';
// import 'package:findo/screens/transactions/transation_controller.dart';
// import 'package:findo/services/settings_service.dart';
// import 'package:findo/theme/constants.dart';
// import 'package:findo/utils/index.dart';
// import 'package:findo/widgets/index.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:icofont_flutter/icofont_flutter.dart';
// import 'package:intl/intl.dart';

// class TransferScreen extends ConsumerStatefulWidget {
//   const TransferScreen({Key? key}) : super(key: key);

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _TransferScreenState();
// }

// class _TransferScreenState extends ConsumerState<TransferScreen> {
//   int transferModeBool = 1;
//   String title = "To Bank";
//   String descriptionText = "Cash Deposit";

//   @override
//   Widget build(BuildContext context) {
//     final formKey = GlobalKey<FormBuilderState>();
//     final banks = ref.watch(banksProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Transafer"),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//             child: banks.when(
//           error: (error, stackTrace) => const SizedBox.shrink(),
//           loading: () => const Center(
//             child: CircularProgressIndicator(),
//           ),
//           data: (data) {
//             return FormBuilder(
//               key: formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const InfoBox(
//                       text: Text(
//                           "In Transfer either Cash Deposite to Bank or Cash Withdrawal from Bank")),
//                   UIHelper.verticalSpaceLarge(),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
//                     child: SizedBox(
//                       height: inputHeight,
//                       child: FormBuilderDropdown<int>(
//                         name: 'txnType',
//                         initialValue: transferModeBool,
//                         decoration: const InputDecoration(
//                           labelText: 'Mode',
//                         ),
//                         style: inputTextStyle,
//                         validator: FormBuilderValidators.compose(
//                             [FormBuilderValidators.required()]),
//                         items: transferMode
//                             .map((txnMode) => DropdownMenuItem(
//                                   alignment: AlignmentDirectional.centerStart,
//                                   value: int.parse(txnMode['code'].toString())
//                                       .toInt(),
//                                   child: Text(txnMode['name']),
//                                 ))
//                             .toList(),
//                         onChanged: (val) {
//                           setState(() {
//                             transferModeBool =
//                                 int.parse(val.toString()).toInt();
//                             if (transferModeBool == 1) {
//                               title = "To Bank";
//                               descriptionText = "Cash Deposit";
//                             }

//                             if (transferModeBool == 2) {
//                               title = "From Bank";
//                               descriptionText = "Cash Withdrawl";
//                             }
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   UIHelper.verticalSpaceSmall(),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
//                     child: data.isNotEmpty
//                         ? SizedBox(
//                             height: inputHeight,
//                             child: FormBuilderDropdown(
//                               name: 'bank',
//                               initialValue: data.isNotEmpty ? data[0].id : '',
//                               decoration: InputDecoration(
//                                 labelText: title,
//                               ),
//                               style: inputTextStyle,
//                               validator: FormBuilderValidators.compose(
//                                   [FormBuilderValidators.required()]),
//                               items: data
//                                   .map((item) => DropdownMenuItem(
//                                         alignment:
//                                             AlignmentDirectional.centerStart,
//                                         value: item.id,
//                                         child: Text(item.name),
//                                       ))
//                                   .toList(),
//                             ),
//                           )
//                         : const InfoBox(
//                             text: Text("Please add a Bank account"),
//                             // color: AppColors.darkOrage,
//                           ),
//                   ),
//                   UIHelper.verticalSpaceSmall(),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: SizedBox(
//                             height: inputHeight,
//                             child: FormBuilderTextField(
//                               name: 'amount',
//                               style: inputTextStyle,
//                               initialValue: "125",
//                               decoration: InputDecoration(
//                                 labelText: 'Amount',
//                                 errorStyle: const TextStyle(
//                                     color: Colors.transparent,
//                                     fontSize: 0,
//                                     height: 0),
//                                 errorBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.red),
//                                 ),
//                                 suffixIcon: IconButton(
//                                   icon: Icon(currencySymbol()),
//                                   onPressed: () {},
//                                 ),
//                               ),
//                               validator: FormBuilderValidators.compose(
//                                   [FormBuilderValidators.required()]),
//                               keyboardType: TextInputType.number,
//                               textInputAction: TextInputAction.next,
//                             ),
//                           ),
//                         ),
//                         UIHelper.horizontalSpaceSmall(),
//                         Expanded(
//                           child: SizedBox(
//                             height: inputHeight,
//                             child: FormBuilderDateTimePicker(
//                               name: 'txnDate',
//                               initialEntryMode:
//                                   DatePickerEntryMode.calendarOnly,
//                               initialValue: DateTime.now().toUtc(),
//                               inputType: InputType.date,
//                               format: DateFormat(
//                                 getSetting(key: 'dateFormat').value.toString(),
//                               ),
//                               style: inputTextStyle,
//                               decoration: const InputDecoration(
//                                 labelText: 'Date',
//                                 suffixIcon: Icon(IcoFontIcons.calendar),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   UIHelper.verticalSpaceSmall(),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
//                     child: SizedBox(
//                       height: inputHeight,
//                       child: FormBuilderTextField(
//                         name: 'description',
//                         initialValue: descriptionText,
//                         style: inputTextStyle,
//                         validator: FormBuilderValidators.compose([
//                           FormBuilderValidators.required(),
//                         ]),
//                         decoration: const InputDecoration(
//                           labelText: 'Description',
//                           errorStyle: TextStyle(
//                               color: Colors.transparent,
//                               fontSize: 0,
//                               height: 0),
//                           errorBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                         ),
//                         keyboardType: TextInputType.text,
//                         textInputAction: TextInputAction.next,
//                         textCapitalization: TextCapitalization.words,
//                       ),
//                     ),
//                   ),
//                   UIHelper.verticalSpaceLarge(),
//                   Padding(
//                     padding: EdgeInsets.all(16.0.sp),
//                     child: FormButton(
//                       text: const Text("SUBMIT"),
//                       onTap: data.isNotEmpty
//                           ? () async {
//                               EasyLoading.showProgress(0.3,
//                                   status: 'Saving...');
//                               if (formKey.currentState?.saveAndValidate() ??
//                                   false) {
//                                 await ref
//                                     .read(transactionProvider(1).notifier)
//                                     .addTransfer(
//                                         formData: formKey.currentState!.value)
//                                     .then((value) {
//                                   if (value == true) {
//                                     EasyLoading.showSuccess(
//                                         'Transaction Success!');
//                                     Navigator.pop(context);
//                                   } else {
//                                     EasyLoading.showError('Transaction Failed');
//                                   }
//                                 });
//                               } else {
//                                 debugPrint(
//                                     formKey.currentState?.value.toString());
//                                 // showToast(msg: 'validation failed');
//                                 EasyLoading.showError('Failed with Error');
//                               }
//                             }
//                           : () => null,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         )),
//       ),
//     );
//   }
// }
