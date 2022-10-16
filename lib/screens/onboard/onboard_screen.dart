import 'package:finsoft2/services/auth_server.dart';
import 'package:finsoft2/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class OnBoardScreen extends ConsumerWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supported = ref.watch(canCheckBiometrics);

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.sp),
          child: supported.when(
            data: (data) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("WELCOME",
                    style: Theme.of(context).textTheme.headlineMedium),
                UIHelper.verticalSpaceMedium(),
                data ? const Text("Supported") : const Text("NOT SUPPORTED"),
                SizedBox(
                  width: 150.0.sp,
                  height: 2.0.sp,
                  child: const LinearProgressIndicator(),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final authenticated =
                          await ref.read(authProvider).authenticate(
                                localizedReason:
                                    'Let OS determine authentication method',
                                options: const AuthenticationOptions(
                                  stickyAuth: true,
                                ),
                              );

                      print(authenticated);
                    } on PlatformException catch (e) {
                      if (e.code == auth_error.notAvailable) {
                        // Add handling of no hardware here.
                      } else if (e.code == auth_error.notEnrolled) {
                        // ...
                      } else {
                        // ...
                      }
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Text('Authenticate'),
                      Icon(Icons.perm_device_information),
                    ],
                  ),
                ),
              ],
            ),
            error: (error, stackTrace) => const Text("ERROR"),
            loading: () => const Text("Loading.."),
          ),
        ),
      ),
    );
  }
}
