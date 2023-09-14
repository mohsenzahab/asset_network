import 'package:flutter/material.dart';
import '../../../../config/values/layout.dart';
import '../../core/utils/colors.dart';
import '../../locator.dart';

class DefaultContainer extends StatelessWidget {
  const DefaultContainer({super.key, required this.child, this.padding});
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final colors = sl<IColors>();
    return DecoratedBox(
      decoration: BoxDecoration(
          color: colors('backgroundUnseen'),
          border: Border.all(
            color: colors('borderColor'),
          )),
      child: Padding(
        padding: padding ?? kPaddingContent,
        child: child,
      ),
    );
  }
}
