import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';

class MultipleChoiceSettingItem<T> extends StatelessWidget {
  final String title;
  final String choice;
  final T? selected;
  final List<T> selections;
  final void Function(T choice)? onSelected;

  const MultipleChoiceSettingItem({
    super.key,
    required this.selections,
    required this.title,
    required this.choice,
    this.onSelected,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _showSelection(context),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            choice,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void _showSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: bottomSheetShape,
      useSafeArea: true,
      builder: (context) => _SelectionBottomSheet<T>(
        selections: selections,
        onSelected: onSelected,
        selected: selected,
      ),
    );
  }
}

class _SelectionBottomSheet<T> extends StatelessWidget {
  final T? selected;
  final List<T> selections;
  final void Function(T choice)? onSelected;

  const _SelectionBottomSheet({
    required this.selections,
    this.onSelected,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: selections
          .map((selection) => _buildChoice(context, selection))
          .toList(),
    );
  }

  Widget _buildChoice(BuildContext context, T data) {
    return ListTile(
      onTap: () {
        onSelected?.call(data);
        Navigator.pop(context);
      },
      title: Text(data.toString()),
      trailing: data == selected
          ? const Icon(Icons.check, color: Colors.green)
          : null,
    );
  }
}
