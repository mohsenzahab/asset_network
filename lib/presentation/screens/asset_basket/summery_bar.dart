import 'package:flutter/material.dart';
import '../../../core/utils/formatter.dart';
import '../../../locator.dart';
import '../../../../config/values/layout.dart';
import '../../../../config/values/styles.dart';
import '../../../../core/utils/colors.dart';
import '../../widgets/default_container.dart';

class SummeryBar extends StatelessWidget {
  const SummeryBar(
      {super.key,
      required this.e1,
      required this.e2,
      required this.e3,
      this.title});
  final String? title;
  final SummeryElement e1;
  final SummeryElement e2;
  final SummeryElement e3;

  @override
  Widget build(BuildContext context) {
    return DefaultContainer(
      padding: kPaddingSummeryContent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title != null) Text(title!, style: kStyleSummeryTitle),
          kSpaceVertical16,
          SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                SummeryElementWidget(
                  element: e1,
                ),
                const Spacer(),
                const SDivider(),
                const Spacer(),
                SummeryElementWidget(
                  element: e2,
                ),
                const Spacer(),
                const SDivider(),
                const Spacer(),
                SummeryElementWidget(
                  element: e3,
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SummeryElementWidget extends StatelessWidget {
  const SummeryElementWidget({super.key, required this.element});
  final SummeryElement element;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(Formatter.formateNumber(context, element.value),
            style: kStyleUnitsVal),
        Text(element.name, style: kStyleUnitsName)
      ],
    );
  }
}

class SDivider extends StatelessWidget {
  const SDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      thickness: 1,
      color: sl<IColors>()('borderColor'),
    );
  }
}

class SummeryElement {
  SummeryElement({
    required this.name,
    required this.value,
  });
  final String name;
  final double value;
}
