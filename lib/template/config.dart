class Config {
  static const String appName = "Hello Books";
  static const String copyright = "© 2025 Joca da Silva";

  /// Endereço da API
  // - Para API local na versão Web ou Windows, use "http://localhost:8080", por exemplo
  // - Para usar API local no emulador Android, use "http://10.0.2.2:8080", por exemplo
  // - Para API na Web, use o endereço desta "https://api.meusite.com", por exemplo
  static const String apiBaseUrl = "http://localhost:8080";

  static const Map<String, dynamic> endPoint = {
    // Neste exemplo, lista todos os itens com 'status=ON' e ordenados por 'created_at'
    'listAll': '/books?status=ON&_sort=created_at',
  };
}
