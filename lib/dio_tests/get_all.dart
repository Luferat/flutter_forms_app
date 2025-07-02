/// Este arquivo demonstra como fazer uma requisição HTTP GET para uma API REST
/// que retorna dados no formato JSON, utilizando a biblioteca Dio em Dart.
/// O Dio simplifica o processo de comunicação com APIs externas, oferecendo
/// funcionalidades robustas e um tratamento de erros mais amigável.
/// OBS: comentários gerados por IA
library; // Declara que este é um arquivo de biblioteca (opcional para main.dart)

import 'package:dio/dio.dart'; // Importa a biblioteca Dio, essencial para requisições HTTP avançadas.

// Cria uma instância global do Dio.
// É uma boa prática reutilizar a mesma instância para otimizar a gestão de conexões HTTP.
final _dio = Dio();

// Define a função principal assíncrona do programa.
// A palavra-chave 'async' indica que esta função pode realizar operações que levam tempo (assíncronas).
Future<void> main() async {
  // Inicia um bloco try-catch para gerenciar e capturar possíveis erros que podem ocorrer
  // durante a requisição de rede ou o processamento dos dados.
  try {
    // Realiza uma requisição GET para a URL da API ('http://localhost:8080/books').
    // O 'await' pausa a execução deste código até que a resposta da API chegue.
    // **A GRANDE VANTAGEM DO DIO AQUI:**
    // Ele não só faz a requisição, mas também **automaticamente decodifica a resposta JSON**
    // para tipos Dart nativos (como List<dynamic> ou Map<String, dynamic>),
    // e lida com o tratamento de status de resposta HTTP de forma centralizada.
    final response = await _dio.get('http://localhost:8080/books?status=ON&_sort=created_at');

    // Verifica se o status da resposta HTTP indica sucesso (código 200 OK).
    if (response.statusCode == 200) {
      // Extrai os dados já decodificados da resposta HTTP.
      // Se a resposta JSON for um array (como esperado de '/books'),
      // o Dio a transforma diretamente em uma List<dynamic>,
      // onde cada 'dynamic' é um Map<String, dynamic> representando um livro.
      List<dynamic> allItems = response.data;

      // Declara uma variável 'item' para ser usada no loop.
      // Ela representará cada livro individualmente, tipado como Map<String, dynamic>.
      Map<String, dynamic> item;
      // Inicia um loop 'for-in' para percorrer cada 'item' (cada livro) dentro da lista 'allItems'.
      for (item in allItems) {
        // Declara uma variável para armazenar o preço do livro após a formatação.
        String formattedPrice;
        // Verifica se o campo 'price' existe no item atual e se não é nulo.
        if (item['price'] != null) {
          // Converte o valor de 'price' (que pode ser int ou double) para 'double'.
          // Em seguida, formata esse 'double' em uma string com exatamente duas casas decimais.
          // O método 'toStringAsFixed(2)' usa um ponto '.' como separador decimal.
          String priceString = (item['price'] as num)
              .toDouble()
              .toStringAsFixed(
            2, // Define que a string terá duas casas decimais.
          );
          // Substitui o ponto '.' pelo caractere de vírgula ',' na string do preço.
          // Em seguida, concatena o prefixo 'R$ ' para formar o preço no formato brasileiro.
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
        // Imprime o preço formatado do livro, utilizando a string 'formattedPrice' criada anteriormente.
        print('Preço: $formattedPrice');
      }
    } else {
      // Se o status da resposta não for 200 OK, imprime um erro indicando o código de status.
      // Note: Para DioException, o tratamento é mais detalhado abaixo no catch.
      // Este 'else' captura casos onde a requisição foi bem-sucedida, mas o servidor
      // retornou um código de status não-200 sem lançar uma DioException (menos comum).
      print('Erro na requisição: Status ${response.statusCode}');
    }

    // Captura exceções específicas do Dio. Essas exceções são lançadas para
    // erros de rede (sem conexão), timeouts, ou respostas HTTP com status de erro (4xx, 5xx).
  } on DioException catch (e) {
    // Verifica se a DioException contém uma resposta HTTP (indicando um erro do servidor).
    if (e.response != null) {
      // Imprime o código de status HTTP do erro (ex: 404 Not Found, 500 Internal Server Error).
      print('Erro de resposta da API: ${e.response!.statusCode}');
      // Imprime os dados (corpo) da resposta de erro recebida da API.
      print('Dados do erro: ${e.response!.data}');
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