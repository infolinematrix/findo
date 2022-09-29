import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../theme/app_theme.dart';
import '../../utils/index.dart';
import '../../widgets/index.dart';
import 'ledger_controller.dart';

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
                    labelText: 'Group Name',
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                ),
                UIHelper.verticalSpaceSmall(),
                FormBuilderCheckbox(
                  name: 'isActive',
                  initialValue: true,
                  title: const Text("Is Active"),
                  decoration: const InputDecoration(),
                ),
                UIHelper.verticalSpaceExtraLarge(),
                FormButton(
                    text: const Text("SUBMIT"),
                    onTap: () async {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        final resp = await ref
                            .watch(ledgerProvider.notifier)
                            .create(formData: formKey.currentState!.value);

                        if (resp == true) {
                          showToast(msg: 'Group Created successfully!');
                        } else {
                          showToast(msg: 'Invalid! may be duplicate');
                        }
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
