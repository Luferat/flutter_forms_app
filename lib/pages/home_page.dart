library;

/// Página inicial do aplicativo
///     Obtém e exibe a lista de itens da API

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forms_app/template/mydrawer.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

import '../template/config.dart';
import '../template/myappbar.dart';
import '../template/myfooter.dart';

final pageName = Config.appName;

final _dio = Dio();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<dynamic> _books = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  // Método para buscar os livros da API
  Future<void> _fetchBooks() async {
    // State inicial do aplicativo
    setState(() {
      _isLoading = true; // Inicia o carregamento
      _error = null; // Limpa qualquer erro anterior
    });

    try {
      // ⭐️ _apiUrl agora tem certeza de não ser nulo aqui
      final Response response = await _dio.get(Config.endPoint['listAll'],);

      // Debug: Mostra no terminal, os dados recebidos, já como List<Map>
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
        setState(() {
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
      appBar: MyAppBar(title: pageName,),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : _error != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error!),
            ElevatedButton(
              onPressed: _fetchBooks,
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      )
          : _books.isEmpty
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
            child: InkWell(
              onTap: () {
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
                          const Icon(Icons.broken_image,
                              size: 80),
                        ),
                      ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
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
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}