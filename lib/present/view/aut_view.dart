import 'package:flutter/material.dart';
import 'package:flutter_application_3/main.dart';

class AutView extends StatefulWidget {
  const AutView({super.key});

  @override
  State<AutView> createState() => _AutViewState();
}

class _AutViewState extends State<AutView> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void logIn() => autServis.logIn(login: textEditingController.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
      appBar: AppBar(
        title: const Text('Aut'),
        centerTitle: true,
      ),

      ///
      body: Column(
        ///
        mainAxisAlignment: MainAxisAlignment.center,

        ///
        children: [
          ///
          TextField(
            controller: textEditingController,
          ),

          ///
          ListenableBuilder(
            listenable: textEditingController,
            builder: (BuildContext context, Widget? child) {
              return TextButton(
                onPressed: textEditingController.text.isEmpty ? null : logIn,
                child: const Text('logIn'),
              );
            },
          ),
        ],
      ),
    );
  }
}
