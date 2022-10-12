import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final authProvider = Provider((ref) {
  final LocalAuthentication auth = LocalAuthentication();
  return auth;
});
final canCheckBiometrics = FutureProvider<bool>((ref) async {
  final LocalAuthentication auth = LocalAuthentication();
  final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
  final bool canAuthenticate =
      canAuthenticateWithBiometrics || await auth.isDeviceSupported();
  return canAuthenticate;
});

  // canAuthBiometrics() async {
  //   final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
  //   final bool canAuthenticate =
  //       canAuthenticateWithBiometrics || await auth.isDeviceSupported();

  //   return canAuthenticate;
  // }

  // Future<bool> checkBiometrics() async {
  //   bool canCheckBiometrics;
  //   try {
  //     canCheckBiometrics = await auth.canCheckBiometrics.then((value) => value);
  //   } on PlatformException catch (e) {
  //     canCheckBiometrics = false;
  //     print(e);
  //   }

  //   return canCheckBiometrics;
  // }

  // Future<List<BiometricType>> getAvailableBiometrics() async {
  //   late List<BiometricType> availableBiometrics;
  //   try {
  //     availableBiometrics =
  //         await auth.getAvailableBiometrics().then((value) => value);
  //   } on PlatformException catch (e) {
  //     availableBiometrics = <BiometricType>[];
  //     print(e);
  //   }

  //   return availableBiometrics;
  // }

  // Future<bool> authenticate() async {
  //   bool authenticated = false;
  //   try {
  //     authenticated = await auth
  //         .authenticate(
  //           localizedReason: 'Let OS determine authentication method',
  //           options: const AuthenticationOptions(
  //             stickyAuth: true,
  //           ),
  //         )
  //         .then((value) => value);
  //   } on PlatformException catch (e) {
  //     print(e);

  //     return false;
  //   }

  //   return authenticated;
  // }

  // Future<void> cancelAuthentication() async {
  //   await auth.stopAuthentication();
  // }

