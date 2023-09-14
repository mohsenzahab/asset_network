import 'package:flutter/material.dart';
import '../../config/values/styles.dart';
import '../localization/localizations.dart';

import '../../config/values/layout.dart';

const kDefaultSnackbarDuration = Duration(seconds: 3);

// A tool for showing app messages to user.
class Messenger {
  Messenger(this.context, this.l);
  final BuildContext context;
  final ILocalizations l;

  /// Show dedicated snackbar for info message
  void showSnackBarInfo(String? message) => _createSnackbar(message,
      label: 'ok',
      backgroundColor: Colors.blue,
      defaultMessage: 'message_info');

  /// Show dedicated snackbar for success message
  void showSnackBarSuccess(String? message) => _createSnackbar(message,
      label: 'ok',
      backgroundColor: Colors.green,
      defaultMessage: 'message_success');

  /// Show dedicated snackbar for failure message
  void showSnackBarFailure(String? message) => _createSnackbar(message,
      label: 'ok',
      backgroundColor: Colors.red,
      defaultMessage: 'message_failure');

  /// Show dedicated snackbar for undoing some action
  void showSnackBarUndo(String? message, [VoidCallback? onUndo]) =>
      _createSnackbar(message,
          label: 'ok',
          reason: SnackBarClosedReason.action,
          backgroundColor: Colors.orange,
          postCallback: onUndo,
          defaultMessage: 'message_undo');

  ScaffoldMessengerState _createSnackbar(String? message,
      {required String label,
      required Color backgroundColor,
      Duration duration = kDefaultSnackbarDuration,
      String defaultMessage = 'message_success',
      SnackBarClosedReason reason = SnackBarClosedReason.hide,
      VoidCallback? postCallback}) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
            action: SnackBarAction(
              label: l(label),
              textColor: Colors.black,
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .hideCurrentSnackBar(reason: reason);
              },
            ),
            behavior: SnackBarBehavior.floating,
            duration: duration,
            padding: kPaddingContent,
            backgroundColor: backgroundColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message != null ? l(message) : l(defaultMessage),
                  style: kStyleSnackBar,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 16,
                ),
                SnackbarProgressIndicator(duration: duration),
              ],
            )),
      ).closed.then((value) {
        if (value == SnackBarClosedReason.action) {
          postCallback?.call();
        }
      });
  }
}

class SnackbarProgressIndicator extends StatefulWidget {
  const SnackbarProgressIndicator(
      {super.key, this.duration = const Duration(milliseconds: 2000)});
  final Duration duration;

  @override
  State<SnackbarProgressIndicator> createState() =>
      _SnackbarProgressIndicatorState();
}

class _SnackbarProgressIndicatorState extends State<SnackbarProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() {
        setState(() {});
      });
    controller.forward();
    // controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: controller.value,
    );
  }
}
