/// lib/delete_book.dart
/// Este arquivo demonstra como "desativar" um livro na API REST,
/// atualizando seu status para "OFF" usando a biblioteca Dio em Dart.
/// Ele solicita o ID do livro ao usuário via terminal.
library;

import 'dart:io'; // Importa a biblioteca para entrada/saída de console
import 'package:dio/dio.dart'; // Importa a biblioteca Dio para realizar requisições HTTP.

// Cria uma instância global do Dio.
final _dio = Dio();

// Define uma função assíncrona para "desativar" um livro.
// Ela aceita o ID do livro a ser atualizado.
Future<void> deactivateBook(int bookId) async {
  // URL do endpoint para atualizar um livro específico pelo ID.
  // Ex: http://localhost:8080/books/5
  final String apiUrl = 'http://localhost:8080/books/$bookId';

  // O corpo da requisição conterá apenas o campo 'status' a ser atualizado para "OFF".
  final Map<String, String> updateData = {
    'status': 'OFF',
  };

  // Inicia um bloco try-catch para gerenciar possíveis erros.
  try {
    // Realiza uma requisição PATCH para a API.
    // PATCH é usado para aplicar modificações parciais a um recurso.
    // O Dio envia 'updateData' como JSON no corpo da requisição.
    final response = await _dio.patch(
      apiUrl,
      data: updateData, // Os dados a serem atualizados (apenas o status)
    );

    // Verifica se o status da resposta HTTP indica sucesso (código 200 OK é comum para PATCH/PUT).
    if (response.statusCode == 200) {
      final updatedBook = response.data;
      print('--- Livro ID $bookId desativado com sucesso! ---');
      print('Título: ${updatedBook['title']}');
      print('Status Atual: ${updatedBook['status']}');
      print('-------------------------------\n');
    } else if (response.statusCode == 404) {
      // Trata especificamente o caso de livro não encontrado.
      print('Erro: Livro com ID $bookId não encontrado para desativar.');
    } else {
      // Se a requisição foi concluída, mas com um status diferente de 200/404.
      print('Erro ao desativar livro: Status ${response.statusCode}');
      print('Corpo da resposta: ${response.data}');
    }
  } on DioException catch (e) {
    // Captura exceções específicas do Dio.
    if (e.response != null) {
      print('Erro do servidor ao desativar livro: Status ${e.response!.statusCode}');
      if (e.response!.statusCode == 404) {
        print('Detalhe: Livro com ID $bookId não existe na API.');
      } else {
        print('Dados do erro: ${e.response!.data}');
      }
    } else {
      // Problema de conexão ou configuração.
      print('Erro de conexão ou configuração ao desativar livro: ${e.message}');
    }
  } catch (e) {
    // Captura qualquer outro erro inesperado.
    print('Ocorreu um erro inesperado ao desativar livro: $e');
  }
}

// Função main para demonstrar o uso da função deactivateBook.
void main() async {
  print('--- Ferramenta de Desativação de Livros ---');
  stdout.write('Digite o ID do livro que deseja desativar (definir status para "OFF"): ');

  // Lê a entrada do usuário.
  String? input = stdin.readLineSync();

  // Tenta converter a entrada para um inteiro.
  int? bookId = int.tryParse(input ?? '');

  // Valida a entrada do usuário.
  if (bookId == null) {
    print('ID inválido. Por favor, insira um número.');
    return; // Encerra a execução se o ID for inválido.
  }

  print('Tentando desativar o livro ID $bookId...');
  // Chama a função para desativar o livro.
  await deactivateBook(bookId);

  print('Demonstração de desativação de livro concluída.');
}