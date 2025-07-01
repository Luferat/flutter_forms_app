import 'package:flutter/material.dart';
import '../template/mydrawer.dart';

// HomePage é um StatelessWidget que representa a tela inicial do aplicativo.
class HomePage extends StatelessWidget {
  // Construtor da classe HomePage.
  const HomePage({super.key});

  @override
  // O método build descreve a interface do usuário para esta página.
  Widget build(BuildContext context) {
    // Scaffold fornece uma estrutura visual básica para o Material Design, como AppBar, Body e BottomNavigationBar.
    return Scaffold(
      // AppBar é a barra na parte superior da tela.
      appBar: AppBar(
        // Título da AppBar.
        title: const Text(
          'Hello World',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // Cor de fundo da AppBar.
        backgroundColor: Colors.blue,
        // Cor do conteúdo (texto e ícones) da AppBar.
        foregroundColor: Colors.white,
        // Centraliza o título na AppBar.
        centerTitle: true,
      ),

      drawer: MyDrawer(),

      // O corpo da tela, onde o conteúdo principal é exibido.
      body: Center(
        // Center alinha seu filho no centro da tela.
        child: Column(
          // Column organiza seus filhos verticalmente.

          // A coluna ocupa o máximo de espaço vertical disponível.
          mainAxisSize: MainAxisSize.max,

          // Alinha os filhos horizontalmente ao centro.
          crossAxisAlignment: CrossAxisAlignment.center,

          // Alinha os filhos verticalmente ao centro.
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            // Texto exibindo 'Página inicial'.
            const Text(
              // Adicionado 'const' para otimização de desempenho.
              'Página inicial',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            // Adiciona um espaçamento vertical de 32.0 pixels.
            const SizedBox(height: 32.0),

            // InkWell cria uma área que responde a toques, com um efeito visual de 'tinta'.
            ElevatedButton(
              onPressed: () => {Navigator.pushNamed(context, '/pagesl')},
              child: const Text('Teste a página Modelo Stateless'),
            ),

            // Adiciona um espaçamento vertical de 16.0 pixels.
            const SizedBox(height: 16.0),

            ElevatedButton(
              child: const Text('Teste a página Modelo Stateful'),
              // Adicionado 'const'.
              onPressed: () =>
              {
                Navigator.pushNamed(context, '/pagesf'),
              }, // Navega para a rota '/pagesf'.
            ),
            const SizedBox(height: 16.0),

            ElevatedButton(
              child: const Text('Página de Contatos'), // Adicionado 'const'.
              onPressed: () =>
              {
                Navigator.pushNamed(context, '/contacts'),
              }, // Navega para a rota '/contacts'.
            ),
          ],
        ),
      ),
      // BottomNavigationBar é a barra na parte inferior da tela.
      bottomNavigationBar: const Text('Rodapé de Hello World!')
      ,
    );
  }
}