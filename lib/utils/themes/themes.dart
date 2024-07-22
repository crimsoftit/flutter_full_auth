import 'package:flutter_full_auth/utils/constants/colors.dart';
import 'package:flutter_full_auth/utils/themes/custom_themes/appbar_theme.dart';
import 'package:flutter_full_auth/utils/themes/custom_themes/bottom_sheet_theme.dart';
import 'package:flutter_full_auth/utils/themes/custom_themes/checkbox_theme.dart';
import 'package:flutter_full_auth/utils/themes/custom_themes/chip_theme.dart';
import 'package:flutter_full_auth/utils/themes/custom_themes/elevated_button_theme.dart';
import 'package:flutter_full_auth/utils/themes/custom_themes/outlined_btn_theme.dart';
import 'package:flutter_full_auth/utils/themes/custom_themes/text_field_theme.dart';
import 'package:flutter_full_auth/utils/themes/custom_themes/txt_themes.dart';
import 'package:flutter/material.dart';

class CAppTheme {
  CAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: CColors.rBrown,
    textTheme: RTextTheme.ligtTextTheme,
    chipTheme: RChipTheme.lightChipTheme,
    scaffoldBackgroundColor: CColors.white,
    appBarTheme: RAppBarTheme.lightAppBarTheme,
    checkboxTheme: RCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: RBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: RElevatedButtonTheme.elevatedBtnLightTheme,
    outlinedButtonTheme: ROutlinedButtonTheme.outlinedBtnLightTheme,
    inputDecorationTheme: RTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: CColors.rBrown,
    textTheme: RTextTheme.darkTextTheme,
    chipTheme: RChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: RAppBarTheme.darkAppBarTheme,
    checkboxTheme: RCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: RBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: RElevatedButtonTheme.elevatedBtnDarkTheme,
    outlinedButtonTheme: ROutlinedButtonTheme.outlinedBtnDarkTheme,
    inputDecorationTheme: RTextFormFieldTheme.darkInputDecorationTheme,
  );
}
