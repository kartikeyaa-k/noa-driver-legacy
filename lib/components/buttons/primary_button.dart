import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:noa_driver/components/buttons/base_button.dart';
import 'package:noa_driver/core/style/styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.icon,
    this.textStyle,
    this.isLoading = false,
    this.disabled = false,
    this.backgroundColor = Paints.primary,
    this.width,
    this.borderRadius = Corners.xlBorder,
    this.height = 48,
    this.padding = EdgeInsets.zero,
  });
  final VoidCallback onTap;
  final String text;
  final TextStyle? textStyle;
  final Widget? icon;
  final bool isLoading;
  final bool disabled;
  final Color backgroundColor;
  final double? width;
  final double height;
  final BorderRadius? borderRadius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final Widget _child = Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: icon,
            ),
          ],
          Text(
            text,
            style: textStyle ??
                TextStyles.body18x500.copyWith(color: Colors.white),
          ),
        ],
      ),
    );

    const Widget _spinkit = Center(
      child: SpinKitThreeBounce(
        color: Colors.white,
        duration: Times.slower,
        size: 12,
      ),
    );

    return BaseButton(
      height: height,
      width: width,
      borderRadius: borderRadius,
      onTap: onTap,
      backgroundColor: backgroundColor,
      loader: _spinkit,
      isLoading: isLoading,
      disabled: disabled,
      disableColor: Paints.disable,
      child: _child,
    );
  }
}
