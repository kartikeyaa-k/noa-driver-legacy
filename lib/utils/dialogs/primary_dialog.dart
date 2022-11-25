import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noa_driver/core/style/styles.dart';

class PrimaryDialog {
  BuildContext context;
  String? title;
  String? description;
  Widget? content;
  String? imageUrl;

  bool? isDefaultPositive;
  String? positiveButton;
  VoidCallback? positiveOnClickCallback;

  String? negativeButton;
  VoidCallback? negativeOnClickCallback;

  Color? barrierColor;
  bool? barrierDismissable;
  bool isDefaultButtonView = false;

  bool? bottomDialogPosition;
  bool? isHtml;
  static BuildContext? _dialogContext;

  PrimaryDialog(
      {required this.context,
      this.title = "",
      this.description,
      this.isDefaultPositive,
      this.positiveButton,
      this.positiveOnClickCallback,
      this.negativeButton,
      this.negativeOnClickCallback,
      this.barrierColor = Colors.black54,
      this.content,
      this.imageUrl,
      this.barrierDismissable,
      this.bottomDialogPosition}) {
    _dialogContext = context;

    var actionsButton = <Widget>[];
    if (negativeButton != null && negativeButton!.isNotEmpty) {
      actionsButton.add(Expanded(
          child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: const BorderSide(width: 1, color: Paints.primary),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.5),
          child: Text(
            negativeButton.toString(),
            style: TextStyles.body16x700,
          ),
        ),
        onPressed: () => negativeOnClickCallback?.call(),
      )));
      actionsButton.add(const SizedBox(width: 16));
    }

    if (isDefaultPositive != null && isDefaultPositive!) {
      actionsButton.add(Expanded(
          child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: const BorderSide(width: 1, color: Paints.primary),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.5),
          child: Text(
            positiveButton.toString(),
            style: TextStyles.body16x700,
          ),
        ),
        onPressed: () => positiveOnClickCallback?.call(),
      )));
    } else if (positiveButton != null) {
      actionsButton.add(
        _buildPositiveButton(positiveButton),
      );
    }

    final alertDialog = _buildAlertDialog(title ?? '', actionsButton);
    showDialog<bool>(
      useRootNavigator: false,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissable ?? true,
      context: context,
      builder: (_) => WillPopScope(
          onWillPop: () async => Future.value(barrierDismissable ?? true),
          child: Padding(
              padding: EdgeInsets.only(
                  bottom: bottomDialogPosition ?? false ? 24.0 : 0.0),
              child: bottomDialogPosition ?? false
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [alertDialog],
                    )
                  : alertDialog)),
    );
  }

  Widget _buildNegativeButton(String? negativeButton,
      {EdgeInsets? btnPadding}) {
    if (negativeButton == null) {
      return const SizedBox.shrink();
    }
    return Expanded(
        child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        side: const BorderSide(width: 1, color: Paints.primary),
      ),
      child: Padding(
        padding: btnPadding ?? const EdgeInsets.all(14.5),
        child: Text(
          negativeButton,
          style: TextStyles.body16x700,
        ),
      ),
      onPressed: () => negativeOnClickCallback?.call(),
    ));
  }

  Widget _buildPositiveButton(String? positiveButton,
      {EdgeInsets? btnPadding}) {
    if (positiveButton == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
        child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        side: const BorderSide(width: 1, color: Paints.primary),
      ),
      child: Padding(
        padding: btnPadding ?? const EdgeInsets.all(14.5),
        child: Text(
          positiveButton,
          style: TextStyles.body16x700,
        ),
      ),
      onPressed: () => positiveOnClickCallback?.call(),
    ));
    // return Expanded(
    //   child: GestureDetector(
    //     onTap: positiveOnClickCallback,
    //     child: Container(
    //       decoration: const BoxDecoration(
    //         borderRadius: BorderRadius.all(Radius.circular(8)),
    //         // gradient: LinearGradient(
    //         //     begin: Alignment.topLeft,
    //         //     end: Alignment.bottomRight,
    //         //     colors: [
    //         //       Paints.primaryBlueDarker,
    //         //       Paints.primaryBlue,
    //         //     ]),
    //       ),
    //       child: Padding(
    //         padding: btnPadding ?? const EdgeInsets.all(14.5),
    //         child: Center(
    //           child: Text(
    //             positiveButton,
    //             style: TextStyles.body16x700,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget _buildAlertDialog(
    String? title,
    List<Widget> actionsButton, {
    bool columnButton = false,
    EdgeInsets contentPadding = const EdgeInsets.fromLTRB(16, 10, 16, 0),
    EdgeInsets buttonPadding = const EdgeInsets.fromLTRB(8, 16, 8, 14),
  }) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      insetPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      title: title != null
          ? Text(
              title,
              style: TextStyles.body16x400.copyWith(height: 1.3),
            )
          : null,
      titlePadding:
          title != null ? const EdgeInsets.fromLTRB(16, 16, 16, 0) : null,
      content: description != null
          ? Text(description ?? '',
              style: TextStyles.body12x400.copyWith(height: 1.375))
          : content,
      contentPadding: contentPadding,
      actionsPadding: actionsButton.isNotEmpty
          ? buttonPadding
          : const EdgeInsets.only(bottom: 8),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: columnButton ? 96 + 10 : null,
          child: columnButton
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: actionsButton,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: actionsButton,
                ),
        )
      ],
    );
  }

  PrimaryDialog.LoadingDialog(this.context, {bool useSafeArea = false}) {
    _dialogContext = context;
    showDialog<void>(
      useRootNavigator: false,
      barrierDismissible: false,
      context: context,
      useSafeArea: useSafeArea,
      builder: (_) => Container(
        width: double.infinity,
        height: double.infinity,
        color: Paints.primary.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Theme(
              data: ThemeData(
                cupertinoOverrideTheme:
                    const CupertinoThemeData(brightness: Brightness.dark),
              ),
              child: const CupertinoActivityIndicator(
                radius: 16.0,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Loading..',
              style: TextStyles.body14x400.copyWith(
                fontFamily: 'FSAlbertPro',
                height: 1.375,
                decoration: TextDecoration.none,
              ),
            )
          ],
        ),
      ),
    );
  }
}
