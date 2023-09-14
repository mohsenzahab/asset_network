import 'package:flutter/material.dart';

class Handle extends StatelessWidget {
  const Handle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: const Divider(
          thickness: 5,
        ),
      ),
    );
  }
}
