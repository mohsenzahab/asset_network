import 'package:flutter/material.dart';

import '../../../../config/values/layout.dart';
import '../../core/utils/colors.dart';
import '../../locator.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = sl<IColors>();
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: colors('backgroundUnseen'),
            border: Border.all(
              color: colors('borderColor'),
            )),
        child: Padding(
          padding: kPaddingButtonAdd,
          child: Image.asset(
            'assets/image/add_circle_square.png',
            height: kSizeButtonAddSize,
            width: kSizeButtonAddSize,
          ),
        ),
      ),
    );
  }
}
