library;

/// Menu lateral
/// Pode ser usado em qualquer página. Exemplo de uso:
///  return Scafold(
///    drawer: Mydrawer(),
///    ...
///  );

import 'package:flutter/material.dart';

import 'config.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        // ⭐️ Mude o ListView para Column para usar Expanded
        children: [
          // Cabeçalho do menu
          const DrawerHeader(
            // Use const se o conteúdo for estático
            child: Center(
              child: Text(
                'Meu Aplicativo',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
              ),
            ),
          ),

          // Acesso à página inicial → '/'
          ListTile(
            title: const Text('Inicio'), // Use const
            leading: const Icon(Icons.home), // Use const
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),

          // Acesso à página de contatos → '/contacts'
          ListTile(
            title: const Text('Contatos'), // Use const
            leading: const Icon(Icons.contact_mail), // Use const
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/contacts');
            },
          ),

          // Acesso à página de do GPS → '/geolocation'
          ListTile(
            title: const Text('Localização'), // Use const
            leading: const Icon(Icons.explore), // Use const
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/geolocation');
            },
          ),

          // Status da Bateria
          ListTile(
            title: const Text('Bateria'), // Use const
            leading: const Icon(Icons.battery_std), // Use const
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/battery');
            },
          ),

          // Dados do Dispositivo
          ListTile(
            title: const Text('Dispositivo'), // Use const
            leading: const Icon(Icons.mobile_friendly), // Use const
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/device');
            },
          ),

          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  '${Config.copyright}\nTodos os direitos reservados',
                  // ⭐️ AGORA FUNCIONARÁ!
                  style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
