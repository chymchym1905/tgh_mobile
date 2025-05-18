import 'package:flutter/material.dart';
import 'package:tgh_mobile/theme.dart';

Widget toast(BuildContext context, String message) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    constraints: const BoxConstraints(maxWidth: 300),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message, style: TextStyle(color: Theme.of(context).extension<TextColors>()!.text)),
      ],
    ),
  );
}
