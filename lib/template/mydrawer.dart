import 'package:flutter/material.dart';

// Menu lateral
// Pode ser usado em qualquer página
//  return Scafold(
//    drawer: Mydrawer(),
//    ...
//  );
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'Meu Aplicativo',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
              ),
            ),
          ),
          ListTile(
            title: Text('Inicio'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            title: Text('Contatos'),
            leading: Icon(Icons.contact_mail),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/contacts');
            },
          ),
        ],
      ),
    );
  }
}