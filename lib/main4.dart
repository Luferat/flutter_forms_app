// Aplicativo modelo Dart/Flutter

/*
* Formulários
* Passo 4) Validação dos campos e processamento do formulário
*    Linhas 10, 224 até o final
*/

// Importa o pacote de materiais do Flutter, que contém widgets e temas prontos.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Função principal do aplicativo, onde a execução começa.
void main() {
  // Executa o aplicativo MyApp, que é o widget raiz da árvore de widgets.
  runApp(const MyApp());
}

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
      // Desliga o modo "Debug"
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
        '/test': (context) => const TestPage(),
        // Rota para a página modelo StatelessWidget.
        '/pagesl': (context) => const ModelPageSl(),
        // Rota para a página modelo StatefulWidget.
        '/pagesf': (context) => const ModelPageSf(),
        // Rota para uma página de contatos.
        '/contacts': (context) => const ContactsPage(),
      },
    );
  }
}

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
        // Cor do conteúdo da AppBar.
        foregroundColor: Colors.white,
        // Centraliza o título na AppBar.
        centerTitle: true,
      ),
      // O corpo da tela, onde o conteúdo principal é exibido.
      body: Center(
        // Center alinha seu filho no centro da tela.
        child: Column(
          // Column organiza seus filhos verticalmente.
          mainAxisSize: MainAxisSize.max,
          // A coluna ocupa o máximo de espaço vertical disponível.
          crossAxisAlignment: CrossAxisAlignment.center,
          // Alinha os filhos horizontalmente ao centro.
          mainAxisAlignment: MainAxisAlignment.center,

          // Alinha os filhos verticalmente ao centro.
          // O parâmetro 'spacing' não é um parâmetro padrão para Column.
          // Se fosse uma versão personalizada de Column ou um pacote externo, ele adicionaria espaçamento entre os filhos.
          // Em uma Column padrão, você usaria SizedBox para espaçamento.
          // spacing: 20, // Provável erro ou recurso de um pacote não padrão.
          children: [
            // Texto exibindo 'Página inicial'.
            Text(
              'Página inicial',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            // Adiciona um espaçamento vertical
            const SizedBox(height: 32.0),

            // InkWell cria uma área que responde a toques, com um efeito visual de 'tinta'.
            InkWell(
              // Filho do InkWell, um texto que o usuário pode tocar.
              child: Text('Teste a página Modelo Stateless'),
              // Função que é chamada quando o InkWell é tocado.
              onTap: () => {
                Navigator.pushNamed(context, '/pagesl'),
              }, // Navega para a rota '/pagesl'.
            ),
            // Adiciona um espaçamento vertical
            const SizedBox(height: 16.0),

            InkWell(
              child: Text('Teste a página Modelo Stateful'),
              onTap: () => {
                Navigator.pushNamed(context, '/pagesf'),
              }, // Navega para a rota '/pagesf'.
            ),
            const SizedBox(height: 16.0),

            InkWell(
              child: Text('Página de Contatos'),
              onTap: () => {
                Navigator.pushNamed(context, '/contacts'),
              }, // Navega para a rota '/pagesf'.
            ),
          ],
        ),
      ),
      // BottomNavigationBar é a barra na parte inferior da tela.
      bottomNavigationBar: const Text('Rodapé de Hello World!'),
    );
  }
}

// ------------------------- MODELOS ---------------------------------------- //

// Página modelo do tipo 'StatelessWidget'
// para criar novas páginas 'stateless'.
// Um StatelessWidget não tem estado interno mutável.
class ModelPageSl extends StatelessWidget {
  // Construtor da classe ModelPageSl.
  const ModelPageSl({super.key});

  @override
  // O método build descreve a interface do usuário para esta página.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Página Modelo Stateless',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      // Corpo da página, exibindo um texto simples.
      body: const Text('Página Modelo Stateful'),
      // Há um pequeno erro aqui, deveria ser 'Página Modelo Stateless' para consistência.
      bottomNavigationBar: const Text('Rodapé da págna modelo!'),
    );
  }
}

// Página modelo do tipo StatefulWidget
// para criar novas páginas 'stateful'.
// Um StatefulWidget pode ter um estado interno que pode ser alterado ao longo do tempo.
class ModelPageSf extends StatefulWidget {
  // Construtor da classe ModelPageSf.
  const ModelPageSf({super.key});

  @override
  // createState é chamado para criar o estado mutável para este widget.
  State<ModelPageSf> createState() => _ModelPageSf();
}

// A classe de estado associada a ModelPageSf.
// Ela contém o estado mutável e a lógica de construção da interface do usuário.
class _ModelPageSf extends State<ModelPageSf> {
  @override
  // O método build descreve a interface do usuário para esta página.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Página Modelo Stateful',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      // Corpo da página, exibindo um texto simples.
      body: const Text('Conteúdo da página modelo!'),
      bottomNavigationBar: const Text('Rodapé da págna modelo!'),
    );
  }
}

