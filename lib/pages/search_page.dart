library;

/// Pagina stateful que implementará a página de pesquisa

import 'package:flutter/foundation.dart'; // Para kDebugMode
import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // Para requisições HTTP
import 'package:intl/intl.dart'; // Para formatação de moeda/data (se precisar)

import '../template/myappbar.dart';
import '../template/mydrawer.dart';
import '../template/myfooter.dart';
import '../template/config.dart'; // Para Config.endPoint

final pageName = 'Pesquisar Livros';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final TextEditingController _searchController =
      TextEditingController(); // Controlador para o campo de texto
  List<dynamic> _books = []; // Lista para armazenar os livros encontrados
  bool _isLoading = false; // Estado de carregamento
  String? _error; // Mensagem de erro
  final Dio _dio = Dio(); // Instância do Dio para requisições HTTP

  @override
  void dispose() {
    _searchController
        .dispose(); // Libera o controlador quando o widget é descartado
    super.dispose();
  }

  // Método para buscar os livros na API com base no termo de pesquisa
  Future<void> _fetchBooks(String searchTerm) async {
    // Limpa o termo de busca para evitar espaços extras
    final cleanedSearchTerm = searchTerm.trim();

    if (cleanedSearchTerm.isEmpty) {
      // Se o termo de busca estiver vazio, não faz a requisição, apenas limpa os resultados
      setState(() {
        _books = [];
        _isLoading = false;
        _error = null;
      });
      return;
    }

    setState(() {
      _isLoading = true; // Inicia o carregamento
      _error = null; // Limpa qualquer erro anterior
      _books = []; // Limpa os livros anteriores enquanto carrega novos
    });

    try {
      final Response response = await _dio.get(
        '${Config.endPoint['listAll']}&q=$cleanedSearchTerm',
      );

      if (!mounted) return; // Verifica se o widget ainda está montado

      if (response.statusCode == 200) {
        setState(() {
          // O JSON Server retorna uma lista diretamente para GETs de recursos
          // Se a sua API real envolve um campo 'data' (como no seu exemplo de db.json),
          // você precisará ajustar para `response.data['data']` se necessário.
          // Para o JSON Server, `response.data` já é a lista de livros.
          _books = response.data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Falha ao carregar livros: ${response.statusCode}';
          _isLoading = false;
        });
        if (kDebugMode) {
          print('Erro ao carregar livros: ${response.statusCode}');
          print('Corpo da resposta: ${response.data}');
        }
      }
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        if (e.response != null) {
          _error = 'Erro do servidor: ${e.response!.statusCode}';
        } else {
          _error = 'Erro de conexão: ${e.message}';
        }
      });
      if (kDebugMode) {
        print('Erro Dio ao carregar livros: $e');
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Ocorreu um erro inesperado: $e';
        _isLoading = false;
      });
      if (kDebugMode) {
        print('Erro inesperado ao carregar livros: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: pageName),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de pesquisa e botão
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Pesquisar por título, autor ou descrição',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (value) {
                      // Dispara a busca quando o usuário pressiona "Enter" no teclado
                      _fetchBooks(value);
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Dispara a busca quando o botão é pressionado
                    _fetchBooks(_searchController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    backgroundColor: Colors.blue, // Cor de fundo do botão
                    foregroundColor: Colors.white, // Cor do texto do botão
                  ),
                  child: const Text('Buscar'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Espaçamento entre o formulário e os resultados

            // Área de exibição dos resultados (CircularProgressIndicator, Erro, Mensagem, Lista de Cards)
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_error!),
                          ElevatedButton(
                            onPressed: () =>
                                _fetchBooks(_searchController.text),
                            child: const Text('Tentar Novamente'),
                          ),
                        ],
                      ),
                    )
                  : _books.isEmpty
                  ? Center(
                      child: Text(
                        _searchController.text.isEmpty
                            ? 'Digite algo para pesquisar.'
                            : 'Nenhum livro encontrado para "${_searchController.text}".',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(4.0),
                      // Padding menor para a lista em si
                      itemCount: _books.length,
                      itemBuilder: (context, index) {
                        final book = _books[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 4.0,
                          ),
                          elevation: 2.0,
                          child: InkWell(
                            onTap: () {
                              // Navega para a página de visualização do livro
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
                                  if (book['cover'] != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6.0),
                                      child: Image.network(
                                        book['cover'],
                                        width: 80,
                                        height: 120,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                                  Icons.broken_image,
                                                  size: 80,
                                                ),
                                      ),
                                    ),
                                  const SizedBox(width: 12.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          book['title'] ??
                                              'Título Desconhecido',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        Text(
                                          'Autor: ${book['author'] ?? 'Desconhecido'}',
                                        ),
                                        Text(
                                          'Ano: ${book['pubyear'] ?? 'N/A'}',
                                        ),
                                        Text('ISBN: ${book['isbn'] ?? 'N/A'}'),
                                        // Exibindo created_at formatado (como na HomePage)
                                        Text(
                                          'Cadastrado em: ${book['created_at'] != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(book['created_at']).toLocal()) : 'N/A'}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
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
            ),
          ],
        ),
      ),
      drawer: const MyDrawer(),
      bottomNavigationBar: const MyBottomNavBar(),
    );
  }
}
