import 'package:flutter/material.dart';

class FormTopBar extends StatelessWidget {
  const FormTopBar({
    Key? key,
    required this.onBackTap,
  }) : super(key: key);
  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 50,
        ),
        const Text('stock'),
        IconButton(onPressed: onBackTap, icon: const Icon(Icons.arrow_forward)),
      ],
    );
  }
}
