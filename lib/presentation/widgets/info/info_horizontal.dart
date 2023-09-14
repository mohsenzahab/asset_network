import 'package:flutter/material.dart';

import '../../../config/values/styles.dart';

class InfoHorizontal extends StatelessWidget {
  const InfoHorizontal({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              '$title: ',
              style: kStyleInfoTitle,
              overflow: TextOverflow.clip,
            ),
          ),
          Text(
            value,
            style: kStyleInfoValue,
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
