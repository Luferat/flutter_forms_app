import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../template/myappbar.dart';
import '../template/myfooter.dart';

class MyGPS extends StatefulWidget {
  const MyGPS({super.key});

  @override
  State<MyGPS> createState() => _MyGPS();
}

class _MyGPS extends State<MyGPS> {
  String _currentLocation = 'Localização não obtida';
  late String _mapsURL;

  @override
  void initState() {
    super.initState();
    _getLocation();
    _mapsURL = '';
  }

  // Função assíncrona para abrir o link
  Future<void> _launchExternalUrl() async {
    final Uri url = Uri.parse(_mapsURL); // Substitua pela URL desejada

    // Tente abrir a URL. O 'mode' padrão ou platformDefault é o mais indicado para web.
    if (!await launchUrl(
      url,
      mode: LaunchMode.platformDefault,
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível abrir o link: $url')),
      );
    }
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar se o serviço de localização está habilitado.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentLocation = 'Serviços de localização desabilitados.';
      });
      return;
    }

    // Verificar e solicitar permissões.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentLocation = 'Permissão de localização negada.';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _currentLocation =
            'Permissão de localização negada permanentemente. Por favor, habilite nas configurações.';
      });
      return;
    }

    // Obter a posição atual.
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLocation =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
        _mapsURL =
            'https://www.google.com.br/maps/@${position.latitude},${position.longitude}';
      });
    } catch (e) {
      setState(() {
        _currentLocation = 'Erro ao obter localização: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Geolocalização"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Sua Localização:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text(
              _currentLocation,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _launchExternalUrl,
              child: const Text('Abrir no Google Maps'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getLocation,
              child: Text('Atualizar Localização'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
