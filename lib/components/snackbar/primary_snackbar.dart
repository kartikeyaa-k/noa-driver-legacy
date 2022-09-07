import 'package:flutter/material.dart';
import 'package:noa_driver/core/style/styles.dart';

SnackBar getSnackBar(String message) {
  return SnackBar(
    content: Text(
      message,
      style: TextStyles.body16x400
          .copyWith(fontSize: FontSizes.s16, color: Paints.background),
    ),
    padding: const EdgeInsets.all(25),
    elevation: 20,
    backgroundColor: Paints.primary,
    behavior: SnackBarBehavior.floating,
  );
}
