library;

/// Aplicativo principal
/// Contém a configuração do MaterialApp e as rotas nomeadas

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../pages/battery.dart';
import '../pages/device.dart';
import '../pages/geolocation.dart';
import '../pages/home_page.dart';
import '../pages/contacts_page.dart';
import '../pages/info_page.dart';
import '../pages/search_page.dart';
import '../pages/viewbook_page.dart';

// MyApp é um StatelessWidget, o que significa que seu estado não muda ao longo do tempo.
// Ele define a estrutura básica do aplicativo, incluindo o tema e as rotas.
class MyApp extends StatelessWidget {
  // Construtor da classe MyApp. O 'key' é usado para identificar widgets de forma única.
  const MyApp({super.key});

  @override
  // O método build descreve a interface do usuário para este widget.
  Widget build(BuildContext context) {
    // MaterialApp é um widget que encapsula a funcionalidade de design de material do Flutter.
    return MaterialApp(
      // Desliga o modo "Debug" (a faixa vermelha de depuração no canto superior direito).
      // debugShowCheckedModeBanner: false,
      // Título do aplicativo, visível na barra de tarefas do Android ou no switcher de aplicativos.
      title: 'Hello World',
      // Define o tema visual do aplicativo.
      theme: ThemeData(
        // Define a cor primária para o azul.
        primarySwatch: Colors.blue,
        // Adapta a densidade visual da interface do usuário à plataforma.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // Define a rota inicial do aplicativo.
      initialRoute: '/',

      // Define as rotas nomeadas do aplicativo, mapeando nomes de rotas para widgets.
      routes: {
        // Rota raiz que leva à HomePage.
        '/': (context) => const HomePage(),
        // Rota de teste que leva à TestPage (atualmente não implementada).
        // '/test': (context) => const TestPage(),
        // Rota para a página modelo StatelessWidget.
        // '/pagesl': (context) => const ModelPageSl(),
        // Rota para a página modelo StatefulWidget.
        // '/pagesf': (context) => const ModelPageSf(),
        // Rota para uma página de contatos.
        '/contacts': (context) => const ContactsPage(),
        '/search': (context) => const SearchPage(),
        '/info': (context) => const InfoPage(),
        '/geolocation': (context) => const MyGPS(),
        '/battery': (context) => const BattteryView(),
        '/device':  (context) => const DeviceView(),
        // Rota para exibir um livro único identificado pelo Id
        // Id é passado como argumento
        '/view': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          int? bookId;
          if (args != null) {
            try {
              // Tenta converter para String e depois para int
              bookId = int.tryParse(args.toString());
            } catch (e) {
              // Em caso de erro na conversão (se não for uma String numérica)
              if (kDebugMode) {
                print('Erro ao converter o ID do livro: $e');
              }
            }
          }
          // Verifique se a conversão foi bem-sucedida e se bookId não é nulo
          if (bookId != null) {
            return ViewBookPage(bookId: bookId);
          }
          // Caso contrário, mostra a tela de erro
          return Scaffold(
            appBar: AppBar(title: const Text('Erro')),
            body: const Center(
              child: Text('ID do livro não fornecido ou inválido.'),
            ),
          );
        },
      },
    );
  }
}
