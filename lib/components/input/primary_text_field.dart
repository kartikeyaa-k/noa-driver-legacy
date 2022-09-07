// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noa_driver/core/style/styles.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    Key? key,
    TextEditingController? controller,
    required this.labelText,
    this.hintText,
    this.hintTextStyle,
    this.focusedColor = Paints.grey3,
    this.enabledColor = Paints.grey3,
    this.errorColor = Paints.red,
    this.fillColor,
    this.obscureText = false,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.onChanged,
    this.inputFormatters,
    this.maxLength,
    this.minLines,
    this.maxLines = 1,
    this.keyboardType,
    this.enabled = false,
    this.initialValue,
    this.floatingLabelBehavior,
    this.floatingLabelStyle,
    this.onTap,
  }) : _controller = controller;

  final String labelText;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final Color focusedColor;
  final Color enabledColor;
  final Color errorColor;
  final Color? fillColor;
  final bool obscureText;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? initialValue;
  final bool enabled;
  final TextEditingController? _controller;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextStyle? floatingLabelStyle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const _borderRadius = Corners.lgBorder;

    return TextFormField(
      onTap: onTap,
      controller: _controller,
      obscureText: obscureText,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      initialValue: initialValue,
      style: TextStyles.body16x400
          .copyWith(color: Paints.primary, backgroundColor: Colors.transparent),
      decoration: InputDecoration(
        enabled: enabled,
        labelText: labelText,
        hintText: hintText,
        hintStyle: hintTextStyle,
        floatingLabelBehavior: floatingLabelBehavior,
        floatingLabelStyle: floatingLabelStyle,
        // isDense: true,
        labelStyle: TextStyles.body14x400
            .copyWith(color: Paints.grey, backgroundColor: Colors.transparent),
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints,
        filled: fillColor != null,
        // floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: fillColor ?? Colors.white,
        border: const OutlineInputBorder(
          borderRadius: _borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: focusedColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: enabledColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: errorColor),
        ),
        contentPadding: const EdgeInsets.all(18),
      ),
    );
  }
}
