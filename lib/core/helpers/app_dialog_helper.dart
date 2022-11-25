import 'package:flutter/material.dart';
import 'package:noa_driver/core/helpers/error_dialog.dart';
import 'package:noa_driver/utils/dialogs/primary_dialog.dart';

class PrimaryDialogHelper {
  static Future<dynamic> generalDialog({
    required BuildContext context,
    required String errorMessage,
    required Function() onTap,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ErrorDialogBox(
          isError: true,
          errorTextWidget: Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
          onTap: onTap,
        );
      },
    );
  }

  static Future<dynamic> areYouSureDialog({
    required BuildContext context,
    required String title,
    required String description,
    required Function() onPositiveTap,
    required Function() onNegativeTap,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Container();
      },
    );
  }
}
