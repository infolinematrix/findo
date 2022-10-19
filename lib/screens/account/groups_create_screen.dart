import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountGroupCreateScreen extends ConsumerWidget {
  const AccountGroupCreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Groups"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0.sp),
          child: const Text("fsdf"),
        ),
      ),
    );
  }
}
