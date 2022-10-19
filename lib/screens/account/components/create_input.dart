import 'package:findo/constants/constants.dart';
import 'package:findo/data/models/accounts_model.dart';
import 'package:findo/screens/account/account_controller.dart';
import 'package:findo/services/settings_service.dart';
import 'package:findo/theme/app_theme.dart';
import 'package:findo/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

FormBuilderCheckbox isLockedInput() {
  return FormBuilderCheckbox(
    name: 'isLocked',
    initialValue: false,
    title: const Text("Is Lock"),
    decoration: checkBoxDecoration(),
  );
}

FormBuilderCheckbox isActiveInput() {
  return FormBuilderCheckbox(
    name: 'isActive',
    initialValue: true,
    title: const Text("Is Active"),
    decoration: checkBoxDecoration(),
  );
}

FormBuilderTextField openingBalanceInput() {
  return FormBuilderTextField(
    name: 'openingBalance',
    style: inputTextStyle,
    decoration: InputDecoration(
      labelText: 'Opening Balance',
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: Icon(
        currencySymbol(),
        size: 16.0.sp,
      ),
    ),
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.next,
    textCapitalization: TextCapitalization.words,
  );
}

FormBuilderTextField budgetInput() {
  return FormBuilderTextField(
    name: 'budget',
    style: inputTextStyle,
    decoration: InputDecoration(
      labelText: 'Monthly Budget',
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: Icon(
        currencySymbol(),
        size: 16.0.sp,
      ),
    ),
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.next,
    textCapitalization: TextCapitalization.words,
  );
}

FormBuilderDropdown<bool> hasChildInput(WidgetRef ref) {
  return FormBuilderDropdown(
    name: 'hasChild',
    isExpanded: true,
    initialValue: ref.read(hasChildProvider),
    decoration: const InputDecoration(
      labelText: 'Has Child',
    ),
    validator:
        FormBuilderValidators.compose([FormBuilderValidators.required()]),
    items: yesNo
        .map((yn) => DropdownMenuItem<bool>(
              alignment: AlignmentDirectional.centerStart,
              value: yn['key'] as bool,
              child: Text(yn['value'].toString()),
            ))
        .toList(),
    onChanged: (val) {
      ref.read(hasChildProvider.state).state = val as bool;
    },
    // valueTransformer: (val) => val?.toString(),
  );
}

FormBuilderDropdown<Object> accountTypeInput(AccountsModel parent) {
  return FormBuilderDropdown(
    name: 'accountType',
    initialValue: parent.type,
    isExpanded: true,
    enabled: false,
    decoration: const InputDecoration(
      labelText: 'Account Type',
    ),
    validator:
        FormBuilderValidators.compose([FormBuilderValidators.required()]),
    items: accountType
        .map((acType) => DropdownMenuItem(
              alignment: AlignmentDirectional.centerStart,
              value: acType['code'],
              child: Text(acType['name']),
            ))
        .toList(),
    onChanged: (val) {},
    valueTransformer: (val) => val?.toString(),
  );
}

FormBuilderTextField nameInput() {
  return FormBuilderTextField(
    name: 'name',
    style: inputTextStyle,
    validator: FormBuilderValidators.compose([
      FormBuilderValidators.required(),
    ]),
    decoration: const InputDecoration(
      labelText: 'Account Name',
      floatingLabelBehavior: FloatingLabelBehavior.always,
      errorStyle: TextStyle(color: Colors.transparent, fontSize: 0, height: 0),
      errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    ),
    keyboardType: TextInputType.name,
    textInputAction: TextInputAction.next,
    textCapitalization: TextCapitalization.words,
  );
}

FormBuilderTextField descriptionInput() {
  return FormBuilderTextField(
    name: 'description',
    style: inputTextStyle,
    validator: FormBuilderValidators.compose([
      FormBuilderValidators.required(),
    ]),
    decoration: const InputDecoration(
      labelText: 'Description',
      floatingLabelBehavior: FloatingLabelBehavior.always,
      errorStyle: TextStyle(color: Colors.transparent, fontSize: 0, height: 0),
      errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    ),
    keyboardType: TextInputType.name,
    textInputAction: TextInputAction.next,
    textCapitalization: TextCapitalization.words,
  );
}

FormBuilderTextField groupInput(AccountsModel parent) {
  return FormBuilderTextField(
    name: 'group',
    style: inputTextStyle,
    enabled: false,
    decoration: const InputDecoration(labelText: 'Parent Account'),
    initialValue: parent.name,
    keyboardType: TextInputType.name,
    textInputAction: TextInputAction.next,
    textCapitalization: TextCapitalization.words,
  );
}
