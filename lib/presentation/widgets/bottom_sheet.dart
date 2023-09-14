import 'package:flutter/material.dart';
import '../../config/values/layout.dart';
import 'handle.dart';

Future<T?> showIBottomSheet<T>(
    {required BuildContext context, required Widget child}) {
  final mediaQuery = MediaQuery.of(context);
  final maxHeight = mediaQuery.size.height - mediaQuery.viewPadding.top;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: maxHeight),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (context) {
        return Padding(
          padding: kPaddingContent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: double.infinity,
                child: Align(alignment: Alignment.center, child: Handle()),
              ),
              Flexible(
                child: child,
              )
            ],
          ),
        );
      });
}
