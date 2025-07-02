library;

/// Página inicla do Aplicativo
/// Recebe dados JSON da API (books) e exibe na view

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forms_app/template/mydrawer.dart';

// Importa bilbioteca de internacionalização
// Converte datas, moedas, dias da semana, meses
import 'package:intl/intl.dart';

// importa a biblioteca Dio que processa HTTP
import 'package:dio/dio.dart';

import '../template/myappbar.dart';
import '../template/myfooter.dart';

// Cria um aplicativo Dio
final _dio = Dio();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

// Processa o 'state' do aplicativo e exibe a home page
class _HomePage extends State<HomePage> {
  // Atributos do state
  List<dynamic> _books = []; // Lista para armazenar os livros
  bool _isLoading = true; // Indica se estamos carregando os dados
  String? _error; // Armazena mensagens de erro, se houver

  @override
  void initState() {
    super.initState();
    _fetchBooks(); // Inicia a busca pelos livros quando o widget é criado
  }

  // Método para buscar os livros da API
  Future<void> _fetchBooks() async {
    // State inicial do aplicativo
    setState(() {
      _isLoading = true; // Inicia o carregamento
      _error = null; // Limpa qualquer erro anterior
    });

    // URL da API do JSON Server para livros
    // Isso deveria estar em um config global
    // status=ON e sort=created_at já estão implementados na API real
    final String apiUrl =
        'http://localhost:8080/books?status=ON&_sort=created_at';
    // Só executa daqui para baixo quando "response" existir

    try {
      // Recebe os dados da API quando eles estiverem prontos
      final Response response = await _dio.get(apiUrl);

      // Debug: Mostra no terminal, os dados recebeidos, já como List<Map>
      // Apague isso em produção
      if (kDebugMode) {
        print('\n\n--------------------');
        print(response.headers); // Cabeçalho HTTP
        print('--------------------');
        print(response.statusCode); // Status HTTP
        print('--------------------');
        print(response.data); // Dados do response
        print('--------------------\n\n');
      }

      // Verifica se o widget ainda está montado antes de atualizar o estado
      if (!mounted) return;

      // Se a requisição foi um sucesso...
      if (response.statusCode == 200) {
        // Atualiza o 'state' do aplicativo
        setState(() {
          // Dio já retorna os dados JSON como List<Map>
          _books = response.data;

          // Finaliza o carregamento
          _isLoading = false;
        });
      } else {
        // Se algo deu errado na requisição, atualiza o state com mensagem de erro...
        setState(() {
          _error = 'Falha ao carregar livros: ${response.statusCode}';
          _isLoading = false;
        });

        // Debug - Apague isso em produção
        if (kDebugMode) {
          print('Erro ao carregar livros: ${response.statusCode}');
          print('Corpo da resposta: ${response.data}');
        }
      }
    } on DioException catch (e) {
      // Excessões do Dio também atualizam o state com mensagens de erro
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        if (e.response != null) {
          _error = 'Erro do servidor: ${e.response!.statusCode}';
        } else {
          _error = 'Erro de conexão: ${e.message}';
        }
      });

      // Debug - Apague isso em produção
      if (kDebugMode) {
        print('Erro Dio ao carregar livros: $e');
      }
    } catch (e) {
      // Erros do aplicativo são tratados e atualizam o state com mensagens de
      // erro, aqui...
      if (!mounted) return;
      setState(() {
        _error = 'Ocorreu um erro inesperado: $e';
        _isLoading = false;
      });

      // Debug - Apague isso em produção
      if (kDebugMode) {
        print('Erro inesperado ao carregar livros: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Cabelho da página
      appBar: MyAppBar(),

      body:
          _isLoading // True ou False
          ? const Center(
              child: CircularProgressIndicator(),
            ) // Exibe indicador de carregamento
          : _error != null
          ? Center(
              // Erro ao obter livros
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_error!), // Exibe mensagem de erro
                  ElevatedButton(
                    onPressed: _fetchBooks,
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            )
          : _books
                .isEmpty // A lista de livros é vazia
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Nenhum livro encontrado.'),
                  ElevatedButton(
                    onPressed: _fetchBooks,
                    child: const Text('Recarregar'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              // Temos livros, executa um loop para iterar...
              // Exibe a lista de livros
              padding: const EdgeInsets.all(20.0),
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 4.0,
                  ),
                  elevation: 2.0,
                  // Torna o card clicável
                  child: InkWell(
                    onTap: () {
                      // Navega para a rota /view passando o ID do livro
                      Navigator.pushNamed(
                        context,
                        '/view',
                        arguments: book['id'],
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Imagem da capa (se existir)
                          if (book['cover'] != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: Image.network(
                                book['cover'],
                                width: 80,
                                height: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 80),
                              ),
                            ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book['title'] ?? 'Título Desconhecido',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Autor: ${book['author'] ?? 'Desconhecido'}',
                                ),
                                Text('Ano: ${book['pubyear'] ?? 'N/A'}'),
                                Text('ISBN: ${book['isbn'] ?? 'N/A'}'),

                                const SizedBox(width: 15.0),
                                Text(
                                  'Preço: ${book['price'] != null ? NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$ ', decimalDigits: 2).format(book['price']) : 'Esgotado'}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

      drawer: MyDrawer(),

      // Rodapé da página
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
