import 'package:finsoft2/screens/account/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../constants/constants.dart';
import '../../services/settings_service.dart';
import '../../theme/constants.dart';
import '../../utils/index.dart';
import '../../widgets/index.dart';

class AccountCreateScreen extends ConsumerWidget {
  const AccountCreateScreen({Key? key, required this.account})
      : super(key: key);
  final Map<String, dynamic> account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(title: const Text("Create")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: formKey,
            child: Container(
              padding: EdgeInsets.all(16.0.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: inputHeight,
                    child: FormBuilderTextField(
                      name: 'group',
                      style: inputTextStyle,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.max(70),
                      ]),
                      decoration: const InputDecoration(
                        labelText: 'Parent Account',
                      ),
                      enabled: false,
                      initialValue:
                          account['parent'] == 0 ? "Root" : account['name'],
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
                        errorStyle: TextStyle(
                            color: Colors.transparent, fontSize: 0, height: 0),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
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
                          child: FormBuilderDropdown(
                            style: inputTextStyle,
                            name: 'accountType',
                            initialValue: 'EXPENSES',
                            decoration: const InputDecoration(
                              labelText: 'Account Type',
                            ),
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()]),
                            items: accountType
                                .map((acType) => DropdownMenuItem(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      value: acType['code'],
                                      child: Text(acType['name']),
                                    ))
                                .toList(),
                            onChanged: (val) {},
                            valueTransformer: (val) => val?.toString(),
                          ),
                        ),
                      ),
                      UIHelper.horizontalSpaceSmall(),
                      Expanded(
                        child: SizedBox(
                          height: inputHeight,
                          child: FormBuilderDropdown(
                            style: inputTextStyle,
                            name: 'hasChild',
                            initialValue: ref.read(hasChildProvider),
                            decoration: const InputDecoration(
                              labelText: 'Has Child',
                            ),
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()]),
                            items: yesNo
                                .map((yn) => DropdownMenuItem<bool>(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      value: yn['key'] as bool,
                                      child: Text(yn['value'].toString()),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              ref.read(hasChildProvider.state).state =
                                  val as bool;
                            },
                            // valueTransformer: (val) => val?.toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceSmall(),
                  ref.watch(hasChildProvider) == false
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: inputHeight,
                                    child: FormBuilderTextField(
                                      name: 'budget',
                                      style: inputTextStyle,
                                      decoration: InputDecoration(
                                        labelText: 'Monthly Budget',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        suffixIcon: Icon(
                                          currencySymbol(),
                                          size: 16.0.sp,
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      textCapitalization:
                                          TextCapitalization.words,
                                    ),
                                  ),
                                ),
                                UIHelper.horizontalSpaceSmall(),
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
                                      textCapitalization:
                                          TextCapitalization.words,
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
                            UIHelper.verticalSpaceSmall(),
                            Text(
                              "Allow Transaction mode",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: inputHeight,
                                    child: FormBuilderCheckbox(
                                      name: 'allowReceipt',
                                      initialValue: true,
                                      title: const Text("Receipt"),
                                      // decoration: checkboxDecoration,
                                    ),
                                  ),
                                ),
                                UIHelper.horizontalSpaceSmall(),
                                Expanded(
                                  child: SizedBox(
                                    height: inputHeight,
                                    child: FormBuilderCheckbox(
                                      name: 'allowPayment',
                                      initialValue: true,
                                      title: const Text("Payment"),
                                      // decoration: checkboxDecoration,
                                    ),
                                  ),
                                ),
                                UIHelper.horizontalSpaceSmall(),
                                Expanded(
                                  child: SizedBox(
                                    height: inputHeight,
                                    child: FormBuilderCheckbox(
                                      name: 'allowTransfer',
                                      initialValue: false,
                                      title: const Text("Transfer"),
                                      // decoration: checkboxDecoration,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            UIHelper.verticalSpaceMedium(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0.0.w),
                              child: Text(
                                "Settings",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Row(
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
                                Expanded(
                                  child: SizedBox(
                                    height: inputHeight,
                                    child: FormBuilderCheckbox(
                                      name: 'isLocked',
                                      initialValue: false,
                                      title: const Text("Is Lock"),
                                      // decoration: checkboxDecoration,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(height: inputHeight),
                                ),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  UIHelper.verticalSpaceExtraLarge(),
                  FormButton(
                      text: const Text("SUBMIT"),
                      onTap: () async {
                        if (formKey.currentState?.saveAndValidate() ?? false) {
                          final data = {
                            'parent': account['parent'],
                            ...formKey.currentState!.value
                          };

                          await ref
                              .read(accountProvider(account['parent']).notifier)
                              .create(formData: data)
                              .then((value) {
                            if (value == true) {
                              showToast(msg: 'Account Created successfully!');
                              Navigator.pop(context);
                            } else {
                              showToast(msg: 'Invalid! may be duplicate');
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
          ),
        ),
      ),
    );
  }
}
