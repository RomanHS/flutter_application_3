import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/message.dart';
import 'package:flutter_application_3/domain/registr/message_text.dart';
import 'package:flutter_application_3/domain/enum/type_message.dart';
import 'package:flutter_application_3/domain/value/settings_user.dart';
import 'package:flutter_application_3/internal/di.dart';
import 'package:flutter_application_3/present/view/home_view.dart';
import 'package:uuid/uuid.dart';

class MessagesView extends StatelessWidget {
  final bool isArchive;

  const MessagesView({
    super.key,
    required this.isArchive,
  });

  @override
  Widget build(BuildContext context) => StreamBuilder<void>(
        stream: DI.i.dataServis.data.messages.stream,
        builder: (BuildContext context, AsyncSnapshot<void> _) => _build(context),
      );

  Widget _build(BuildContext context) {
    const UidMessageText uidMessagesIsArchive = UidMessageText(uidMessage: null, type: null, isArchive: true);

    final bool messagesIsArchiveIsEmpty = DI.i.dataServis.data.messages.getList(uidMessagesIsArchive).isEmpty;

    final List<TypeMessage?> types = [
      null,
      ...TypeMessage.values,
    ];

    AppBar appBar() => AppBar(
          ///
          centerTitle: true,

          ///
          title: const Text('Messages'),

          ///
          actions: [
            ///
            if (isArchive)
              IconButton(
                onPressed: messagesIsArchiveIsEmpty ? null : () => DI.i.dataServis.transaction(messagesDelete: [uidMessagesIsArchive]),
                icon: const Icon(Icons.delete),
              )

            ///
            else
              IconButton(
                onPressed: messagesIsArchiveIsEmpty
                    ? null
                    : () => Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const MessagesView(isArchive: true),
                          ),
                        ),
                icon: const Icon(Icons.archive),
              ),
          ],

          ///
          bottom: TabBar(
            tabs: types.map(
              (TypeMessage? e) {
                final UidMessageText uid = UidMessageText(uidMessage: null, type: e, isArchive: isArchive);

                final int length = DI.i.dataServis.data.messages.getListLength(uid);

                return Tab(
                  child: Text('${e?.name ?? 'All'} ($length)'),
                );
              },
            ).toList(),
          ),
        );

    Widget bodyList(TypeMessage? type) {
      final UidMessageText uid = UidMessageText(uidMessage: null, type: type, isArchive: isArchive);

      final Iterable<MessageText> iterable = DI.i.dataServis.data.messages.getList(uid);

      final List<MessageText> messages = iterable.toList().reversed.toList();

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
            key: Key(message.uidMessage),
            child: ListTile(
              title: Text(message.text),
            ),
          );
        },
      );
    }

    Widget body() {
      return TabBarView(
        children: types.map((TypeMessage? e) => bodyList(e)).toList(),
      );
    }

    Widget floatingActionButton() => FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            final SettingsUser settings = DI.i.dataServis.data.settings.value;

            messageStreamController.add(
              Message(
                uid: const Uuid().v4(),
                type: TypeMessage.bs,
                text: 'isNegativeLeftovers: ${!settings.isNegativeLeftovers}',
                settings: settings.copyWith(isNegativeLeftovers: !settings.isNegativeLeftovers),
                surveys: const [],
                date: DateTime.now(),
              ),
            );
          },
        );

    return DefaultTabController(
      length: types.length,
      child: Scaffold(
        appBar: appBar(),
        body: body(),
        floatingActionButton: floatingActionButton(),
      ),
    );
  }
}
