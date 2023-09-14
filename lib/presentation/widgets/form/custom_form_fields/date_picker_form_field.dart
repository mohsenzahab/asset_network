import 'package:flutter/material.dart';
import '../../../../core/utils/formatter.dart';
import 'package:intl_date_picker/intl_date_picker.dart' as date_picker;

import '../../../../core/localization/localizations.dart';
import '../../../../locator.dart';

class DatePickerFormField extends FormField<DateTime> {
  DatePickerFormField({
    super.key,
    super.autovalidateMode,
    super.validator,
    super.initialValue,
    required date_picker.Calendar calendar,
    void Function(DateTime? date)? onChanged,
    required String title,
  }) : super(
          builder: (state) {
            void onPickerTap() {
              final today = DateUtils.dateOnly(DateTime.now());
              date_picker
                  .showIntlDatePicker(
                      context: state.context,
                      locale: Localizations.localeOf(state.context),
                      calendarMode: calendar,
                      initialDate: today,
                      firstDate:
                          today.subtract(const Duration(days: 365 * 100)),
                      lastDate: today)
                  .then((value) {
                state.didChange(value);
                onChanged?.call(value);
              });
            }

            final InputDecoration effectiveDecoration = InputDecoration(
              labelText: title,

              // hintText: 'hint',
              // floatingLabelBehavior: FloatingLabelBehavior.auto,

              contentPadding: EdgeInsets.only(right: 16.0),
            ).applyDefaults(Theme.of(state.context).inputDecorationTheme);
            final l = sl<ILocalizations>();
            String formattedDate(DateTime? value) => value == null
                ? l('pick_date')
                : Formatter.formatDateTime(state.context, value,
                    calendar: calendar);
            // return TextField(
            //   readOnly: true,
            //   decoration: effectiveDecoration,
            //   onTap: onPickerTap,
            // );
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$title: '),
                  OutlinedButton(
                      onPressed: onPickerTap,
                      child: Text(formattedDate(state.value))),
                  // const Icon(Icons.calendar_month)
                ],
              ),
            );
          },
        );
}
// class DatePickerFormField extends StatelessWidget {
//   const DatePickerFormField(
//       {super.key, this.title, this.onChanged, required this.controller});
//   final String? title;
//   final void Function(DateTime? date)? onChanged;
//   final TextEditingController controller;

//   void _onPickerTap(BuildContext context) {
//     final today = DateUtils.dateOnly(DateTime.now());
//     date_picker
//         .showJalaliDatePicker(
//             context: context,
//             locale: Localizations.localeOf(context),
//             calendarMode: date_picker.Calendar.jalali,
//             initialDate: today,
//             firstDate: today.subtract(const Duration(days: 365 * 100)),
//             lastDate: today)
//         .then((value) {
//       if (value != null) {
//         controller.text = Formatter.changeDateTime(context, value);
//       }
//       onChanged?.call(value);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final InputDecoration effectiveDecoration = InputDecoration(
//       labelText: title,
//       // contentPadding: EdgeInsets.zero,
//     ).applyDefaults(Theme.of(context).inputDecorationTheme);
//     String formattedDate(DateTime? value) => value == null
//         ? 'Pick a date'
//         : Formatter.changeDateTime(context, value);

//     // return Stack(
//     //   children: [
//     //     TextField(
//     //       controller: controller,
//     //       decoration: effectiveDecoration,
//     //     ),
//     //     Align(
//     //       alignment: Alignment.centerLeft,
//     //       child: IconButton(
//     //           onPressed: () => _onPickerTap(context),
//     //           icon: const Icon(Icons.calendar_month)),
//     //     )
//     //   ],
//     // );
//     return InkWell(
//       onTap: ()=>_onPickerTap(context),
//       child: InputDecorator(
//         decoration:
//             effectiveDecoration.copyWith(errorText: errorText),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(formattedDate(value)),
//               const Icon(Icons.calendar_month)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
