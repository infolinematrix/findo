import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

import '../../theme/constants.dart';
import '../../utils/index.dart';
import '../../widgets/index.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(8.0.sp),
        child: FormBuilder(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Payment"),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: inputHeight,
                        child: FormBuilderDateTimePicker(
                          name: 'date',
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialValue: DateTime.now(),
                          inputType: InputType.date,
                          style: inputTextStyle,
                          decoration: InputDecoration(
                            labelText: 'Date',
                            suffixIcon: IconButton(
                              icon: const Icon(IcoFontIcons.calendar),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    ),
                    UIHelper.horizontalSpaceSmall(),
                    Expanded(
                      child: SizedBox(
                        height: inputHeight,
                        child: FormBuilderTextField(
                          name: 'txnMode',
                          initialValue: "Payment",
                          enabled: false,
                          style: inputTextStyle,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.max(70),
                          ]),
                          decoration: const InputDecoration(
                            labelText: 'Mode',
                          ),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceExtraLarge(),
                FormButton(
                    text: const Text("SUBMIT"),
                    onTap: () async {
                      // if (formKey.currentState?.saveAndValidate() ?? false) {
                      //   final resp = await ref
                      //       .watch(accountProvider.notifier)
                      //       .create(formData: formKey.currentState!.value);

                      //   if (resp == true) {
                      //     showToast(msg: 'Account Created successfully!');
                      //   } else {
                      //     showToast(msg: 'Invalid! may be duplicate');
                      //   }
                      // } else {
                      //   debugPrint(formKey.currentState?.value.toString());
                      //   showToast(msg: 'validation failed');
                      // }
                    }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
