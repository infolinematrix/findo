import 'package:finsoft2/data/models/ledger_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../theme/constants.dart';
import '../../utils/index.dart';
import '../../widgets/index.dart';
import '../ledger/ledger_controller.dart';
import 'account_controller.dart';

class AccountCreateScreen extends ConsumerWidget {
  const AccountCreateScreen({Key? key, required this.ledger}) : super(key: key);
  final LedgerModel ledger;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    final ledgers = ref.watch(ledgerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Create")),
      body: SafeArea(
        child: ledgers.when(
          error: (error, stackTrace) => Text(error.toString()),
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          data: (data) {
            return SingleChildScrollView(
              child: FormBuilder(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.all(16.0.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // FormBuilderDropdown(
                      //   name: 'ledger',
                      //   decoration: const InputDecoration(
                      //     labelText: 'Select Group',
                      //   ),
                      //   validator: FormBuilderValidators.compose(
                      //       [FormBuilderValidators.required()]),
                      //   items: data
                      //       .map((e) => DropdownMenuItem(
                      //             value: e.id,
                      //             child: Text(
                      //               e.name,
                      //               style: inputTextStyle,
                      //             ),
                      //           ))
                      //       .toList(),
                      // ),
                      SizedBox(
                        height: inputHeight,
                        child: FormBuilderTextField(
                          name: 'ledger',
                          style: inputTextStyle,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.max(70),
                          ]),
                          decoration: const InputDecoration(
                            labelText: 'Group',
                          ),
                          enabled: false,
                          initialValue: ledger.name,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      UIHelper.verticalSpaceSmall(),
                      SizedBox(
                        height: inputHeight,
                        child: FormBuilderTextField(
                          name: 'name',
                          style: inputTextStyle,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          decoration: const InputDecoration(
                            labelText: 'Account Name',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                            child: SizedBox(
                              height: inputHeight,
                              child: FormBuilderTextField(
                                name: 'budget',
                                style: inputTextStyle,
                                decoration: const InputDecoration(
                                  labelText: 'Monthly Budget',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.words,
                              ),
                            ),
                          ),
                          UIHelper.horizontalSpaceSmall(),
                          Expanded(
                            child: SizedBox(
                              height: inputHeight,
                              child: FormBuilderCheckbox(
                                name: 'isActive',
                                initialValue: true,
                                title: const Text("Is Active"),
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpaceSmall(),
                      Text(
                        "Leave blank if you have unlimited budget",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      UIHelper.verticalSpaceExtraLarge(),
                      FormButton(
                          text: const Text("SUBMIT"),
                          onTap: () async {
                            if (formKey.currentState?.saveAndValidate() ??
                                false) {
                              final data = {
                                'ledgerId': ledger.id,
                                ...formKey.currentState!.value
                              };

                              await ref
                                  .read(accountProvider(ledger.id).notifier)
                                  .create(formData: data)
                                  .then((value) {
                                if (value == true) {
                                  showToast(
                                      msg: 'Account Created successfully!');
                                  Navigator.pop(context);
                                } else {
                                  showToast(msg: 'Invalid! may be duplicate');
                                }
                              });
                            } else {
                              debugPrint(
                                  formKey.currentState?.value.toString());
                              showToast(msg: 'validation failed');
                            }
                          }),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
