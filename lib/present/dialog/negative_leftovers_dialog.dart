import 'package:flutter/material.dart';

class NegativeLeftoversDialog extends StatelessWidget {
  const NegativeLeftoversDialog._();

  static Future<void> show(BuildContext context) => showDialog<void>(
        context: context,
        builder: (BuildContext context) => const NegativeLeftoversDialog._(),
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
