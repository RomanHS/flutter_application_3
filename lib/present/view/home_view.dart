import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/data.dart';
import 'package:flutter_application_3/domain/entity/message.dart';
import 'package:flutter_application_3/domain/registr/message_text.dart';
import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/enum/type_message.dart';
import 'package:flutter_application_3/domain/servis/data_servis.dart';
import 'package:flutter_application_3/domain/value/settings.dart';
import 'package:flutter_application_3/domain/value/settings_user.dart';
import 'package:flutter_application_3/internal/di.dart';
import 'package:flutter_application_3/present/view/messages_view.dart';
import 'package:flutter_application_3/present/view/orders_view.dart';
import 'package:flutter_application_3/present/view/products_view.dart';
import 'package:uuid/uuid.dart';

final StreamController<Message> messageStreamController = StreamController<Message>.broadcast();

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isLoad = false;

  StreamSubscription<void>? _streamSubscription;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  void _init() async {
    final User user = DI.i.autServis.aut.user.value;

    final Data data = await DI.i.dataRepo.get(uidUser: user.uid);

    DI.i.dataServis = DataServis(
      user: user,
      dataRepo: DI.i.dataRepo,
      data: data,
    );

    _streamSubscription = messageStreamController.stream.asyncMap(_listen).listen((void _) {});

    setState(() => _isLoad = false);
  }

  Future<void> _listen(Message message) async {
    final MessageText? messageText = message.messageText;
    final SettingsUser? settings = message.settings;

    return DI.i.dataServis.transaction(
      settings: settings,
      messages: messageText == null ? null : [messageText],
    );
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<void>(
        stream: DI.i.autServis.aut.settings.stream,
        builder: (BuildContext context, AsyncSnapshot<void> _) => _build(context),
      );

  Widget _build(BuildContext context) {
    if (_isLoad) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final Settings settings = DI.i.autServis.aut.settings.value;

    return Scaffold(
      ///
      appBar: AppBar(
        ///
        centerTitle: true,

        ///
        title: const Text('Home'),

        ///
        actions: [
          ///
          IconButton(
            onPressed: () => DI.i.autServis.logOut(user: DI.i.dataServis.user),
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),

      ///
      body: Column(
        children: [
          ///
          Card(
            child: CheckboxListTile(
              title: const Text('DarkTheme'),
              value: settings.isDarkTheme,
              onChanged: (bool? _) => DI.i.autServis.putSettings(settings: settings.copyWith(isDarkTheme: !settings.isDarkTheme)),
            ),
          ),

          ///
          Card(
            child: ListTile(
              title: const Text('Products'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ProductsView(),
                ),
              ),
            ),
          ),

          ///
          Card(
            child: ListTile(
              title: const Text('Orders'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const OrdersView(),
                ),
              ),
            ),
          ),

          ///
          Card(
            child: ListTile(
              title: const Text('Messages'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const MessagesView(isArchive: false),
                ),
              ),
            ),
          ),

          ///
          StreamBuilder<void>(
            stream: DI.i.dataServis.data.settings.stream,
            builder: (BuildContext context, AsyncSnapshot<void> _) {
              return Card(
                child: ListTile(
                  title: Text('isNegativeLeftovers: ${DI.i.dataServis.data.settings.value.isNegativeLeftovers}'),
                ),
              );
            },
          ),
        ],
      ),

      ///
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.message),
        onPressed: () {
          final SettingsUser settings = DI.i.dataServis.data.settings.value;

          messageStreamController.add(
            Message(
              uid: const Uuid().v4(),
              type: TypeMessage.client,
              text: 'isNegativeLeftovers: ${!settings.isNegativeLeftovers}',
              settings: settings.copyWith(isNegativeLeftovers: !settings.isNegativeLeftovers),
              surveys: const [],
              date: DateTime.now(),
            ),
          );
        },
      ),
    );
  }
}
