import 'package:finsoft2/screens/error_screen.dart';
import 'package:finsoft2/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../constants/constants.dart';
import '../../data/models/accounts_model.dart';
import '../../theme/constants.dart';
import '../../widgets/index.dart';
import '../home/home_controller.dart';
import 'transaction_controller.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({Key? key, required this.account}) : super(key: key);
  final AccountsModel account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    final initialData = ref.watch(inttTransactionProvider);

    double fHeight = 50.0.sp;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Make Transaction"),
      ),
      body: SingleChildScrollView(
          child: initialData.when(
        data: (data) {
          return FormBuilder(
            key: formKey,
            child: Column(
              children: [
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0.sp, vertical: 16.0.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: fHeight,
                                child: FormBuilderDateTimePicker(
                                  name: 'date',
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly,

                                  initialValue: DateTime.now(),
                                  inputType: InputType.date,
                                  decoration: InputDecoration(
                                    labelText: 'Date',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {},
                                    ),
                                  ),
                                  style: inputTextStyle,
                                  // locale:
                                  //     const Locale.fromSubtags(languageCode: 'fr'),
                                ),
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall(),
                            Expanded(
                              child: SizedBox(
                                height: fHeight,
                                child: FormBuilderDropdown(
                                  name: 'txnType',
                                  initialValue: 'PAYMENT',
                                  decoration: const InputDecoration(
                                    labelText: 'Type',
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  items: txnType
                                      .map((txnT) => DropdownMenuItem(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            value: txnT,
                                            child: Text(
                                              txnT,
                                              style: inputTextStyle,
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (val) {},
                                  valueTransformer: (val) => val?.toString(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceSmall(),
                        SizedBox(
                          height: fHeight,
                          child: FormBuilderDropdown(
                            name: 'account',
                            initialValue: account.id,
                            decoration: const InputDecoration(
                              labelText: 'Account Head',
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            items: data.accounts!
                                .map((account) => DropdownMenuItem(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      value: account.id,
                                      child: Text(
                                        account.name,
                                        style: inputTextStyle,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (val) {},
                            valueTransformer: (val) => val?.toInt(),
                          ),
                        ),
                        UIHelper.verticalSpaceMedium(),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: fHeight,
                                child: FormBuilderTextField(
                                  name: 'amount',
                                  decoration: InputDecoration(
                                    labelText: 'Amount',
                                    labelStyle: TextStyle(fontSize: 14.0.sp),
                                    prefixIcon: Icon(currencies
                                        .where((element) =>
                                            element['code'] == 'rupee')
                                        .first['icon']),
                                  ),
                                  onChanged: (val) {},
                                  valueTransformer: (text) =>
                                      num.tryParse(text!),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric(),
                                  ]),
                                  // keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,2}')),
                                  ],
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),

                                  style: inputTextStyle.copyWith(
                                      fontSize: 18.0.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            UIHelper.horizontalSpaceMedium(),
                            Expanded(
                              child: SizedBox(
                                height: fHeight,
                                child: FormBuilderDropdown<String>(
                                  name: 'mode',
                                  initialValue: "Cash",
                                  decoration: const InputDecoration(
                                    labelText: 'Mode',
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  items: data.txnModes!
                                      .map((mode) => DropdownMenuItem(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            value: mode,
                                            child: Text(
                                              mode,
                                              style: inputTextStyle,
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (val) {},
                                  valueTransformer: (val) => val?.toString(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceSmall(),
                        SizedBox(
                          height: fHeight,
                          child: FormBuilderTextField(
                            name: 'description',
                            decoration: const InputDecoration(
                              labelText: 'Description',
                            ),
                            onChanged: (val) {},
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.sentences,
                            style: inputTextStyle,
                          ),
                        ),
                        UIHelper.verticalSpaceLarge(),
                        SizedBox(
                          width: double.infinity,
                          child: FormButton(
                            onTap: () async {
                              if (formKey.currentState?.saveAndValidate() ??
                                  false) {
                                final data = {
                                  'txnType':
                                      formKey.currentState!.value['txnType'],
                                  'account':
                                      formKey.currentState!.value['account'],
                                  'date': formKey.currentState!.value['date'],
                                  'mode': formKey.currentState!.value['mode'],
                                  'description': formKey
                                      .currentState!.value['description'],
                                  'amount':
                                      formKey.currentState!.value['amount'],
                                };

                                final response = ref
                                    .watch(transactionsProvider(formKey
                                            .currentState!.value['account'])
                                        .notifier)
                                    .addEntry(formData: data);

                                response.then((value) {
                                  if (value == true) {
                                    showToast(msg: "Transaction saved");

                                    //--Update Home Data
                                    ref
                                        .watch(homeDataProvider.notifier)
                                        .loadData();

                                    Navigator.pop(context);
                                  } else {
                                    showToast(msg: "Transaction fails");
                                  }
                                });
                              } else {
                                debugPrint(
                                    formKey.currentState?.value.toString());
                                debugPrint('validation failed');
                              }
                            },
                            text: const Text("SUBMIT"),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return ErrorScreen(msg: error.toString());
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}
