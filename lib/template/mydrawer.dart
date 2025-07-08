library;

/// Menu lateral
/// Pode ser usado em qualquer página. Exemplo de uso:
///  return Scafold(
///    drawer: Mydrawer(),
///    ...
///  );

import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // Cabeçalho do menu
          DrawerHeader(
            child: Center(
              child: Text(
                'Meu Aplicativo',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
              ),
            ),
          ),

          // Acesso à página inicial → '/'
          ListTile(
            title: Text('Inicio'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),

          // Acesso à página de contatos → '/contacts'
          ListTile(
            title: Text('Contatos'),
            leading: Icon(Icons.contact_mail),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/contacts');
            },
          ),

          // Acesso à página de do GPS → '/geolocation'
          ListTile(
            title: Text('Localização'),
            leading: Icon(Icons.contact_mail),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/geolocation');
            },
          ),
        ],
      ),
    );
  }
}