// Página vazia (Não implementada),
// usada apenas para "demarcar" páginas futuras.
class TestPage extends StatelessWidget {
  // Construtor da classe TestPage.
  const TestPage({super.key});

  @override
  // O método build para TestPage não está implementado, o que fará com que um erro seja lançado se a página for acessada.
  Widget build(BuildContext context) {
    // TODO: implement build // Este comentário indica que a implementação está pendente.
    throw UnimplementedError(); // Lança um erro indicando que a funcionalidade não foi implementada.
  }
}

// Página de Contatos do tipo StatefulWidget
class ContactsPage extends StatefulWidget {
  // Construtor da classe ModelPageSf.
  const ContactsPage({super.key});

  @override
  // createState é chamado para criar o estado mutável para este widget.
  State<ContactsPage> createState() => _ContactsPage();
}

// A classe de estado associada a ContactsPage.
// Ela contém o estado mutável e a lógica de construção da interface do usuário
// incluindo o formulário de contatos.
class _ContactsPage extends State<ContactsPage> {
  // Chave global para o formulário de contatos
  final GlobalKey<FormState> _contactsFormKey = GlobalKey<FormState>();

  // Declara os controladores para cada campo
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Expressão Regular para validação de e-mail
  // Esta é uma Regex bem comum na Web e razoavelmente robusta para e-mails.
  // Ajuste para seu "case" se necessário.
  final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  void dispose() {
    // IMPORTANTE! Libera os controladores quando o widget for descartado.
    // É uma espécie de "desconstrutor".
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  // O método build descreve a interface do usuário para esta página.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Faça Contato',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      // Corpo da página, exibindo um texto simples.
      body: SingleChildScrollView(
        // Garante que a tela role quando o teclado aparecer
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _contactsFormKey,
          child: Column(
            // Estica os campos horizontalmente
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              Text(
                'Preencha todos os campos abaixo para entrar em contato conosco.',
              ),
              const SizedBox(height: 20.0),

              // Campo Nome
              TextFormField(
                // Controlador definido acima
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),

                // Validação do nome
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, escreva seu nome.';
                  }
                  // Retorne null se a validação passar
                  return null;
                },
              ),
              // Espaçamento entre os campos
              const SizedBox(height: 20.0),

              // Campo E-mail
              TextFormField(
                // Controlador definido acima
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                // Teclado otimizado para email (Android)
                keyboardType: TextInputType.emailAddress,

                // Validação do email
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, escreva seu e-mail.';
                  }
                  // Validação de e-mail com Regex
                  if (!_emailRegex.hasMatch(value)) {
                    return 'Por favor, insira um email válido.';
                  }
                  // Retorne null se a validação passar
                  return null;
                },
              ),
              // Espaçamento entre os campos
              const SizedBox(height: 20.0),

              // Campo Assunto (subject)
              TextFormField(
                // Controlador definido acima
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Assunto',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.subject),
                ),

                // Validação do assunto
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, escreva seu nome.';
                  }
                  // Retorne null se a validação passar
                  return null;
                },
              ),
              // Espaçamento entre os campos
              const SizedBox(height: 20.0),

              // Campo Mensagem (message)
              TextFormField(
                // Controlador definido acima
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Mensagem',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.message),
                  // Alinha o label com o hint em múltiplas linhas
                  alignLabelWithHint: true,
                ),
                // Permite múltiplas linhas para a mensagem
                maxLines: 5,
                // Teclado otimizado para múltiplas linhas (Android)
                keyboardType: TextInputType.multiline,

                // Validação da mensagem
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, escreva seu nome.';
                  }
                  // Retorne null se a validação passar
                  return null;
                },
              ),
              // Espaçamento entre os campos
              const SizedBox(height: 20.0),

              // Botão de Enviar
              ElevatedButton.icon(
                onPressed: () {
                  // Ação ao pressionar o botão
                  _submitContactForm();
                },
                icon: const Icon(Icons.send),
                label: const Text('Enviar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Text('Rodapé da págna modelo!'),
    );
  }

  // Método para lidar com o envio do formulário
  void _submitContactForm() {
    // Valida todos os campos do formulário
    if (_contactsFormKey.currentState!.validate()) {
      // Se todos os campos forem válidos, prossiga com o envio
      final name = _nameController.text;
      final email = _emailController.text;
      final subject = _subjectController.text;
      final message = _messageController.text;

      // Debug: imprime os valores no console (remova depois dos testes)
      if (kDebugMode) {
        print('\n\n----------------');
        print('Nome: $name');
        print('Email: $email');
        print('Assunto: $subject');
        print('Mensagem: $message');
        print('----------------\n\n');
      }

      // Adicione a lógica de envio aqui (ex: enviar para uma API, exibir uma mensagem, etc.)
      // Por exemplo, mostrar um SnackBar:
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Mensagem enviada por $name!')));

      // Limpa os campos após o envio
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    } else {
      // Se houver erros de validação, avise o usuário
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos corretamente.'),
        ),
      );
    }
  }
}
