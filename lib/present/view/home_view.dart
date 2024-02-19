import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/data.dart';
import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/servis/data_servis.dart';
import 'package:flutter_application_3/domain/value/settings.dart';
import 'package:flutter_application_3/main.dart';
import 'package:flutter_application_3/present/view/orders_view.dart';
import 'package:flutter_application_3/present/view/products_view.dart';

late DataServis dataServis;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isLoad = false;

  DataServis? _dataServis;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _dataServis?.dispose();
    super.dispose();
  }

  void _init() async {
    final User user = autServis.aut.user.value ?? User.empty();

    final Data data = await autServis.dataRepo.get(uidUser: user.uid);

    dataServis = _dataServis = DataServis(user: user, dataRepo: autServis.dataRepo, data: data);

    setState(() => _isLoad = false);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<void>(
        stream: autServis.aut.settings.stream,
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

    final Settings settings = autServis.aut.settings.value;

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
            onPressed: () => autServis.logOut(user: dataServis.user),
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
              onChanged: (bool? _) => autServis.putSettings(settings: settings.copyWith(isDarkTheme: !settings.isDarkTheme)),
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
        ],
      ),
    );
  }
}
