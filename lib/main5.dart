// Aplicativo modelo Dart/Flutter

/*
* Formulários
* Passo 5) Processamento do formulário e envio do JSON para a API
*/

// Importa o pacote de materiais do Flutter, que contém widgets e temas prontos.
import 'package:flutter/foundation.dart'; // Importa para usar kDebugMode para depuração.
import 'package:flutter/material.dart';

/*
Importa o pacote dio
Adicione a dependência mais recente do "Dio" no 'pubspec.yaml' com ATENÇÃO!

dev_dependencies:
  flutter_test:
    sdk: flutter
  dio: ^5.8.0+1

*/
import 'package:dio/dio.dart';

// Instância do Dio
final Dio _dio = Dio();

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
              onPressed: () => {
                Navigator.pushNamed(context, '/pagesf'),
              }, // Navega para a rota '/pagesf'.
            ),
            const SizedBox(height: 16.0),

            ElevatedButton(
              child: const Text('Página de Contatos'), // Adicionado 'const'.
              onPressed: () => {
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
        padding: const EdgeInsets.all(32.0),
        // Adiciona preenchimento em toda a volta do conteúdo.
        child: Form(
          key: _contactsFormKey, // Associa a chave global ao formulário.
          child: Column(
            // Estica os campos horizontalmente para preencher a largura disponível.
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              const Text(
                // Adicionado 'const'.
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
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  // Preenchimento interno do botão.
                  textStyle: const TextStyle(fontSize: 18),
                  // Estilo do texto do botão.
                  backgroundColor: Colors.blue[600],
                  // Cor de fundo do botão.
                  foregroundColor:
                      Colors.white, // Cor do texto e ícone do botão.
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Text('Rodapé da págna modelo!'),
    );
  }

// Método para lidar com o envio do formulário de contato.
// É assíncrono porque realiza uma operação de rede (HTTP POST).
  void _submitContactForm() async {
    // 1. Validação do Formulário:
    // Verifica se todos os campos do formulário são válidos
    // de acordo com as regras de 'validator' definidas nos TextFormField.
    if (_contactsFormKey.currentState!.validate()) {
      // 2. Coleta dos Dados:
      // Pega o texto atual de cada controlador de campo.
      final name = _nameController.text;
      final email = _emailController.text;
      final subject = _subjectController.text;
      final message = _messageController.text;

      // 3. Formatação dos Dados para JSON:
      // Cria um mapa (chave-valor) com os dados do formulário.
      // As chaves ('name', 'email', etc.) devem corresponder ao que sua API espera.
      final Map<String, String> formData = {
        'name': name,
        'email': email,
        'subject': subject,
        'message': message,
      };

      // 4. Definição da URL da API:
      // A URL para onde os dados serão enviados.
      // Lembre-se: 'localhost' para iOS/Web; '10.0.2.2' para Android Emulator.
      // Nota: Em um projeto real, esta URL estaria em um arquivo de configuração global.
      final String apiUrl = 'http://localhost:8080/contacts';

      // 5. Bloco de Envio e Tratamento de Erros:
      // Usa um bloco try-catch para gerenciar possíveis erros durante a requisição de rede.
      try {
        // 5.1. Realiza a Requisição POST com Dio:
        // Envia os dados formatados (Map formData) para a apiUrl.
        // Dio automaticamente converte o 'Map' em JSON para o corpo da requisição.
        final Response response = await _dio.post(
          apiUrl,
          data: formData,
          // Define o cabeçalho 'Content-Type' como JSON, informando à API o formato dos dados.
          options: Options(
            contentType: Headers.jsonContentType,
          ),
        );

        // 5.2. Verificação de 'mounted':
        // Garante que o widget ainda está ativo na árvore de widgets antes de usar 'context'.
        // Isso evita erros se o usuário sair da tela antes da resposta da API.
        if (!mounted) return;

        // 5.3. Processamento da Resposta da API:
        // Verifica o código de status HTTP da resposta.
        // 200 (OK) ou 201 (Created) geralmente indicam sucesso.
        if (response.statusCode == 200 || response.statusCode == 201) {
          // Exibe uma mensagem de sucesso na parte inferior da tela.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mensagem enviada com sucesso!')),
          );
          // Limpa os campos do formulário para uma nova entrada.
          _nameController.clear();
          _emailController.clear();
          _subjectController.clear();
          _messageController.clear();
        } else {
          // Se o status não for de sucesso, indica um erro vindo da API.
          // Imprime detalhes do erro no console apenas em modo de depuração (kDebugMode).
          if (kDebugMode) {
            print('Erro ao enviar mensagem: ${response.statusCode}');
            print('Corpo da resposta: ${response.data}');
          }
          // Exibe uma mensagem de falha com o código de status.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Falha ao enviar mensagem. Status: ${response.statusCode}',
              ),
            ),
          );
        }
      } on DioException catch (e) {
        // 5.4. Tratamento de Erros Específicos do Dio:
        // Captura exceções lançadas pelo Dio (ex: erros de rede, timeout, etc.).

        // Verifica 'mounted' novamente antes de usar 'context'.
        if (!mounted) return;

        if (e.response != null) {
          // Erro com resposta do servidor (ex: 404 Not Found, 500 Internal Server Error).
          if (kDebugMode) {
            print('Erro de resposta do Dio: ${e.response!.statusCode}');
            print('Dados do erro: ${e.response!.data}');
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Falha ao enviar. Erro do servidor: ${e.response!.statusCode}',
              ),
            ),
          );
        } else {
          // Erro sem resposta do servidor (ex: problema de conexão à internet, URL incorreta).
          if (kDebugMode) {
            print('Erro de conexão ou configuração do Dio: $e');
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Erro de conexão. Verifique sua rede e o servidor.',
              ),
            ),
          );
        }
      } catch (e) {
        // 5.5. Tratamento de Outros Erros Inesperados:
        // Captura qualquer outra exceção que não seja do tipo DioException.

        // Verifica 'mounted' antes de usar 'context'.
        if (!mounted) return;

        if (kDebugMode) {
          print('Erro inesperado: $e');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ocorreu um erro inesperado.')),
        );
      }
    } else {
      // 6. Feedback de Validação Falha:
      // Se o formulário não for válido (algum campo não passou na validação).
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos corretamente.'),
        ),
      );
    }
  }
}
