import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kExpansionDuration = Duration(milliseconds: 500);
const kExpansionHeight = 200.0;

class MultilineTextFormField extends StatefulWidget {
  const MultilineTextFormField(
      {Key? key,
      this.label,
      this.hint,
      this.onSaved,
      this.validator,
      this.keyboardType,
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
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<MultilineTextFormField> createState() => _MultilineTextFormFieldState();
}

class _MultilineTextFormFieldState extends State<MultilineTextFormField> {
  late final TextEditingController controller;
  late final FocusNode focusNode;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialValue);
    focusNode = FocusNode();
    focusNode.addListener(() {
      debugPrint('focused');
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const inputBorder = OutlineInputBorder(borderSide: BorderSide(width: 2));
    return AnimatedSize(
      alignment: Alignment.topCenter,
      reverseDuration: kExpansionDuration,
      duration: kExpansionDuration,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: kExpansionHeight),
        child: TextFormField(
          // initialValue: widget.initialValue,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText, textDirection: TextDirection.rtl,
          // textAlignVertical: TextAlignVertical.center,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.newline,
          maxLines: null,
          expands: focusNode.hasFocus,
          textAlign: TextAlign.justify,
          inputFormatters: widget.inputFormatters,
          focusNode: focusNode,
          controller: controller,
          onTap: () {
            if (controller.selection ==
                TextSelection.fromPosition(
                    TextPosition(offset: controller.text.length - 1))) {
              // setState(() {
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
              // });
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
                  contentPadding: const EdgeInsets.only(
                      top: 15, bottom: 10, right: 18, left: 18),
                  hintText: widget.hint)
              .applyDefaults(Theme.of(context).inputDecorationTheme),
          onSaved: widget.onSaved,
          readOnly: widget.readOnly,
          validator: widget.validator,
        ),
      ),
    );
  }
}
