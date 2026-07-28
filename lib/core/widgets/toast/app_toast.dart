import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:smart_kitchen_flutter_app/core/widgets/toast/error_toast.dart";

class AppToast {
  static void showError(BuildContext context, String message) {
    FToast()
        .init(context)
        .showToast(
          child: ErrorToast(message: message),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 5),
          isDismissible: true,
        );
  }

  static void removeToast(BuildContext context) {
    FToast().init(context).removeCustomToast();
  }
}
