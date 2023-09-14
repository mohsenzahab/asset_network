import 'package:flutter/material.dart';

import '../../../config/values/styles.dart';

/// A widget to choose multiple items of type [T] using filter chips.
class FilterChips<T> extends StatefulWidget {
  const FilterChips(
      {super.key,
      this.title,
      required this.options,
      required this.onChanged,
      this.readOnly = false,
      required this.asString});
  final String? title;
  final Map<T, bool> options;
  final void Function(Map<T, bool> items) onChanged;
  final String Function(T item) asString;
  final bool readOnly;

  @override
  State<FilterChips<T>> createState() => _FilterChipsState<T>();
}

class _FilterChipsState<T> extends State<FilterChips<T>> {
  late Map<T, bool> values;

  @override
  void initState() {
    super.initState();
    values = Map.of(widget.options);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (widget.title != null)
          Text('${widget.title}: ', style: kStyleInputTitle),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5,
          children: values.entries
              .map((item) => SelectChip(
                  selected: item.value,
                  isEnabled: !widget.readOnly,
                  label: widget.asString(item.key),
                  onSelected: (selected) {
                    values[item.key] = selected;
                    widget.onChanged(Map.of(values));
                    setState(() {});
                  }))
              .toList(),
        ),
      ],
    );
  }
}

class SelectChip extends StatelessWidget {
  const SelectChip(
      {super.key,
      required this.selected,
      required this.label,
      this.isEnabled = true,
      this.onSelected});
  final bool selected;
  final bool isEnabled;
  final String label;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
        selected: selected,
        avatar: selected ? const Icon(Icons.done) : null,
        label: Text(label),
        onSelected: isEnabled ? onSelected : null);
  }
}
