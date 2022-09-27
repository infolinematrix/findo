import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum AlertAction { cancel, ok }

showToast({String? msg}) {
  Fluttertoast.showToast(
    msg: msg ?? "",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}

Future<AlertAction?> confirmDialog(BuildContext context, String message) async {
  return showDialog<AlertAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 8.0.h),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        title: Row(
          children: [
            Text(
              'Confirm!',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Icon(
              Icons.info,
              size: 35.sp,
              color: Colors.grey.shade200,
            ),
          ],
        ),
        content: Text(
          message.toString(),
          style: TextStyle(fontSize: 15.sp),
        ),
        actions: <Widget>[
          TextButton(
            // style: ButtonStyle(
            //     backgroundColor:
            //         MaterialStateProperty.all(AppColors.primaryColor)),
            onPressed: () {
              Navigator.of(context).pop(AlertAction.cancel);
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.black, fontSize: 13.0.sp),
            ),
          ),
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.grey.shade100)),
            onPressed: () {
              Navigator.of(context).pop(AlertAction.ok);
            },
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.black, fontSize: 13.0.sp),
            ),
          ),
        ],
      );
    },
  );
}

class AlertBox {
  final BuildContext context;
  final String? title;
  final String? desc;
  final String content;
  final AnimationTransition? alertAnimation;

  AlertBox({
    required this.context,
    this.title,
    this.desc,
    this.content = '',
    this.alertAnimation,
  });

  Future<bool?> show() async {
    return await showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return _buildDialog();
      },
      // barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      // transitionBuilder: (
      //   BuildContext context,
      //   Animation<double> animation,
      //   Animation<double> secondaryAnimation,
      //   Widget child,
      // ) =>
      //     alertAnimation == null
      //         ? _showAnimation(animation, secondaryAnimation, child)
      //         : alertAnimation!(context, animation, secondaryAnimation, child),
    );
  }

  Widget _buildDialog() {
    final Widget privateChild = ConstrainedBox(
      constraints: const BoxConstraints.expand(
          width: double.infinity, height: double.infinity),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          child: AlertDialog(
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            contentPadding: const EdgeInsets.all(0),
            shape: _defaultShape(),
            title: Container(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  title == null
                      ? Container()
                      : Text(
                          title!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                  desc == null
                      ? Container()
                      : Text(
                          desc!,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w300),
                        ),
                  content == ''
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Text(
                            content,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.center,
                      backgroundColor: Colors.green.shade100,
                    ),
                    onPressed: () =>
                        Navigator.of(context, rootNavigator: true).pop(),
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // return privateChild;
    return WillPopScope(onWillPop: () async => false, child: privateChild);
  }

  /// Returns alert default border style
  ShapeBorder _defaultShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: const BorderSide(
        color: Colors.blueGrey,
      ),
    );
  }
}

class AnimationTransition {
  /// Slide animation, from right to left (SlideTransition)
  static fromRight(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Slide animation, from left to right (SlideTransition)
  static fromLeft(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Slide animation, from top to bottom (SlideTransition)
  static fromTop(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, -1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Slide animation, from top to bottom (SlideTransition)
  static fromBottom(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Scale animation, from in to out (ScaleTransition)
  static grow(Animation<double> animation, Animation<double> secondaryAnimation,
      Widget child) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0.00,
            0.50,
            curve: Curves.linear,
          ),
        ),
      ),
      child: child,
    );
  }

  /// Scale animation, from out to in (ScaleTransition)
  static shrink(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 1.2,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0.50,
            1.00,
            curve: Curves.linear,
          ),
        ),
      ),
      child: child,
    );
  }
}
