import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

class AccountListItemWidget extends StatelessWidget {
  const AccountListItemWidget({Key? key, required this.account, this.color})
      : super(key: key);

  final AccountsModel account;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      // tileColor: color ?? Colors.green,
      contentPadding: EdgeInsets.symmetric(horizontal: 8.0.w),
      leading: Container(
        width: 30.0.w,
        margin: EdgeInsets.symmetric(vertical: 4.0.sp),
        padding: EdgeInsets.all(4.0.sp),
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.all(
            Radius.circular(8.sp),
          ),
        ),
        child: Center(
          child: Text(
            account.name[0],
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
      title: Text(
        account.name,
        style: listTileStyle,
      ),
      subtitle: account.type == 'ASSET'
          ? const Text("Opening Balnce : 12,650.0")
          : const Text("Budget: 5000.0"),
      trailing: account.hasChild == true
          ? const Icon(IcoFontIcons.arrowRight)
          : const SizedBox.shrink(),
      onTap: () => account.hasChild == true
          ? Navigator.pushNamed(context, "/account_list",
              arguments: {'parent': account.id, 'name': account.name})
          : Navigator.pushNamed(context, "/account_statement",
              arguments: {'id': account.id, 'name': account.name}),
    );
  }
}
