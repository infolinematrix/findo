import 'package:finsoft2/constants/constants.dart';
import 'package:finsoft2/theme/app_theme.dart';
import 'package:finsoft2/utils/index.dart';
import 'package:finsoft2/widgets/form_button.dart';
import 'package:finsoft2/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../services/settings_service.dart';
import '../../theme/constants.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    final appThemeState = ref.read(appThemeStateNotifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FormBuilder(
              key: formKey,
              onChanged: () {
                formKey.currentState!.save();
                debugPrint(formKey.currentState!.value.toString());
              },
              child: Padding(
                padding: EdgeInsets.all(16.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      style: inputTextStyle,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.max(70),
                      ]),
                      decoration: const InputDecoration(
                        labelText: 'Your Name',
                      ),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                    ),
                    UIHelper.verticalSpaceMedium(),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: inputHeight,
                            child: FormBuilderDropdown(
                              style: inputTextStyle,
                              name: 'currency',
                              decoration: const InputDecoration(
                                labelText: 'Currency',
                              ),
                              validator: FormBuilderValidators.compose(
                                  [FormBuilderValidators.required()]),
                              items: currencies
                                  .map((currency) => DropdownMenuItem(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        value: currency['code'],
                                        child: Text(currency['name']),
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
                              name: 'dateFormat',
                              decoration: const InputDecoration(
                                labelText: 'Date Format',
                              ),
                              validator: FormBuilderValidators.compose(
                                  [FormBuilderValidators.required()]),
                              items: dateFormat
                                  .map((dateFormat) => DropdownMenuItem(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        value: dateFormat,
                                        child: Text(dateFormat),
                                      ))
                                  .toList(),
                              onChanged: (val) {},
                              valueTransformer: (val) => val?.toString(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpaceMedium(),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: inputHeight,
                            child: FormBuilderTextField(
                              name: 'cashInHand',
                              style: inputTextStyle,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              decoration: const InputDecoration(
                                labelText: 'Cash in Hand',
                              ),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpaceSmall(),
                        Expanded(
                          child: SizedBox(
                            height: inputHeight,
                            child: FormBuilderSwitch(
                              title: const Text('Dark Mode'),
                              name: 'theme',
                              initialValue: appThemeState.isDarkModeEnabled,
                              onChanged: (enabled) {
                                if (enabled!) {
                                  appThemeState.setDarkTheme();
                                } else {
                                  appThemeState.setLightTheme();
                                }
                              },
                            ),
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
                            ref
                                .watch(
                                    createSettings(formKey.currentState!.value)
                                        .future)
                                .then((value) {
                              if (value == true) {
                                showToast(msg: 'Settings updated!');
                                // Navigator.pushReplacementNamed(
                                //     context, Routes.home);

                                Navigator.pushReplacementNamed(
                                    context, "/initial_bank_create");
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
            ),
          ],
        ),
      )),
    );
  }
}
