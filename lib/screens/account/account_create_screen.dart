import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/screens/account/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/constants.dart';
import '../../utils/index.dart';
import '../../widgets/index.dart';
import 'components/create_input.dart';

class AccountCreateScreen extends ConsumerWidget {
  const AccountCreateScreen({Key? key, required this.parent}) : super(key: key);
  final AccountsModel parent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(title: const Text("Create")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: formKey,
            child: Card(
              child: Container(
                padding: EdgeInsets.all(16.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: inputHeight,
                      child: groupInput(parent),
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                              height: inputHeight,
                              child: accountTypeInput(parent)),
                        ),
                        UIHelper.horizontalSpaceSmall(),
                        Expanded(
                          child: SizedBox(
                            height: inputHeight,
                            child: hasChildInput(ref),
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpaceSmall(),
                    SizedBox(
                      height: inputHeight,
                      child: nameInput(),
                    ),
                    UIHelper.verticalSpaceSmall(),
                    SizedBox(
                      height: inputHeight,
                      child: descriptionInput(),
                    ),
                    UIHelper.verticalSpaceSmall(),
                    ref.watch(hasChildProvider) == false
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  parent.type == 'EXPENSES'
                                      ? Expanded(
                                          child: SizedBox(
                                            height: inputHeight,
                                            child: budgetInput(),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  parent.type == 'EXPENSES'
                                      ? UIHelper.horizontalSpaceSmall()
                                      : const SizedBox.shrink(),
                                  Expanded(
                                    child: SizedBox(
                                      height: inputHeight,
                                      child: openingBalanceInput(),
                                    ),
                                  ),
                                ],
                              ),
                              parent.type == 'EXPENSES'
                                  ? Text(
                                      "Leave blank if you have unlimited budget",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          )
                        : const SizedBox.shrink(),
                    UIHelper.verticalSpaceMedium(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0.w),
                      child: Text(
                        "Settings",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: inputHeight,
                            child: isActiveInput(),
                          ),
                        ),
                        UIHelper.horizontalSpaceSmall(),
                        Expanded(
                          child: SizedBox(
                            height: inputHeight,
                            child: isLockedInput(),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(height: inputHeight),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpaceMedium(),
                    FormButton(
                        text: const Text("SUBMIT"),
                        onTap: () async {
                          if (formKey.currentState?.saveAndValidate() ??
                              false) {
                            await ref
                                .read(accountProvider(parent.id).notifier)
                                .create(
                                    parent: parent,
                                    formData: formKey.currentState!.value)
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
      ),
    );
  }

  // FormBuilderCheckbox isLockedInput() {
  //   return FormBuilderCheckbox(
  //     name: 'isLocked',
  //     initialValue: false,
  //     title: const Text("Is Lock"),
  //     decoration: checkBoxDecoration(),
  //   );
  // }

  // FormBuilderCheckbox isActiveInput() {
  //   return FormBuilderCheckbox(
  //     name: 'isActive',
  //     initialValue: true,
  //     title: const Text("Is Active"),
  //     decoration: checkBoxDecoration(),
  //   );
  // }

}
