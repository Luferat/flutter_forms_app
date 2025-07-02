library;

/// Pagina stateful que implementará a página de pesquisa

import 'package:flutter/material.dart';
import '../template/myappbar.dart';
import '../template/mydrawer.dart';
import '../template/myfooter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Pesquisar'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text('Página de pesquisa!')],
        ),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
