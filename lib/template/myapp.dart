import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/contacts_page.dart';

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
      },
    );
  }
}
