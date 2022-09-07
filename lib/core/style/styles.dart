import 'package:flutter/material.dart';

/// Styles - Contains the design system for the entire app.
/// Includes paddings, text styles, timings etc. Does not include colors, check
/// AppTheme file for that.

/// Used for all animations in the  app
class Times {
  static const fastest = Duration(milliseconds: 150);
  static const fast = Duration(milliseconds: 250);
  static const medium = Duration(milliseconds: 400);
  static const slow = Duration(milliseconds: 700);
  static const slower = Duration(milliseconds: 1000);
}

class Sizes {
  static double hitScale = 1;
  static double get hit => 40 * hitScale;
}

class IconSizes {
  static const double scale = 1;
  static const double med = 24;
}

class Insets {
  static double scale = 1;
  static double offsetScale = 1;
  // Regular paddings
  static double get xxs => 6 * scale;
  static double get xs => 8 * scale;
  static double get sm => 16 * scale;
  static double get md => 24 * scale;
  static double get lg => 32 * scale;
  static double get xl => 40 * scale;
  static double get xxl => 64 * scale;
  // maxWidth used for screens that need constrainted width
  static double get maxWidth => 1666;

  // Product
  static const double bagProductCardHeight = 131;
  static const double bundledProductCardHeight = 106;
}

class Corners {
  static const double sm = 4;
  static const BorderRadius smBorder = BorderRadius.all(smRadius);
  static const Radius smRadius = Radius.circular(sm);

  static const double md = 5;
  static const BorderRadius mdBorder = BorderRadius.all(mdRadius);
  static const Radius mdRadius = Radius.circular(md);

  static const double lg = 8;
  static const BorderRadius lgBorder = BorderRadius.all(lgRadius);
  static const Radius lgRadius = Radius.circular(lg);

  static const double xl = 10;
  static const BorderRadius xlBorder = BorderRadius.all(xlRadius);
  static const Radius xlRadius = Radius.circular(xl);

  static const double xxl = 20;
  static const BorderRadius xxlBorder = BorderRadius.all(xxlRadius);
  static const Radius xxlRadius = Radius.circular(xxl);

  static const double xxxl = 32;
  static const BorderRadius xxxlBorder = BorderRadius.all(xxxlRadius);
  static const Radius xxxlRadius = Radius.circular(xxxl);
}

class Strokes {
  static const double thin = 1;
  static const double thick = 4;
}

class Shadows {
  static List<BoxShadow> get universal => const [
        BoxShadow(
          color: Color.fromRGBO(89, 27, 27, 0.05),
          offset: Offset(0, 5),
          blurRadius: 10,
        ),
      ];
  // use case is for navigation bar
  static List<BoxShadow> get smallReverse => const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.25),
          blurRadius: 4,
          spreadRadius: 2,
          offset: Offset(0, -2),
        ),
        BoxShadow(color: Colors.white),
      ];
}

/// Font Sizes
/// You can use these directly if you need, but usually there should be a
/// predefined style in TextStyles.
class FontSizes {
  /// Provides the ability to nudge the app-wide font scale in either direction
  static double get scale => 1;
  static double get s7 => 7 * scale;
  static double get s9 => 9 * scale;
  static double get s10 => 10 * scale;
  static double get s11 => 11 * scale;
  static double get s12 => 12 * scale;
  static double get s13 => 13 * scale;
  static double get s14 => 14 * scale;
  static double get s16 => 16 * scale;
  static double get s18 => 18 * scale;
  static double get s20 => 18 * scale;
  static double get s21 => 21 * scale;
  static double get s22 => 22 * scale;
  static double get s24 => 24 * scale;
  static double get s28 => 28 * scale;
  static double get s30 => 30 * scale;
  static double get s32 => 32 * scale;
  static double get s44 => 44 * scale;
  static double get s50 => 50 * scale;
  static double get s64 => 64 * scale;
}

/// Fonts - A list of Font Families, this is uses by the TextStyles class to
/// create concrete styles.
class Fonts {
  static const String roboto = 'Roboto';
  static const String poppins = 'Poppins';
}

class TextStyles {
  // downloaded from https://cofonts.com/gilroy-font/
  /// Declare a base style for each Family
  static const TextStyle _poppins = TextStyle(
    fontFamily: Fonts.poppins,
    height: 1.17,
  );

