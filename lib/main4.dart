// Aplicativo modelo Dart/Flutter

/*
* Formulários
* Passo 4) Validação dos campos e processamento do formulário
* Linhas 10, 224 até o final
*/

// Importa o pacote de materiais do Flutter, que contém widgets e temas prontos.
import 'package:flutter/foundation.dart'; // Importa para usar kDebugMode para depuração.
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
        // Cor do conteúdo (texto e ícones) da AppBar.
        foregroundColor: Colors.white,
        // Centraliza o título na AppBar.
        centerTitle: true,
      ),
      // O corpo da tela, onde o conteúdo principal é exibido.
      body: Center(
        // Center alinha seu filho no centro da tela.
        child: Column(
          // Column organiza seus filhos verticalmente.
          mainAxisSize: MainAxisSize.max, // A coluna ocupa o máximo de espaço vertical disponível.
          crossAxisAlignment: CrossAxisAlignment.center, // Alinha os filhos horizontalmente ao centro.
          mainAxisAlignment: MainAxisAlignment.center, // Alinha os filhos verticalmente ao centro.

          // O parâmetro 'spacing' não é um parâmetro padrão para Column.
          // Para adicionar espaçamento entre os widgets filhos em uma Column, use SizedBox.
          // spacing: 20, // Provável erro ou recurso de um pacote não padrão.
          children: [
            // Texto exibindo 'Página inicial'.
            const Text( // Adicionado 'const' para otimização de desempenho.
              'Página inicial',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            // Adiciona um espaçamento vertical de 32.0 pixels.
            const SizedBox(height: 32.0),

            // InkWell cria uma área que responde a toques, com um efeito visual de 'tinta'.
            InkWell(
              // Filho do InkWell, um texto que o usuário pode tocar.
              child: const Text('Teste a página Modelo Stateless'), // Adicionado 'const'.
              // Função que é chamada quando o InkWell é tocado.
              onTap: () => {
                Navigator.pushNamed(context, '/pagesl'),
              }, // Navega para a rota '/pagesl'.
            ),
            // Adiciona um espaçamento vertical de 16.0 pixels.
            const SizedBox(height: 16.0),

            InkWell(
              child: const Text('Teste a página Modelo Stateful'), // Adicionado 'const'.
              onTap: () => {
                Navigator.pushNamed(context, '/pagesf'),
              }, // Navega para a rota '/pagesf'.
            ),
            const SizedBox(height: 16.0),

            InkWell(
              child: const Text('Página de Contatos'), // Adicionado 'const'.
              onTap: () => {
                Navigator.pushNamed(context, '/contacts'),
              }, // Navega para a rota '/contacts'.
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
// Um StatelessWidget não tem estado interno mutável e sua UI depende apenas de seus próprios parâmetros.
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
      // Corrigido para refletir que esta é a página Stateless.
      body: const Center(
        child: Text(
          'Conteúdo da Página Modelo Stateless',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      bottomNavigationBar: const Text('Rodapé da págna modelo!'),
    );
  }
}

// Página modelo do tipo StatefulWidget
// para criar novas páginas 'stateful'.
// Um StatefulWidget pode ter um estado interno que pode ser alterado ao longo do tempo,
// permitindo interatividade e mudanças na UI.
class ModelPageSf extends StatefulWidget {
  // Construtor da classe ModelPageSf.
  const ModelPageSf({super.key});

  @override
  // createState é chamado para criar o estado mutável para este widget.
  // Ele retorna uma instância da classe de estado associada (_ModelPageSf).
  State<ModelPageSf> createState() => _ModelPageSf();
}

// A classe de estado associada a ModelPageSf.
// Ela contém o estado mutável e a lógica de construção da interface do usuário.
class _ModelPageSf extends State<ModelPageSf> {
  // Exemplo de estado mutável: um contador.
  int _counter = 0;

  // Método para incrementar o contador e atualizar a UI.
  void _incrementCounter() {
    setState(() {
      // setState notifica o framework que o estado mudou, e ele deve redesenhar o widget.
      _counter++;
    });
  }

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
      // Corpo da página, exibindo o conteúdo e um botão para interagir com o estado.
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Você clicou no botão tantas vezes:',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              '$_counter', // Exibe o valor atual do contador.
              style: Theme.of(context).textTheme.headlineMedium, // Usa um estilo de texto predefinido pelo tema.
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _incrementCounter, // Chama o método para incrementar o contador.
              child: const Text('Incrementar'),
            ),
          ],
        ),
      ),
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

// Página de Contatos do tipo StatefulWidget.
// Esta página contém um formulário para coletar informações de contato.
class ContactsPage extends StatefulWidget {
  // Construtor da classe ContactsPage.
  const ContactsPage({super.key});

  @override
  // createState é chamado para criar o estado mutável para este widget.
  // Ele retorna uma instância da classe de estado associada (_ContactsPage).
  State<ContactsPage> createState() => _ContactsPage();
}

// A classe de estado associada a ContactsPage.
// Ela contém o estado mutável e a lógica de construção da interface do usuário,
// incluindo o formulário de contatos, validações e manipulação de entrada.
class _ContactsPage extends State<ContactsPage> {
  // Chave global para o formulário de contatos.
  // GlobalKey permite que você acesse o estado do formulário e chame métodos como 'validate()'.
  final GlobalKey<FormState> _contactsFormKey = GlobalKey<FormState>();

  // Declara os controladores para cada campo de texto do formulário.
  // TextEditingController permite que você leia e modifique o texto nos campos.
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Expressão Regular (Regex) para validação de e-mail.
  // Esta é uma Regex bem comum na Web e razoavelmente robusta para e-mails.
  // Ajuste para seu "case" se necessário.
  final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  void dispose() {
    // IMPORTANTE! Libera os controladores quando o widget for descartado (removido da árvore de widgets).
    // Isso evita vazamentos de memória. É uma espécie de "desconstrutor".
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose(); // Chama o dispose da classe pai.
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
      // Corpo da página, contendo o formulário de contatos.
      body: SingleChildScrollView(
        // SingleChildScrollView garante que a tela role quando o teclado aparecer,
        // evitando que os campos de texto fiquem ocultos.
        padding: const EdgeInsets.all(32.0), // Adiciona preenchimento em toda a volta do conteúdo.
        child: Form(
          key: _contactsFormKey, // Associa a chave global ao formulário.
          child: Column(
            // Estica os campos horizontalmente para preencher a largura disponível.
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              const Text( // Adicionado 'const'.
                'Preencha todos os campos abaixo para entrar em contato conosco.',
              ),
              const SizedBox(height: 20.0), // Espaçamento vertical.

              // Campo Nome.
              TextFormField(
                // Controlador associado a este campo de texto.
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome', // Texto do rótulo.
                  border: OutlineInputBorder(), // Borda ao redor do campo.
                  prefixIcon: Icon(Icons.person), // Ícone à esquerda do campo.
                ),

                // Validação do nome.
                // O validador retorna uma mensagem de erro (String) se a entrada for inválida,
                // ou null se a entrada for válida.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, escreva seu nome.';
                  }
                  // Retorne null se a validação passar.
                  return null;
                },
              ),
              // Espaçamento entre os campos.
              const SizedBox(height: 20.0),

              // Campo E-mail.
              TextFormField(
                // Controlador associado.
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                // Define o tipo de teclado para e-mail (otimiza para Android e iOS).
                keyboardType: TextInputType.emailAddress,

                // Validação do email.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, escreva seu e-mail.';
                  }
                  // Validação de e-mail usando a expressão regular.
                  if (!_emailRegex.hasMatch(value)) {
                    return 'Por favor, insira um email válido.';
                  }
                  // Retorne null se a validação passar.
                  return null;
                },
              ),
              // Espaçamento entre os campos.
              const SizedBox(height: 20.0),

              // Campo Assunto (subject).
              TextFormField(
                // Controlador associado.
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Assunto',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.subject),
                ),

                // Validação do assunto.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, escreva o assunto.'; // Corrigido o texto da mensagem.
                  }
                  // Retorne null se a validação passar.
                  return null;
                },
              ),
              // Espaçamento entre os campos.
              const SizedBox(height: 20.0),

              // Campo Mensagem (message).
              TextFormField(
                // Controlador associado.
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Mensagem',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.message),
                  // Alinha o label com o hint em múltiplas linhas.
                  alignLabelWithHint: true,
                ),
                // Permite múltiplas linhas para a mensagem.
                maxLines: 5,
                // Define o tipo de teclado para múltiplas linhas (otimiza para Android).
                keyboardType: TextInputType.multiline,

                // Validação da mensagem.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, escreva sua mensagem.'; // Corrigido o texto da mensagem.
                  }
                  // Retorne null se a validação passar.
                  return null;
                },
              ),
              // Espaçamento entre os campos.
              const SizedBox(height: 20.0),

              // Botão de Enviar.
              ElevatedButton.icon(
                onPressed: () {
                  // Ação ao pressionar o botão: chama o método de envio do formulário.
                  _submitContactForm();
                },
                icon: const Icon(Icons.send), // Ícone do botão.
                label: const Text('Enviar'), // Texto do botão.
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12.0), // Preenchimento interno do botão.
                  textStyle: const TextStyle(fontSize: 18), // Estilo do texto do botão.
                  backgroundColor: Colors.blue[600], // Cor de fundo do botão.
                  foregroundColor: Colors.white, // Cor do texto e ícone do botão.
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Text('Rodapé da págna modelo!'),
    );
  }

  // Método para lidar com o envio do formulário.
  void _submitContactForm() {
    // Valida todos os campos do formulário associados a _contactsFormKey.
    // _contactsFormKey.currentState! é usado para acessar o estado atual do formulário.
    // .validate() executa as funções validator de cada TextFormField e retorna true se todos forem válidos.
    if (_contactsFormKey.currentState!.validate()) {
      // Se todos os campos forem válidos, prossiga com o envio.
      final name = _nameController.text; // Obtém o texto do campo Nome.
      final email = _emailController.text; // Obtém o texto do campo E-mail.
      final subject = _subjectController.text; // Obtém o texto do campo Assunto.
      final message = _messageController.text; // Obtém o texto do campo Mensagem.

      // Debug: imprime os valores no console (remova depois dos testes ou em ambiente de produção).
      // kDebugMode é uma constante global que é true apenas em modo de depuração.
      if (kDebugMode) {
        print('\n\n----------------');
        print('Nome: $name');
        print('Email: $email');
        print('Assunto: $subject');
        print('Mensagem: $message');
        print('----------------\n\n');
      }

      // Adicione a lógica de envio real aqui (ex: enviar para uma API REST, salvar em um banco de dados, etc.).
      // Por exemplo, mostrar um SnackBar (uma mensagem temporária na parte inferior da tela) para o usuário.
      ScaffoldMessenger.of(
        context, // Usa o contexto para encontrar o Scaffold mais próximo e exibir o SnackBar.
      ).showSnackBar(SnackBar(content: Text('Mensagem enviada por $name!')));

      // Limpa os campos após o envio bem-sucedido.
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    } else {
      // Se houver erros de validação (algum campo não passou no validator), avise o usuário.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos corretamente.'),
        ),
      );
    }
  }
}
