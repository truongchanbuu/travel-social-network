import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:travel_social_network/features/tour/presentation/widgets/create_tour_field.dart';

import '../../../../generated/l10n.dart';

class CreateTourSearchField extends StatefulWidget {
  final String title;
  final void Function(String value)? onSelected;
  final String? Function(String? value)? validator;

  const CreateTourSearchField({
    super.key,
    required this.title,
    required this.onSelected,
    this.validator,
  });

  @override
  State<CreateTourSearchField> createState() => _CreateTourSearchFieldState();
}

class _CreateTourSearchFieldState extends State<CreateTourSearchField> {
  late final SuggestionsController<String> _suggestionsController;
  late final TextEditingController _textEditingController;

  @override
  void dispose() {
    _suggestionsController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _suggestionsController = SuggestionsController();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      controller: _textEditingController,
      itemBuilder: (context, name) => ListTile(
        leading: const Icon(Icons.location_on),
        title: Text(name),
      ),
      builder: (context, controller, focusNode) => CreateTourField(
        validator: widget.validator,
        label: widget.title,
        focusNode: focusNode,
        textEditingController: controller,
        singleHintText: widget.title,
      ),
      suggestionsController: _suggestionsController,
      onSelected: (value) {
        widget.onSelected?.call(value);
        _textEditingController.text = value;
      },
      suggestionsCallback: (search) => _search(search),
      errorBuilder: (context, error) {
        debugPrint(error.toString());
        return ListTile(
          leading: const Icon(Icons.search_off),
          title: Text(S.current.notFound),
        );
      },
      loadingBuilder: (context) => ListTile(
        leading: const Icon(Icons.location_searching),
        title: Text(S.current.loading),
      ),
      emptyBuilder: (context) => ListTile(
        leading: const Icon(Icons.search_off),
        title: Text(S.current.notFound),
      ),
    );
  }

  final List<String> allLocations =
      List.generate(64, (index) => 'Location $index');

  Future<List<String>> _search(String query) async {
    final Completer<List<String>> completer = Completer<List<String>>();

    completer.complete(allLocations
        .where((location) =>
            location.toLowerCase().contains(query.trim().toLowerCase()))
        .toList());

    return completer.future;
  }
}