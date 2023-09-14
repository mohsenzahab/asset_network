import 'package:flutter/material.dart';

class FormSection extends StatelessWidget {
  const FormSection(
      {super.key,
      required this.children,
      this.alignment = CrossAxisAlignment.start});
  final List<Widget> children;
  final CrossAxisAlignment alignment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: children,
      ),
    );
  }
}
