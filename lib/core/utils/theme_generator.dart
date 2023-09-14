import 'package:flutter/material.dart';
import '../../config/values/styles.dart';
import 'colors.dart';

class ThemeGenerator {
  ThemeGenerator(this.c);
  final IColors c;

  /// Generates base theme for app from provided font and injected colors.
  ThemeData generateTheme(
      {required ThemeMode mode, required String fontFamily}) {
    final inputBorder = const OutlineInputBorder(borderSide: BorderSide());

    return ThemeData(
      fontFamily: fontFamily,
    ).copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: c('colorPrimary'),
          foregroundColor: c('tooltipBackground'),
        ),
        backgroundColor: c('backgroundColor'),
        focusColor: Colors.blue,
        primaryColor: c('colorPrimary'),
        primaryColorDark: c('colorPrimaryDark'),
        errorColor: c('errorColor'),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: c('backgroundColorBottomSheet'),
        ),
        chipTheme:
            const ChipThemeData(elevation: 5, selectedColor: Colors.cyan),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStatePropertyAll(c('tooltipBackground')))),
        inputDecorationTheme: InputDecorationTheme(
            border: inputBorder,
            enabledBorder: inputBorder,
            focusedBorder: inputBorder.copyWith(
                borderSide: const BorderSide(color: Colors.blue)),
            floatingLabelStyle: kStyleInput,
            labelStyle: kStyleInput
            // enabledBorder: ,
            ));
  }
}
