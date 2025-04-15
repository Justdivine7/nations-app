import 'package:flutter/material.dart';

class BuildRichText extends StatelessWidget {
  final String title;
  final String value;
  const BuildRichText({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          TextSpan(text: '  $value', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
