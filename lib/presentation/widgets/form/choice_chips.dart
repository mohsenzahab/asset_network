import 'package:flutter/material.dart';
import '../../../config/values/styles.dart';

/// A widget to select an item of type [T] using ch.oice chips
class ChoiceChips<T> extends StatefulWidget {
  const ChoiceChips(
      {super.key,
      this.title,
      required this.choices,
      this.onSelected,
      required this.asString,
      this.initialValue,
      this.readOnly = false});
  final String? title;
  final T? initialValue;
  final List<T> choices;
  final bool? Function(T selectedItem)? onSelected;
  final String Function(T item) asString;
  final bool readOnly;

  @override
  State<ChoiceChips<T>> createState() => _ChoiceChipsState<T>();
}

class _ChoiceChipsState<T> extends State<ChoiceChips<T>> {
  late List<T> values;
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
    values = widget.choices.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (widget.title != null)
          Text(
            '${widget.title}: ',
            style: kStyleInputTitle,
          ),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.end,
          children: values
              .map((e) => MChoiceChip(
                    label: widget.asString(e),
                    selected: selectedValue == e,
                    enabled: !widget.readOnly,
                    onSelected: ((selected) {
                      setState(() {
                        final canSelect = widget.onSelected?.call(e) ?? true;
                        if (canSelect) {
                          selectedValue = e;
                        }
                      });
                    }),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class MChoiceChip extends StatelessWidget {
  const MChoiceChip(
      {super.key,
      required this.label,
      required this.selected,
      this.enabled = true,
      this.onSelected});
  final String label;
  final bool selected;
  final bool enabled;
  final void Function(bool selected)? onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      avatar: selected ? const Icon(Icons.done) : null,
      label: Text(label),
      selected: selected,
      onSelected: enabled ? onSelected : null,
    );
  }
}
