import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MTextFormField extends StatefulWidget {
  const MTextFormField(
      {Key? key,
      this.label,
      this.hint,
      this.onSaved,
      this.validator,
      this.keyboardType,
      this.textDirection,
      this.obscureText = false,
      this.suffix,
      this.initialValue,
      this.inputFormatters,
      this.readOnly = false})
      : super(key: key);

  final String? label;
  final String? hint;
  final String? suffix;
  final String? initialValue;
  final bool obscureText;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextDirection? textDirection;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<MTextFormField> createState() => _MTextFormFieldState();
}

class _MTextFormFieldState extends State<MTextFormField> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(borderSide: BorderSide(width: 2));
    final color = Theme.of(context);
    return TextFormField(
      // initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText, textDirection: widget.textDirection,
      // textAlignVertical: TextAlignVertical.center,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      inputFormatters: widget.inputFormatters,
      controller: controller,
      onTap: () {
        if (controller.selection ==
            TextSelection.fromPosition(
                TextPosition(offset: controller.text.length - 1))) {
          setState(() {
            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length));
          });
        }
      },
      decoration: InputDecoration(
              border: inputBorder,
              // focusedBorder: inputBorder.copyWith(
              //     borderSide: BorderSide(color: color.focusColor)),
              suffixText: widget.suffix,
              labelText: widget.label,
              alignLabelWithHint: true,
              isCollapsed: true,
              contentPadding:
                  EdgeInsets.only(top: 15, bottom: 10, right: 18, left: 18),
              hintText: widget.hint)
          .applyDefaults(Theme.of(context).inputDecorationTheme),
      onSaved: widget.onSaved,
      readOnly: widget.readOnly,
      validator: widget.validator,
    );
  }
}
