import 'package:findo/data/models/accounts_model.dart';
import 'package:findo/screens/home/home_controller.dart';
import 'package:findo/screens/transactions/transation_controller.dart';
import 'package:findo/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:intl/intl.dart';
import '../../theme/constants.dart';
import '../../utils/index.dart';
import '../../widgets/index.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({Key? key, required this.account}) : super(key: key);
  final AccountsModel account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    final banks = ref.watch(banksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: banks.when(
        error: (error, stackTrace) => const SizedBox.shrink(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (data) {
          return Card(
            child: FormBuilder(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: inputHeight,
                      child: FormBuilderTextField(
                        name: 'to_account',
                        initialValue: account.name,
                        enabled: false,
                        style: inputTextStyle,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.max(70),
                        ]),
                        decoration: const InputDecoration(
                          labelText: 'Payment to',
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: inputHeight,
                            child: FormBuilderDateTimePicker(
                              name: 'txnDate',
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                              initialValue: DateTime.now().toUtc(),
                              inputType: InputType.date,
                              style: inputTextStyle,
                              format: DateFormat(
                                getSetting(key: 'dateFormat').value.toString(),
                              ),
                              decoration: InputDecoration(
                                labelText: 'Date',
                                suffixIcon: IconButton(
                                  icon: const Icon(IcoFontIcons.calendar),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpaceSmall(),
                        Expanded(
                          flex: 6,
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: inputHeight,
                                  child: FormBuilderTextField(
                                    name: 'budget_limit',
                                    initialValue: account.budget.toString(),
                                    enabled: false,
                                    style: inputTextStyle,
                                    decoration: const InputDecoration(
                                      labelText: 'Budget',
                                    ),
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    textCapitalization:
                                        TextCapitalization.words,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: inputHeight,
                                  child: FormBuilderTextField(
                                    name: 'budget_expenses',
                                    initialValue: "5,000.00",
                                    enabled: false,
                                    style: inputTextStyle,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                      FormBuilderValidators.max(70),
                                    ]),
                                    decoration: const InputDecoration(
                                      labelText: 'This month',
                                    ),
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    textCapitalization:
                                        TextCapitalization.words,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: inputHeight,
                            child: FormBuilderTextField(
                              name: 'amount',
                              style: inputTextStyle,
                              initialValue: "125",
                              decoration: InputDecoration(
                                labelText: 'Amount',
                                // errorStyle: const TextStyle(
                                //     color: Colors.transparent,
                                //     fontSize: 0,
                                //     height: 0),
                                // errorBorder: const OutlineInputBorder(
                                //   borderSide: BorderSide(color: Colors.red),
                                // ),
                                suffixIcon: IconButton(
                                  icon: Icon(currencySymbol()),
                                  onPressed: () {},
                                ),
                              ),
                              validator: FormBuilderValidators.compose(
                                  [FormBuilderValidators.required()]),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpaceSmall(),
                        Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: inputHeight,
                            child: FormBuilderDropdown<String>(
                              name: 'txnMode',
                              decoration: const InputDecoration(
                                labelText: 'Mode',
                              ),
                              initialValue: ref.watch(txnModeProvider),
                              validator: FormBuilderValidators.compose(
                                  [FormBuilderValidators.required()]),
                              items: ['CASH', 'BANK']
                                  .map((item) => DropdownMenuItem(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        value: item,
                                        child: Text(item),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                ref.read(txnModeProvider.state).state = val!;
                              },
                              valueTransformer: (val) => val?.toString(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ref.watch(txnModeProvider) == 'BANK'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              UIHelper.verticalSpaceSmall(),
                              data.isNotEmpty
                                  ? SizedBox(
                                      height: inputHeight,
                                      child: FormBuilderDropdown<int>(
                                        name: 'bank_account',
                                        decoration: const InputDecoration(
                                          labelText: 'From Bank',
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                        ),
                                        initialValue: data[0].id,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required()
                                        ]),
                                        items: data
                                            .map((item) => DropdownMenuItem(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerStart,
                                                  value: item.id,
                                                  child: Text(item.name),
                                                ))
                                            .toList(),
                                      ),
                                    )
                                  : const InfoBox(
                                      text: Text("Please add a Bank account"),
                                    ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    UIHelper.verticalSpaceSmall(),
                    SizedBox(
                      height: inputHeight,
                      child: FormBuilderTextField(
                        name: 'description',
                        initialValue: "Paid ",
                        style: inputTextStyle,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          errorStyle: TextStyle(
                              color: Colors.transparent,
                              fontSize: 0,
                              height: 0),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    UIHelper.verticalSpaceLarge(),
                    FormButton(
                      text: const Text("SUBMIT"),
                      onTap: data.isNotEmpty
                          ? () async {
                              EasyLoading.showProgress(0.3,
                                  status: 'Saving...');
                              if (formKey.currentState?.saveAndValidate() ??
                                  false) {
                                await ref
                                    .read(transactionProvider(account.id)
                                        .notifier)
                                    .addPayment(
                                        account: account,
                                        formData: formKey.currentState!.value)
                                    .then((value) {
                                  if (value == true) {
                                    EasyLoading.showSuccess(
                                        'Transaction Success!');

                                    //--Call Home page Data loader
                                    ref
                                        .read(homeDataProvider.notifier)
                                        .loadData();

                                    Navigator.pop(context);
                                  } else {
                                    EasyLoading.showError('Transaction Failed');
                                  }
                                });
                              } else {
                                debugPrint(
                                    formKey.currentState?.value.toString());
                                // showToast(msg: 'validation failed');
                                EasyLoading.showError('Failed with Error');
                              }
                            }
                          : () => null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ))),
    );
  }
}
