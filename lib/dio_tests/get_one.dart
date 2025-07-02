/// Este arquivo demonstra como fazer uma requisição HTTP GET para uma API REST
/// que retorna dados no formato JSON, utilizando a biblioteca Dio em Dart.
/// O Dio simplifica o processo de comunicação com APIs externas, oferecendo
/// funcionalidades robustas e um tratamento de erros mais amigável.
library;

import 'dart:io'; // Importa a biblioteca para entrada/saída de console
import 'package:dio/dio.dart'; // Importa a biblioteca Dio, essencial para requisições HTTP avançadas.

// Cria uma instância global do Dio.
// É uma boa prática reutilizar a mesma instância para otimizar a gestão de conexões HTTP.
final _dio = Dio();

// Define a função principal assíncrona do programa.
// A palavra-chave 'async' indica que esta função pode realizar operações que levam tempo (assíncronas).
Future<void> main() async {
  // Solicita ao usuário que digite o ID do livro
  stdout.write('\n\nDigite o ID do livro que deseja consultar: ');
  // Lê a linha digitada pelo usuário no console
  String? input = stdin.readLineSync();

  // Tenta converter a entrada do usuário para um número inteiro.
  // int.tryParse() é seguro porque retorna null se a string não for um número válido.
  int? bookId = int.tryParse(input ?? ''); // Usa '??' para garantir que input não é nulo

  // Verifica se o ID do livro é válido
  if (bookId == null) {
    print('ID inválido. Por favor, insira um número.');
    return; // Encerra a execução se o ID for inválido
  }

  // Inicia um bloco try-catch para gerenciar e capturar possíveis erros que podem ocorrer
  // durante a requisição de rede ou o processamento dos dados.
  try {
    // Realiza uma requisição GET para a URL da API, usando o bookId e o filtro de status.
    // O JSON Server, quando filtrado por parâmetros de consulta, retorna uma LISTA,
    // mesmo que haja apenas um item correspondente.
    // O 'await' pausa a execução deste código até que a resposta da API chegue.
    final response = await _dio.get('http://localhost:8080/books?id=$bookId&status=ON');

    // Verifica se o status da resposta HTTP indica sucesso (código 200 OK).
    if (response.statusCode == 200) {
      // Extrai os dados já decodificados da resposta HTTP.
      // Como estamos usando filtros na URL, o Dio retorna uma List<dynamic>.
      List<dynamic> allItems = response.data;

      // Verifica se a lista retornada não está vazia.
      // Se a lista estiver vazia, significa que nenhum livro com o ID e status 'ON' foi encontrado.
      if (allItems.isNotEmpty) {
        // Pega o primeiro item da lista (espera-se que seja o único livro correspondente).
        Map<String, dynamic> item = allItems[0];

        // Declara uma variável para armazenar o preço do livro após a formatação.
        String formattedPrice;
        // Verifica se o campo 'price' existe no item atual e se não é nulo.
        if (item['price'] != null) {
          // Converte o valor de 'price' (que pode ser int ou double) para 'double'.
          // Em seguida, formata esse 'double' em uma string com exatamente duas casas decimais,
          // usando ponto '.' como separador decimal (ex: 123.45).
          String priceString = (item['price'] as num)
              .toDouble()
              .toStringAsFixed(
            2, // Número de casas decimais fixas (duas).
          );
          // Substitui o ponto '.' pelo caractere de vírgula ',' na string do preço formatado.
          // E concatena com o prefixo 'R$ ' para formar o preço no formato brasileiro.
          formattedPrice = 'R\$ ${priceString.replaceAll('.', ',')}';
        } else {
          // Se o 'price' for nulo, define a string como 'Esgotado'.
          formattedPrice = 'Esgotado';
        }

        // Imprime no console duas linhas em branco, seguidas do ID e do Título do livro.
        print('\n\n${item['id']}) ${item['title']}');
        // Imprime a descrição completa do livro.
        print(item['description']);
        // Imprime o autor do livro, prefixado com um marcador de lista.
        print(' • Autor: ${item['author']}');
        // Imprime o ano de publicação do livro, prefixado com um marcador de lista.
        print(' • Publicação: ${item['pubyear']}');
        // Imprime o ISBN do livro, prefixado com um marcador de lista.
        print(' • ISBN: ${item['isbn']}');
        // Imprime o preço formatado do livro, utilizando a string 'formattedPrice'.
        print('Preço: R\$ $formattedPrice');
      } else {
        // Se a lista estiver vazia, significa que o livro com o ID e status 'ON' não foi encontrado.
        print('Livro com ID $bookId não encontrado.');
      }
    } else {
      // Se o status da resposta não for 200 OK, imprime um erro indicando o código de status.
      print('Erro na requisição: Status ${response.statusCode}');
    }

    // Captura exceções específicas do Dio. Essas exceções são lançadas para
    // erros de rede (sem conexão), timeouts, ou respostas HTTP com status de erro (4xx, 5xx).
  } on DioException catch (e) {
    // Verifica se a DioException contém uma resposta HTTP (indicando um erro do servidor).
    if (e.response != null) {
      // Imprime o código de status HTTP do erro (ex: 404 Not Found, 500 Internal Server Error).
      print('Erro de resposta da API: ${e.response!.statusCode}');
      // Se a resposta for 404, exibe uma mensagem mais amigável.
      if (e.response!.statusCode == 404) {
        print('Livro com ID $bookId não encontrado. Verifique o ID.');
      } else {
        // Imprime os dados (corpo) da resposta de erro recebida da API.
        print('Dados do erro: ${e.response!.data}');
      }
    } else {
      // Se não houver uma resposta HTTP, isso geralmente indica um problema
      // de conexão com a rede ou na configuração da requisição (ex: URL inválida).
      print('Erro de conexão ou configuração: $e');
    }
    // Captura qualquer outra exceção inesperada que não seja uma DioException.
  } catch (e) {
    // Imprime uma mensagem genérica para erros que não foram especificamente tratados.
    print('Ocorreu um erro inesperado: $e');
  }
}