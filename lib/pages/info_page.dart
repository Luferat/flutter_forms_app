library;

/// Pagina stateless que implementará a página de informações do aplicativo

import 'package:flutter/material.dart';

import '../template/myappbar.dart';
import '../template/myfooter.dart';

final pageName = 'Informações';

// Página modelo do tipo Stateless
// Use como modelo para criar novas páginas Stateless no aplicativo

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: pageName),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Esta é uma Página Stateless!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),

      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
