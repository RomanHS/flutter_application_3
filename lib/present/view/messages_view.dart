import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/message.dart';
import 'package:flutter_application_3/domain/entity/message_text.dart';
import 'package:flutter_application_3/domain/value/settings_user.dart';
import 'package:flutter_application_3/internal/di.dart';
import 'package:flutter_application_3/present/view/home_view.dart';
import 'package:uuid/uuid.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) => StreamBuilder<void>(
        stream: DI.i.dataServis.data.messages.stream,
        builder: (BuildContext context, AsyncSnapshot<void> _) => _build(context),
      );

  Widget _build(BuildContext context) {
    final List<MessageText> messages = DI.i.dataServis.data.messages.values.toList().reversed.toList();

    AppBar appBar() => AppBar(
          ///
          centerTitle: true,

          ///
          title: const Text('Messages'),

          ///
          actions: [
            IconButton(
              onPressed: messages.isEmpty ? null : () => DI.i.dataServis.transaction(messagesClear: true),
              icon: const Icon(Icons.delete),
            ),
          ],
        );

    Widget body() {
      if (messages.isEmpty) {
        return const Center(
          child: Text('Empty'),
        );
      }

      return ListView.builder(
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int i) {
          final MessageText message = messages[i];

          return Card(
            key: Key(message.uid),
            child: ListTile(
              title: Text(message.text),
            ),
          );
        },
      );
    }

    Widget floatingActionButton() => FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            final SettingsUser settings = DI.i.dataServis.data.settings.value;

            messageStreamController.add(
              Message(
                uid: const Uuid().v4(),
                text: 'isNegativeLeftovers: ${!settings.isNegativeLeftovers}',
                settings: settings.copyWith(isNegativeLeftovers: !settings.isNegativeLeftovers),
                surveys: const [],
              ),
            );
          },
        );

    return Scaffold(
      appBar: appBar(),
      body: body(),
      floatingActionButton: floatingActionButton(),
    );
  }
}
