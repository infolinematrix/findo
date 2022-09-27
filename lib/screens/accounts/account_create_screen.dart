import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../constants/constants.dart';
import '../../theme/constants.dart';
import '../../utils/index.dart';
import '../../widgets/index.dart';
import 'accounts_controller.dart';

class AccountCreateScreen extends ConsumerWidget {
  const AccountCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    double fHeight = 50.0.sp;

    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(4.0.sp),
            child: FormBuilder(
              key: formKey,
              child: Column(
                children: [
                  Card(
                    elevation: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: fHeight,
                          child: FormBuilderTextField(
                            name: 'name',
                            decoration: const InputDecoration(
                              labelText: 'Account Name',
                            ),
                            onChanged: (val) {},
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            style: inputTextStyle,
                          ),
                        ),
                        UIHelper.verticalSpaceSmall(),
                        SizedBox(
                          height: fHeight,
                          child: FormBuilderTextField(
                            name: 'description',
                            decoration: const InputDecoration(
                              labelText: 'Short description',
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
                        UIHelper.verticalSpaceSmall(),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: fHeight,
                                child: FormBuilderTextField(
                                  name: 'budget',
                                  decoration: InputDecoration(
                                    labelText: 'Budget (Monthly)',
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
                            UIHelper.horizontalSpaceSmall(),
                            Expanded(
                              child: SizedBox(
                                height: fHeight,
                                child: FormBuilderDropdown(
                                  name: 'isTemporary',
                                  initialValue: false,
                                  decoration: const InputDecoration(
                                    labelText: 'Is Temporay',
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  items: yesNo
                                      .map((yesNo) => DropdownMenuItem(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            value: yesNo['key'],
                                            child: Text(
                                              yesNo['value'].toString(),
                                              style: inputTextStyle,
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceSmall(),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: fHeight,
                                child: FormBuilderDropdown(
                                  name: 'isActive',
                                  initialValue: true,
                                  decoration: const InputDecoration(
                                    labelText: 'Active',
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  items: yesNo
                                      .map((yesNo) => DropdownMenuItem(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            value: yesNo['key'],
                                            child: Text(
                                              yesNo['value'].toString(),
                                              style: inputTextStyle,
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall(),
                            Expanded(
                              child: SizedBox(
                                height: fHeight,
                                child: FormBuilderDropdown(
                                  name: 'isVisible',
                                  initialValue: true,
                                  decoration: const InputDecoration(
                                    labelText: 'Is Visible',
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  items: yesNo
                                      .map((yesNo) => DropdownMenuItem(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            value: yesNo['key'],
                                            child: Text(
                                              yesNo['value'].toString(),
                                              style: inputTextStyle,
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceLarge(),
                        SizedBox(
                          width: double.infinity,
                          child: FormButton(
                            onTap: () async {
                              if (formKey.currentState?.saveAndValidate() ??
                                  false) {
                                await ref
                                    .watch(accountsProvider.notifier)
                                    .create(
                                        formData: formKey.currentState!.value)
                                    .then((value) => {
                                          if (value == true)
                                            {
                                              showToast(msg: "Account added"),
                                              Navigator.pop(context)
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
