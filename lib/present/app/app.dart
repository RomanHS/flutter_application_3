import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/value/settings.dart';
import 'package:flutter_application_3/main.dart';
import 'package:flutter_application_3/present/view/aut_view.dart';
import 'package:flutter_application_3/present/view/home_view.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  StreamSubscription<User?>? _streamSubscription;

  @override
  void initState() {
    _streamSubscription = autServis.aut.user.stream.listen(_listen);
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  void _listen(User? user) => _navigatorKey.currentState?.pushAndRemoveUntil(
        ///
        MaterialPageRoute<void>(
          builder: (BuildContext context) => user == null ? const AutView() : const HomeView(),
        ),

        ///
        (Route<dynamic> route) => false,
      );

  @override
  Widget build(BuildContext context) => StreamBuilder<void>(
        stream: autServis.aut.settings.stream,
        builder: (BuildContext context, AsyncSnapshot<void> _) => _build(context),
      );

  Widget _build(BuildContext context) {
    final User? user = autServis.aut.user.value;

    final Settings settings = autServis.aut.settings.value;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: settings.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: user == null ? const AutView() : const HomeView(),
    );
  }
}