  // Poppins
  static TextStyle get h1 => _poppins.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: FontSizes.s20,
        height: 1.17,
        color: Paints.primary,
      );
  static TextStyle get h2 => _poppins.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: FontSizes.s28,
        height: 1.17,
        color: Paints.primary,
      );
  static TextStyle get body24x700 => _poppins.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: FontSizes.s24,
        height: 1.17,
        color: Paints.primary,
      );
  static TextStyle get body16x700 => _poppins.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: FontSizes.s16,
        height: 1.17,
        color: Paints.primary,
      );
  static TextStyle get body14x700 => _poppins.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: FontSizes.s14,
        height: 1.17,
        color: Paints.primary,
      );
  static TextStyle get body18x500 => _poppins.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: FontSizes.s18,
        height: 1.17,
        color: Paints.primary,
      );

  static TextStyle get body20x600 => _poppins.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: FontSizes.s18,
        height: 1.17,
        color: Paints.primary,
      );

  static TextStyle get body16x500 => _poppins.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: FontSizes.s16,
        height: 1.17,
        color: Paints.primary,
      );
  static TextStyle get body14x500 => _poppins.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: FontSizes.s14,
        height: 1.17,
        color: Paints.primary,
      );
  static TextStyle get body12x500 => _poppins.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: FontSizes.s12,
        height: 1.17,
        color: Paints.primary,
      );
  static TextStyle get body10x500 => _poppins.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: FontSizes.s10,
        height: 1.17,
        color: Paints.primary,
      );
  static TextStyle get body16x400 => _poppins.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: FontSizes.s16,
        height: 1.17,
        color: Paints.primary,
      );
  static TextStyle get body14x400 => _poppins.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: FontSizes.s14,
        height: 1.17,
        color: Paints.primary,
      );
  static TextStyle get body12x400 => _poppins.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: FontSizes.s12,
        height: 1.17,
        color: Paints.primary,
      );
  static TextStyle get body12x300 => _poppins.copyWith(
        fontWeight: FontWeight.w300,
        fontSize: FontSizes.s12,
        height: 1.17,
        color: Paints.primary,
      );
  static TextStyle get textButton10x600 => _poppins.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: FontSizes.s10,
        height: 1.17,
        color: Paints.primary,
      );
}

class Paints {
  static const primary = Color(0xFF181818);
  static const background = Color(0xFFF9FBFA);
  static const red = Color(0xFFD00000);
  static const green = Color(0xFF038600);
  static const grey = Color(0xFF555555);
  static const disable = Color(0xFFD9D9D9);
  static const grey1 = Color(0xFFE6E8E7);
  static const greyText = Color(0xFF394C5D);
  static const grey2 = Color(0xFF666666);
  static const grey3 = Color(0xFF8B8B8B);
  static const grey4 = Color(0xFF495057);
  static const textButtonColor = Color(0xFF0039CB);
  static const blue = Color(0xFF7797F6);
  static const purple = Color(0xFF9382EE);
  static const primaryBlue = Color(0XFFd2ebf0);
  static const primaryOrange = Color(0xFFffce3a);
  static const primaryBlueDarker = Color(0xFF007da1);
}

class Currency {
  static const indianRupee = '₹';
}

class FormFieldDecorator {
  static InputDecoration get textFieldStyle => const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Paints.primary),
          borderRadius: BorderRadius.all(Radius.circular(11)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Paints.primary),
          borderRadius: BorderRadius.all(Radius.circular(11)),
        ),
        fillColor: Paints.background,
        filled: true,
      );
}

class Gap {
  // SizedBox Vertical Getters
  static SizedBox get vxxs => SizedBox(
        height: Insets.xxs,
      );

  static SizedBox get vxs => SizedBox(
        height: Insets.xs,
      );

  static SizedBox get vsm => SizedBox(
        height: Insets.sm,
      );

  static SizedBox get vmd => SizedBox(
        height: Insets.md,
      );

  static SizedBox get vlg => SizedBox(
        height: Insets.lg,
      );

  static SizedBox get vxl => SizedBox(
        height: Insets.xl,
      );

  // Horizontal Width Getters
  static SizedBox get hsm => SizedBox(
        width: Insets.sm,
      );

  static SizedBox get hxs => SizedBox(
        width: Insets.xs,
      );
}

class DropdownStyle {
  static InputDecoration dropdownPrimaryStyle(String labelText) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.transparent,
      labelText: labelText,
      labelStyle: TextStyles.body14x400
          .copyWith(color: Paints.grey, backgroundColor: Colors.transparent),
      border: const OutlineInputBorder(
        borderRadius: Corners.lgBorder,
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: Corners.lgBorder,
        borderSide: BorderSide(color: Paints.grey1),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: Corners.lgBorder,
        borderSide: BorderSide(color: Paints.grey1),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: Corners.lgBorder,
        borderSide: BorderSide(color: Paints.grey),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: Corners.lgBorder,
        borderSide: BorderSide(color: Paints.grey),
      ),
      contentPadding: const EdgeInsets.all(18),
    );
  }
}
