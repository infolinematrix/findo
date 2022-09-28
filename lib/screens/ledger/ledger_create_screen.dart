import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../constants/constants.dart';
import '../../theme/app_theme.dart';
import '../../utils/index.dart';
import '../../widgets/index.dart';

class LedgerCreateScreen extends ConsumerWidget {
  const LedgerCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(title: const Text("Create")),
      body: SafeArea(
        child: FormBuilder(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(16.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                UIHelper.verticalSpaceSmall(),
                FormBuilderDropdown(
                  style: inputTextStyle,
                  name: 'ledger_type',
                  decoration: const InputDecoration(
                    labelText: 'Ledger Type',
                  ),
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                  items: ledgerType
                      .map((legType) => DropdownMenuItem(
                            alignment: AlignmentDirectional.centerStart,
                            value: legType['code'],
                            child: Text(legType['name'].toString()),
                          ))
                      .toList(),
                  onChanged: (val) {},
                  valueTransformer: (val) => val?.toString(),
                ),
                UIHelper.verticalSpaceSmall(),
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderDropdown(
                        style: inputTextStyle,
                        name: 'has_child',
                        decoration: const InputDecoration(
                          labelText: 'Account Level',
                        ),
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        items: yesNo
                            .map((yn) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.centerStart,
                                  value: yn['key'],
                                  child: Text(yn['value'].toString()),
                                ))
                            .toList(),
                        onChanged: (val) {},
                        valueTransformer: (val) => val?.toString(),
                      ),
                    ),
                    UIHelper.horizontalSpaceSmall(),
                    Expanded(
                      child: FormBuilderDropdown(
                        style: inputTextStyle,
                        initialValue: true,
                        name: 'is_active',
                        decoration: const InputDecoration(
                          labelText: 'Is Active',
                        ),
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        items: yesNo
                            .map((yn) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.centerStart,
                                  value: yn['key'],
                                  child: Text(yn['value'].toString()),
                                ))
                            .toList(),
                        onChanged: (val) {},
                        valueTransformer: (val) => val?.toString(),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceExtraLarge(),
                FormButton(
                    text: const Text("SUBMIT"),
                    onTap: () async {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
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
    );
  }
}
