import 'package:flutter/material.dart';
import 'package:noa_driver/core/style/styles.dart';

class BaseButton extends StatefulWidget {
  /// Base Button helps create other buttons using base design pattern
  const BaseButton({
    Key? key,
    this.backgroundColor = Colors.transparent,
    required this.onTap,
    this.width,
    this.height = 48,
    this.border,
    this.borderRadius = Corners.xlBorder,
    this.child,
    this.isLoading = false,
    required this.loader,
    required this.disabled,
    required this.disableColor,
    this.boxShadow,
  });

  final Color backgroundColor;
  final VoidCallback onTap;
  final double? width;
  final double height;
  final Border? border;
  final BorderRadius? borderRadius;
  final Widget? child;
  final bool isLoading;
  final Widget loader;
  final bool disabled;
  final Color disableColor;
  final List<BoxShadow>? boxShadow;

  @override
  State<BaseButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<BaseButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Tween<double> _scaleTween;
  late Animation _scaleAnimation;
  double scale = 1;
  Color? currentColor;
  Border? currentBorder;
  late double height;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(vsync: this, duration: Times.fastest)
      ..addListener(() {
        setState(() {
          scale = _scaleController.value;
        });
      });
    _scaleTween = Tween(begin: 1, end: 0.94);
    _scaleAnimation = _scaleTween.animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // If widget is not disabled then start scale animation
        // await the animation to complete
        // and call [onTap] method
        if (!widget.disabled) {
          await _scaleController.forward();
          await _scaleController.reverse();
          if (!widget.isLoading) widget.onTap();
        }
      },
      onTapDown: (tapDetail) async {
        if (!widget.disabled) await _scaleController.fling(velocity: 2);
      },
      onTapCancel: () async {
        if (!widget.disabled) await _scaleController.reverse();
      },
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: AnimatedContainer(
          duration: Times.fastest,
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color:
                widget.disabled ? widget.disableColor : widget.backgroundColor,
            borderRadius: widget.borderRadius,
            border: currentBorder ?? widget.border,
            boxShadow: widget.boxShadow,
          ),
          alignment: Alignment.center,
          child: widget.isLoading ? widget.loader : widget.child,
        ),
      ),
    );
  }
}
