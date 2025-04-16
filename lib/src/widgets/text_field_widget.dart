import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController searchController;
  final void Function(String)? onChanged;

  const TextFieldWidget({
    super.key,
    required this.searchController,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: (value) => onChanged,
      onSubmitted: (value) => onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Theme.of(context).cardColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        fillColor: Theme.of(context).cardColor,
        filled: true,
        prefixIcon: Icon(Icons.search),
        hintText: '           Search Country',
      ),
    );
  }
}
