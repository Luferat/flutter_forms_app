/// lib/post_book.dart
/// Este arquivo demonstra como enviar (POST) um novo livro para a API REST
/// utilizando a biblioteca Dio em Dart.
library;

import 'package:dio/dio.dart'; // Importa a biblioteca Dio para realizar requisições HTTP.

// Cria uma instância global do Dio.
// É uma boa prática reutilizar a mesma instância para otimizar a gestão de conexões HTTP.
final _dio = Dio();

// Define uma função assíncrona para postar (salvar) um novo livro.
// Ela aceita um Map<String, dynamic> que representa os dados do livro a ser salvo.
Future<void> postNewBook(Map<String, dynamic> bookData) async {
  // URL do endpoint para adicionar novos livros.
  // No JSON Server, geralmente é o mesmo endpoint da lista (ex: /books).
  const String apiUrl = 'http://localhost:8080/books';

  // Inicia um bloco try-catch para gerenciar e capturar possíveis erros
  // durante a requisição de rede ou o processamento da resposta.
  try {
    // Realiza uma requisição POST para a API.
    // 'await' pausa a execução até a resposta da API.
    // O Dio enviará 'bookData' como corpo da requisição no formato JSON.
    // **Vantagem do Dio aqui:** Ele automaticamente serializa o Map Dart para JSON
    // e define o cabeçalho 'Content-Type: application/json'.
    final response = await _dio.post(
      apiUrl,
      data: bookData, // Os dados do livro a serem enviados
    );

    // Verifica se o status da resposta HTTP indica sucesso (código 201 Created é comum para POST).
    if (response.statusCode == 201) {
      // Extrai os dados do livro criado que a API retorna (geralmente inclui o ID gerado).
      final newBook = response.data;
      print('--- Livro salvo com sucesso! ---');
      print('ID: ${newBook['id']}');
      print('Título: ${newBook['title']}');
      print('Autor: ${newBook['author']}');
      print('Preço: ${newBook['price']}'); // Preço bruto, sem formatação aqui.
      print('-------------------------------\n');
    } else {
      // Se a requisição foi concluída, mas com um status diferente de 201.
      print('Erro ao salvar livro: Status ${response.statusCode}');
      print('Corpo da resposta: ${response.data}');
    }
  } on DioException catch (e) {
    // Captura exceções específicas do Dio (erros de rede, timeouts, erros HTTP 4xx/5xx).
    if (e.response != null) {
      // Se houver uma resposta do servidor, imprime o status e os dados do erro.
      print('Erro do servidor ao salvar livro: Status ${e.response!.statusCode}');
      print('Dados do erro: ${e.response!.data}');
    } else {
      // Se não houver resposta, indica um problema de conexão ou configuração.
      print('Erro de conexão ou configuração ao salvar livro: ${e.message}');
    }
  } catch (e) {
    // Captura qualquer outro erro inesperado.
    print('Ocorreu um erro inesperado ao salvar livro: $e');
  }
}

// Função main para demonstrar o uso da função postNewBook.
void main() async {
  print('Tentando salvar um novo livro...');

  // Dados do novo livro que queremos enviar.
  // Note que o 'id' não é necessário, pois o JSON Server o gera automaticamente.
  final Map<String, dynamic> exampleBook = {
    'title': 'Aventuras na Floresta Encantada',
    'author': 'Fada Madrinha',
    'pubyear': 2024,
    'isbn': '978-85-333-0123-4',
    'price': 49.90,
    'description': 'Uma emocionante jornada através de florestas místicas e encontros com criaturas mágicas.',
    'cover': 'https://picsum.photos/204/305', // URL de exemplo
    'status': 'ON',
    'created_at': DateTime.now().toIso8601String(),
  };

  // Chama a função para postar o novo livro.
  await postNewBook(exampleBook);

  print('Demonstração de postagem de livro concluída.');
}