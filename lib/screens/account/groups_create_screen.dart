import 'package:findo/constants/constants.dart';
import 'package:findo/theme/app_theme.dart';
import 'package:findo/theme/constants.dart';
import 'package:findo/utils/ui_helper.dart';
import 'package:findo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'account_group_controller.dart';

class AccountGroupCreateScreen extends ConsumerWidget {
  const AccountGroupCreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Groups"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: formKey,
            child: Card(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Create Account Group",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    UIHelper.verticalSpaceMedium(),
                    SizedBox(
                      height: inputHeight,
                      child: FormBuilderTextField(
                        name: 'name',
                        style: inputTextStyle,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.max(70),
                        ]),
                        decoration: const InputDecoration(
                          labelText: 'Group Name',
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    UIHelper.verticalSpaceSmall(),
                    SizedBox(
                      height: inputHeight,
                      child: FormBuilderDropdown(
                        name: 'accountType',
                        initialValue: accountType[0]['code'],
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Group Type',
                        ),
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        items: accountType
                            .map((acType) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.centerStart,
                                  value: acType['code'],
                                  child: Text(acType['name']),
                                ))
                            .toList(),
                        onChanged: (val) {},
                        valueTransformer: (val) => val?.toString(),
                      ),
                    ),
                    UIHelper.verticalSpaceSmall(),
                    SizedBox(
                      height: inputHeight,
                      child: FormBuilderTextField(
                        name: 'description',
                        style: inputTextStyle,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.max(70),
                        ]),
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    UIHelper.verticalSpaceMedium(),
                    Text(
                      "Allowed Transaction type",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    // UIHelper.verticalSpaceSmall(),
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
                              initialValue: false,
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
                    UIHelper.verticalSpaceLarge(),
                    FormButton(
                        text: const Text("SUBMIT"),
                        onTap: () async {
                          if (formKey.currentState?.saveAndValidate() ??
                              false) {
                            await ref
                                .read(accountGroupsProvider.notifier)
                                .create(
                                    formData: formKey.currentState?.value
                                        as Map<String, dynamic>)
                                .then((value) {
                              if (value == true) {
                                EasyLoading.showSuccess('Created Successfuly!');
                                Navigator.pop(context);
                              } else {
                                EasyLoading.showError('Something went wrong!');
                              }
                            });
                          } else {
                            debugPrint(formKey.currentState?.value.toString());
                            showToast(msg: 'validation failed');
                          }
                        }),
                    UIHelper.verticalSpaceMedium(),
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
