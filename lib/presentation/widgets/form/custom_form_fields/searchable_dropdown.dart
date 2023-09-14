// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:sabad_darai/locator.dart';

// import '../../../../core/localization/localizations.dart';

// class SearchableDropdown<T> extends StatelessWidget {
//   const SearchableDropdown(
//       {super.key,
//       this.asyncItems,
//       required this.itemAsString,
//       this.value,
//       this.autoFilterSuggestions = true,
//       this.showSearch = false,
//       this.label,
//       this.onSaved});
//   final Future<List<T>> Function(String query)? asyncItems;
//   final String Function(T item) itemAsString;
//   final T? value;
//   final bool autoFilterSuggestions;
//   final bool showSearch;
//   final String? label;
//   final void Function(T?)? onSaved;

//   @override
//   Widget build(BuildContext context) {
//     final l = sl<ILocalizations>();
//     final theme = Theme.of(context);
//     return DropdownSearch<T>(
//       onSaved: onSaved,
//       dropdownDecoratorProps: DropDownDecoratorProps(
//           textAlignVertical: TextAlignVertical.center,
//           dropdownSearchDecoration: InputDecoration(
//             alignLabelWithHint: true,
//             labelText: label,
//             isCollapsed: true,
//             contentPadding:
//                 const EdgeInsets.only(top: 15, bottom: 10, right: 18, left: 18),
//           ).applyDefaults(theme.inputDecorationTheme)),
//       asyncItems: asyncItems != null
//           ? (query) async {
//               debugPrint(query);
//               List<T> suggestions = await asyncItems!.call(query);
//               // if (autoFilterSuggestions) {
//               //   suggestions = suggestions
//               //       .where((item) => itemAsString
//               //           .call(item)
//               //           .trim()
//               //           .toLowerCase()
//               //           .contains(query.trim().toLowerCase()))
//               //       .toList();
//               // }
//               return suggestions;
//             }
//           : null,
//       filterFn: autoFilterSuggestions
//           ? (item, filter) {
//               return itemAsString(item)
//                   .trim()
//                   .toLowerCase()
//                   .contains(filter.trim().toLowerCase());
//             }
//           : null,
//       popupProps: PopupProps.menu(
//           showSearchBox: showSearch,
//           // title: label != null
//           //     ? Padding(
//           //         padding: const EdgeInsets.all(8.0),
//           //         child: Text(label!),
//           //       )
//           //     : null,
//           searchFieldProps: TextFieldProps(
//               decoration: const InputDecoration()
//                   .applyDefaults(theme.inputDecorationTheme)
//                   .copyWith(labelText: l('search'))
//               // ${label != null ? (' $label') : ''}
//               )),
//       itemAsString: itemAsString,
//       selectedItem: value,
//     );
//   }
// }
