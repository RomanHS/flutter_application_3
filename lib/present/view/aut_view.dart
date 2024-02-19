import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/internal/di.dart';

class AutView extends StatefulWidget {
  const AutView({super.key});

  @override
  State<AutView> createState() => _AutViewState();
}

class _AutViewState extends State<AutView> {
  final TextEditingController textEditingController = TextEditingController(text: DI.i.autServis.aut.user.value.uid);

  bool _isLoad = false;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void logIn() async {
    setState(() => _isLoad = true);

    await DI.i.autServis.logIn(login: textEditingController.text);

    setState(() => _isLoad = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
      appBar: AppBar(
        title: const Text('Aut'),
        centerTitle: true,
      ),

      ///
      body: _isLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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

                ///
                StreamBuilder<void>(
                  stream: DI.i.autServis.aut.users.stream,
                  builder: (BuildContext context, AsyncSnapshot<void> _) {
                    return Row(
                      children: [
                        ...DI.i.autServis.aut.users.values.map(
                          (User e) => Card(
                            child: InkWell(
                              onTap: () => textEditingController.text = e.uid,
                              child: Row(
                                children: [
                                  ///
                                  const IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.supervised_user_circle_rounded),
                                  ),

                                  ///
                                  Text(e.uid),

                                  ///
                                  IconButton(
                                    onPressed: () => DI.i.autServis.deleteUser(uidUser: e.uid),
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
    );
  }
}
