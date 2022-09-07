import 'package:flutter/material.dart';
import 'package:noa_driver/components/buttons/primary_button.dart';
import 'package:noa_driver/core/style/styles.dart';

class BottomFloatingActionButton extends StatelessWidget {
  const BottomFloatingActionButton({
    Key? key,
    required this.onTap,
    required this.buttonTitle,
  });
  final VoidCallback onTap;
  final String buttonTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Paints.background,
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 20,
            color: Paints.disable,
            blurStyle: BlurStyle.outer,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            15,
          ),
          topRight: Radius.circular(
            15,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: SizedBox(
        child: PrimaryButton(
          height: 45,
          onTap: onTap,
          text: buttonTitle,
          backgroundColor: Paints.primaryBlueDarker,
        ),
      ),
    );
  }
}
