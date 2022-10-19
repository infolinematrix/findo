import 'package:findo/screens/settings/settings_controller.dart';
import 'package:findo/services/settings_service.dart';
import 'package:findo/theme/constants.dart';
import 'package:findo/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../widgets/index.dart';

class BankAccountCreateScreen extends ConsumerWidget {
  const BankAccountCreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    final bankAccounts = ref.watch(bankAccountsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bank Account"),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.add,
                  size: 26.0.sp,
                ),
              )),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: bankAccounts.when(
          error: (error, stackTrace) => Text(error.toString()),
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          data: (data) {
            return Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: FormBuilder(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: inputHeight,
                      child: FormBuilderTextField(
                        name: 'bank',
                        style: inputTextStyle,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.max(70),
                        ]),
                        decoration: const InputDecoration(
                          labelText: 'Bank Name',
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    UIHelper.verticalSpaceMedium(),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: inputHeight,
                            child: FormBuilderTextField(
                              name: 'openingBalance',
                              style: inputTextStyle,
                              decoration: InputDecoration(
                                labelText: 'Opening Balance',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: Icon(
                                  currencySymbol(),
                                  size: 16.0.sp,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpaceMedium(),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: inputHeight,
                                  child: FormBuilderCheckbox(
                                    name: 'isActive',
                                    initialValue: true,
                                    title: const Text("Is Active"),
                                    // decoration: checkboxDecoration,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpaceExtraLarge(),
                    FormButton(
                        text: const Text("SUBMIT"),
                        onTap: () async {
                          if (formKey.currentState?.saveAndValidate() ??
                              false) {
                            await ref
                                .read(initailBankAccountsProvider.notifier)
                                .create(formKey.currentState?.value
                                    as Map<String, dynamic>)
                                .then((value) {
                              if (value == true) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/home", (route) => false);
                              } else {
                                showToast(msg: 'Something went wrong!');
                              }
                            });
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
        )),
      ),
    );
  }
}
