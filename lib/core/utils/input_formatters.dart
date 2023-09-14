import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Filters typed input. Only lets numbers through
class FilterNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty ||
        newValue.text.length < oldValue.text.length ||
        newValue.text == oldValue.text) {
      return newValue;
    }
    final int newChar = newValue.text.codeUnits.last;
    if (newChar >= 48 && newChar <= 57) return newValue;
    return oldValue;
  }
}

/// This formatter will translate typed input numbers to provided lang numbers.
/// only supports fa,ar and en.
class LocaleNumberFormatter extends TextInputFormatter {
  LocaleNumberFormatter({
    this.outputLangCode = 'en',
    this.inputLangCode,
  });

  /// The language code that inputs will translated to.
  /// If null, input translates to en.
  final String outputLangCode;

  /// The language code of the String which will be entered by user or system.
  /// If null, on every change will automatically figure it out.
  final String? inputLangCode;
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Character removed so no problem
    if (newValue.text.isEmpty ||
        newValue.text.length < oldValue.text.length ||
        newValue.text == oldValue.text) {
      return newValue;
      // If a new character added
    } else {
      final unicode = newValue.text.codeUnits.last;
      final inputLangCode = this.inputLangCode ?? _getInputLangCode(unicode);
      // log.d(
      //     "newLength:${newValue.text.length}->text:${newValue.text}\noldLength:${oldValue.text.length}->text:${oldValue.text}");
      // if unsupported lang code
      if (inputLangCode == null || inputLangCode == outputLangCode) {
        return newValue;
      }
      final lastIndex = newValue.text.length - 1;
      final newChar = newValue.text[lastIndex];
      final numberValue = _getNumberValue(newChar, inputLangCode);
      final String translatedNumber;

      translatedNumber = _getOutputNumberString(numberValue);

      // log.d(
      //     "$newChar\n$inputLangCode->$outputLangCode\n$numberValue->$translatedNumber");

      return newValue.replaced(
          TextRange(start: lastIndex, end: lastIndex + 1), translatedNumber);

      // return newValue.copyWith(
      //     text: oldValue.text + translatedNumber,
      //     composing: TextRange(start: -1, end: -1));
    }
  }

  /// Parses input number string to int value. If input lang is en then
  /// return the raw value.
  int _getNumberValue(String newChar, String inputLangCode) =>
      inputLangCode == 'en'
          ? int.parse(newChar)
          : NumberFormat('', inputLangCode).parse(newChar).toInt();

  /// determines the input language code and returns it. returns null if
  /// the input lang is unsupported.
  String? _getInputLangCode(int unicode) {
    bool isArabic = _checkArabicRange(unicode);
    bool isLatin = _checkBasicLatinRange(unicode);
    String? inputLangCode;
    if (isLatin && unicode >= 48 && unicode <= 57) {
      inputLangCode = 'en';
    } else if (isArabic) {
      // if it is an arabic number
      if (unicode >= 1632 && unicode <= 1641) {
        inputLangCode = 'ar';
      }
      // if it is an arabic number
      if (unicode >= 1632 && unicode <= 1641) {
        inputLangCode = 'fa';
      }
    }
    return inputLangCode;
  }

  /// translates given number to output locale string.
  String _getOutputNumberString(int number) =>
      NumberFormat('', outputLangCode).format(number);

  /// returns true if unicode is arabic
  bool _checkArabicRange(int unicode) => unicode >= 1536 && unicode <= 1791;

  /// returns true if the unicode is latin
  bool _checkBasicLatinRange(int unicode) => unicode >= 0 && unicode <= 127;

  /// returns true if there if the input and output langs are not equal.
  // bool _checkNeedTranslate(String inputLangCode) =>
  //     inputLangCode != outputLangCode;
}
