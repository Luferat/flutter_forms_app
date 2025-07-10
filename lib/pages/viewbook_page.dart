library;

/// Visualizar livro
///     Exibe todos os detalhes de um livro identificado pelo Id
///     O Id é passado como argumento da rota e processado por 'myapp.dart'

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../template/config.dart';
import '../template/myappbar.dart';
import '../template/myfooter.dart'; // Para kDebugMode

// Instância do Dio (a mesma que você usa em main.dart)
// É importante que seja a mesma instância ou uma nova configurada da mesma forma,
// para consistência e possível tratamento de cookies, etc.
final Dio _dio = Dio();

// Página 'view'
class ViewBookPage extends StatefulWidget {
  final int bookId; // Receberá o ID do livro pela rota

  // Construtor recebe o Id do livro
  const ViewBookPage({super.key, required this.bookId});

  @override
  State<ViewBookPage> createState() => _ViewBookPage();
}

class _ViewBookPage extends State<ViewBookPage> {
  Map<String, dynamic>? _bookDetails; // Para armazenar os detalhes do livro
  bool _isLoading = true; // Indica se estamos carregando
  String? _error; // Armazena a mensagem de erro

  @override
  void initState() {
    super.initState();
    _fetchBookDetails(); // Inicia a busca pelos detalhes do livro
  }

  // Método para buscar os detalhes do livro específico
  Future<void> _fetchBookDetails() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final Response response = await _dio.get('${Config.endPoint['listOne']}${widget.bookId}');

      if (!mounted) return; // Verifica se o widget ainda está montado

      if (response.statusCode == 200) {
        setState(() {
          // Dio já faz o parsing do JSON
          // O índice [0] é necessário por conta do response JSON do "json-server"
          _bookDetails = response.data[0];
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Livro não encontrado ou erro: ${response.statusCode}';
          _isLoading = false;
        });
        if (kDebugMode) {
          print('Erro ao carregar detalhes do livro: ${response.statusCode}');
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
        print('Erro Dio ao carregar detalhes do livro: $e');
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Ocorreu um erro inesperado: $e';
        _isLoading = false;
      });
      if (kDebugMode) {
        print('Erro inesperado ao carregar detalhes do livro: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: _bookDetails?['title'] ?? 'Detalhes do Livro'),

      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            ) // Indicador de carregamento
          : _error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_error!), // Mensagem de erro
                  ElevatedButton(
                    onPressed: _fetchBookDetails,
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            )
          : _bookDetails == null || _bookDetails!.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Livro não encontrado.'),
                  ElevatedButton(
                    onPressed: _fetchBookDetails,
                    child: const Text('Recarregar'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              // Permite rolar se o conteúdo for grande
              padding: const EdgeInsets.all(22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagem da capa
                  if (_bookDetails!['cover'] != null)
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          _bookDetails!['cover'],
                          width:
                              MediaQuery.of(context).size.width *
                              0.7, // 70% da largura da tela
                          height:
                              MediaQuery.of(context).size.height *
                              0.4, // 40% da altura da tela
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.broken_image,
                                size: 150,
                                color: Colors.grey,
                              ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 24.0),
                  // Título
                  Text(
                    _bookDetails!['title'] ?? 'Título Desconhecido',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  // Autor e Ano
                  Text(
                    'Autor: ${_bookDetails!['author'] ?? 'Desconhecido'}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Ano de Publicação: ${_bookDetails!['pubyear'] ?? 'N/A'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12.0),
                  // ISBN
                  Text(
                    'ISBN: ${_bookDetails!['isbn'] ?? 'N/A'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8.0),
                  // Status
                  Text(
                    // Verifica se 'price' existe e não é nulo.
                    // Se sim, tenta converter para double e formata para moeda brasileira.
                    // Se não, exibe 'N/A'.
                    'Preço: ${_bookDetails!['price'] != null ? NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$ ', decimalDigits: 2).format(_bookDetails!['price']) : 'N/A'}',
                    style: const TextStyle(
                      // Use const se o TextStyle não mudar
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Descrição
                  const Text(
                    'Descrição:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    _bookDetails!['description'] ?? 'Sem descrição disponível.',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16.0),
                  // Data de Cadastro
                  Text(
                    'Cadastrado em: ${_bookDetails!['created_at'] != null ? DateTime.parse(_bookDetails!['created_at']).toLocal().toString().split(' ')[0] : 'N/A'}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
