import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/screens/transactions/transation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

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
          return FormBuilder(
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
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                            initialValue: DateTime.now(),
                            inputType: InputType.date,
                            style: inputTextStyle,
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
                                  initialValue: "5,000.00",
                                  enabled: false,
                                  style: inputTextStyle,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.max(70),
                                  ]),
                                  decoration: const InputDecoration(
                                    labelText: 'Budget',
                                  ),
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  textCapitalization: TextCapitalization.words,
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: inputHeight,
                                child: FormBuilderTextField(
                                  name: 'budget_expenses',
                                  initialValue: "99,45,000.00",
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
                                  textCapitalization: TextCapitalization.words,
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
                            decoration: InputDecoration(
                              labelText: 'Amount',
                              errorStyle: const TextStyle(
                                  color: Colors.transparent,
                                  fontSize: 0,
                                  height: 0),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(IcoFontIcons.rupee),
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
                            style: inputTextStyle,
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
                            SizedBox(
                              height: inputHeight,
                              // child: FormBuilderTextField(
                              //   name: 'bank_account',
                              //   initialValue:
                              //       data.isNotEmpty ? data[0].name : '',
                              //   enabled: false,
                              //   style: inputTextStyle,
                              //   validator: FormBuilderValidators.compose([
                              //     FormBuilderValidators.required(),
                              //   ]),
                              //   decoration: const InputDecoration(
                              //     labelText: 'From Bank',
                              //   ),
                              //   keyboardType: TextInputType.name,
                              //   textInputAction: TextInputAction.next,
                              //   textCapitalization: TextCapitalization.words,
                              // ),

                              child: FormBuilderDropdown<int>(
                                name: 'bank_account',
                                decoration: const InputDecoration(
                                  labelText: 'From Bank',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                style: inputTextStyle,
                                initialValue: data[0].id,
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required()]),
                                items: data
                                    .map((item) => DropdownMenuItem(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          value: item.id,
                                          child: Text(item.name),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  UIHelper.verticalSpaceSmall(),
                  SizedBox(
                    height: inputHeight,
                    child: FormBuilderTextField(
                      name: 'description',
                      initialValue: "Paid in Cash",
                      style: inputTextStyle,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        errorStyle: TextStyle(
                            color: Colors.transparent, fontSize: 0, height: 0),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                  UIHelper.verticalSpaceExtraLarge(),
                  FormButton(
                      text: const Text("SUBMIT"),
                      onTap: () async {
                        if (formKey.currentState?.saveAndValidate() ?? false) {
                          // final resp = await ref
                          //     .watch(accountProvider.notifier)
                          //     .create(formData: formKey.currentState!.value);

                          // if (resp == true) {
                          //   showToast(msg: 'Account Created successfully!');
                          // } else {
                          //   showToast(msg: 'Invalid! may be duplicate');
                          // }
                        } else {
                          debugPrint(formKey.currentState?.value.toString());
                          showToast(msg: 'validation failed');
                        }
                      }),
                ],
              ),
            ),
          );
        },
      ))),
    );
  }
}
