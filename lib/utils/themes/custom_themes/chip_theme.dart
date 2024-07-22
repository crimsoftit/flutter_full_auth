import 'package:flutter_full_auth/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class RChipTheme {
  RChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: CColors.grey.withOpacity(0.4),
    //disabledColor: rGrey.withOpacity(0.4),
    labelStyle: const TextStyle(
      color: CColors.rBrown,
    ),
    selectedColor: CColors.rBrown,
    padding: const EdgeInsets.symmetric(
      horizontal: 12.0,
      vertical: 12.0,
    ),
    checkmarkColor: CColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: CColors.darkerGrey,
    labelStyle: TextStyle(
      color: CColors.white,
    ),
    selectedColor: CColors.rBrown,
    padding: EdgeInsets.symmetric(
      horizontal: 12.0,
      vertical: 12.0,
    ),
    checkmarkColor: CColors.white,
  );
}
