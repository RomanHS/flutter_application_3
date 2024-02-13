import 'package:flutter/material.dart';

class TextDialog extends StatelessWidget {
  const TextDialog._();

  static Future<void> show(BuildContext context) => showDialog<void>(
        context: context,
        builder: (BuildContext context) => const TextDialog._(),
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ошибка: отрицательные остатки!'),
      actions: [
        ///
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
