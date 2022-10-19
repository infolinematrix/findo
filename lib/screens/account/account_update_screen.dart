import 'package:findo/constants/constants.dart';
import 'package:findo/data/models/accounts_model.dart';
import 'package:findo/screens/account/account_controller.dart';
import 'package:findo/services/settings_service.dart';
import 'package:findo/theme/app_theme.dart';
import 'package:findo/theme/constants.dart';
import 'package:findo/utils/index.dart';
import 'package:findo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AccountUpdateScreen extends ConsumerWidget {
  const AccountUpdateScreen({super.key, required this.account});
  final AccountsModel account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(title: Text(account.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: FormBuilder(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: inputHeight,
                      child: FormBuilderTextField(
                        name: 'name',
                        style: inputTextStyle,
                        initialValue: account.name,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        decoration: const InputDecoration(
                          labelText: 'Account Name',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          errorStyle: TextStyle(
                              color: Colors.transparent,
                              fontSize: 0,
                              height: 0),
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
                              name: 'accountType',
                              initialValue: 'EXPENSES',
                              isExpanded: true,
                              enabled: false,
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
                            name: 'hasChild',
                            isExpanded: true,
                            enabled: false,
                            initialValue: account.hasChild,
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
                          ),
                        )),
                      ],
                    ),
                    UIHelper.verticalSpaceSmall(),
                    account.hasChild == false
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  account.type != 'BANK'
                                      ? Expanded(
                                          child: SizedBox(
                                            height: inputHeight,
                                            child: FormBuilderTextField(
                                              name: 'budget',
                                              style: inputTextStyle,
                                              decoration: InputDecoration(
                                                labelText: 'Monthly Budget',
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                suffixIcon: Icon(
                                                  currencySymbol(),
                                                  size: 16.0.sp,
                                                ),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              textCapitalization:
                                                  TextCapitalization.words,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  account.type == 'BANK' &&
                                          account.type == 'ASSETS'
                                      ? UIHelper.horizontalSpaceSmall()
                                      : const SizedBox.shrink(),
                                  account.type == 'BANK' ||
                                          account.type == 'ASSETS'
                                      ? Expanded(
                                          child: SizedBox(
                                            height: inputHeight,
                                            child: FormBuilderTextField(
                                              name: 'openingBalance',
                                              style: inputTextStyle,
                                              decoration: InputDecoration(
                                                labelText: 'Opening Balance',
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                suffixIcon: Icon(
                                                  currencySymbol(),
                                                  size: 16.0.sp,
                                                ),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              textCapitalization:
                                                  TextCapitalization.words,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                              UIHelper.verticalSpaceSmall(),
                              Text(
                                "Leave blank if you have unlimited budget",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              UIHelper.verticalSpaceMedium(),
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
                                        decoration: checkBoxDecoration(),
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
                                        decoration: checkBoxDecoration(),
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
                                        decoration: checkBoxDecoration(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // UIHelper.verticalSpaceMedium(),
                              Text(
                                "Settings",
                                style: Theme.of(context).textTheme.bodyText1,
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
                                        decoration: checkBoxDecoration(),
                                      ),
                                    ),
                                  ),
                                  UIHelper.horizontalSpaceSmall(),
                                  Expanded(
                                    child: SizedBox(
                                      height: inputHeight,
                                      child: FormBuilderCheckbox(
                                        name: 'isLocked',
                                        initialValue: false,
                                        title: const Text("Is Lock"),
                                        decoration: checkBoxDecoration(),
                                      ),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox.shrink())
                                ],
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    UIHelper.verticalSpaceMedium(),
                    FormButton(
                        text: const Text("SUBMIT"),
                        onTap: () async {
                          if (formKey.currentState?.saveAndValidate() ??
                              false) {
                            await ref
                                .read(accountProvider(account.id).notifier)
                                .update(
                                    accountId: account.id,
                                    parentId: account.parent!,
                                    formData: formKey.currentState!.value)
                                .then((value) {
                              if (value == true) {
                                ref
                                    .read(accountProvider(account.parent!)
                                        .notifier)
                                    .getAccounts(account.parent!);
                                showToast(msg: 'Account Updated successfully!');
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
      ),
    );
  }
}
