import 'package:flutter/material.dart';
import 'package:noa_driver/components/buttons/primary_button.dart';

class ErrorDialogBox extends StatelessWidget {
  const ErrorDialogBox({
    Key? key,
    required this.errorTextWidget,
    required this.isError,
    required this.onTap,
  });
  final Widget errorTextWidget;
  final bool isError;
  final Function onTap;

  /// key to access button in [ErrorDialogBox]
  static const Key okButtonKey =
      ValueKey('error-approve-dialog-box-primary-button');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              isError
                  ? 'assets/latest_images/ic_error.png'
                  : 'assets/latest_images/ic_approve.png',
              height: 35,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.12,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    errorTextWidget,
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            /*PrimaryButton(
              key: okButtonKey,
              iswhite: false,
              labelWidget: Text(
                'Okay',
                style: kbuttonTextstyle(iswhite: false),
              ),
              isActive: true,
              onTap: () {
                onTap();
                Navigator.of(context).pop();
              },
            )*/
            PrimaryButton(
              onTap: () {
                Navigator.of(context).pop();
                onTap();
              },
              text: 'Ok',
            )
          ],
        ),
      ),
    );
  }
}
