import 'package:flutter/material.dart';

import '../../../config/values/styles.dart';

class MultilineTextInfo extends StatelessWidget {
  const MultilineTextInfo(this.longText, {super.key, this.color, this.title});

  final String longText;
  final String? title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: kStyleInfoTitle,
              overflow: TextOverflow.clip,
            ),
          Text(
            longText,
            style: TextStyle(
              color: color,
            ),
            softWrap: true,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
