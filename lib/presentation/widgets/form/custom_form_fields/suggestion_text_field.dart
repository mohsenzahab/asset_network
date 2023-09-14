import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';

import '../../../../config/values/layout.dart';
import '../../../../core/localization/localizations.dart';
import '../../../../locator.dart';

/// A [TextField] which will suggest item from suggestions based on
/// typed value. It will use [itemAsString] to show and order each item.
class SuggestionTextField<T> extends StatelessWidget {
  const SuggestionTextField(
      {super.key,
      this.initialValue,
      this.label,
      required this.itemAsString,
      required this.getSuggestions,
      this.itemSubtitle,
      this.itemIconUrl,
      this.onSelected,
      this.validator,
      this.readOnly = false,
      this.onChanged});
  final String? label;

  /// Used to get each item name. Must be provided.
  final String Function(T item) itemAsString;
  final String Function(T item)? itemSubtitle;
  final String? Function(T item)? itemIconUrl;
  final T? initialValue;
  final FutureOr<List<T>> Function(String query) getSuggestions;
  final void Function(T selectedItem)? onSelected;
  final void Function(String? value)? onChanged;
  final String? Function(T?)? validator;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final l = sl<ILocalizations>();
    final effectiveDecoration = InputDecoration(
      labelText: label,
      // prefixIcon: const Icon(Icons.search),
      isCollapsed: true,
      contentPadding: kPaddingInputPadding,
    ).applyDefaults(Theme.of(context).inputDecorationTheme);
    return DropdownFormField<T>(
      controller: DropdownEditingController(value: initialValue),
      decoration: effectiveDecoration,
      displayItemString: itemAsString,
      emptyText: l('message_no_case_found'),
      readOnly: readOnly,
      onChanged: onChanged,
      validator: validator,
      dropdownItemFn: (dynamic item, int position, bool focused, bool selected,
          dynamic Function() onTap) {
        return ListTile(
          title: Text(itemAsString(item)),
          subtitle: itemSubtitle != null ? Text(itemSubtitle!(item)) : null,
          // trailing: _getIcon(e),
          onTap: () {
            onTap();
            onSelected?.call(item);
          },
        );
      },
      findFn: (str) async {
        return await getSuggestions(str);
      },
    );
  }

  CachedNetworkImage? _getIcon(T item) {
    if (itemIconUrl == null || itemIconUrl!.call(item) == null) {
      return null;
    }
    debugPrint(itemIconUrl!.call(item));
    return CachedNetworkImage(imageUrl: itemIconUrl?.call(item) ?? '');
  }
}
