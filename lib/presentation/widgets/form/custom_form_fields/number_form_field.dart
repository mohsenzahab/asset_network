import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/utils/input_formatters.dart';
import 'text_form_field.dart';

class NumberFormField extends StatelessWidget {
  const NumberFormField(
      {Key? key,
      this.label,
      this.hint,
      this.onSaved,
      this.validator,
      this.obscureText = false,
      this.suffix,
      this.readOnly = false,
      this.initialValue})
      : super(key: key);

  final String? label;
  final String? hint;
  final String? suffix;
  final int? initialValue;
  final bool obscureText;
  final bool readOnly;
  final FormFieldSetter<int?>? onSaved;
  final FormFieldValidator<int?>? validator;

  @override
  Widget build(BuildContext context) {
    final displayedLanguageCode = Localizations.localeOf(context).languageCode;
    final formatter = intl.NumberFormat('', displayedLanguageCode);
    return MTextFormField(
      hint: hint,
      key: key,
      label: label,
      suffix: suffix,
      initialValue:
          initialValue != null ? formatter.format(initialValue) : null,
      keyboardType: TextInputType.number,
      textDirection: TextDirection.ltr,
      obscureText: obscureText,
      readOnly: readOnly,
      inputFormatters: [
        LocaleNumberFormatter(outputLangCode: 'en'),
        FilterNumberFormatter(),
        LocaleNumberFormatter(
            inputLangCode: 'en', outputLangCode: displayedLanguageCode),
      ],
      onSaved: (str) => onSaved?.call(
          str == null || str.isEmpty ? null : formatter.parse(str).toInt()),
      validator: (str) => validator?.call(
          str == null || str.isEmpty ? null : formatter.parse(str).toInt()),
    );
  }
}
