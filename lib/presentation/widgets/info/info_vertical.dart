import 'package:flutter/material.dart';

import '../../../config/values/styles.dart';

class InfoVertical extends StatelessWidget {
  const InfoVertical({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: kStyleInfoTitle,
            overflow: TextOverflow.clip,
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
