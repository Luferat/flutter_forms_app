import 'dart:io'; // Para verificar a plataforma (iOS ou Android)
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import '../template/myappbar.dart';
import '../template/myfooter.dart';

// ... (seus imports existentes)

class DeviceView extends StatefulWidget {
  const DeviceView({super.key});

  @override
  State<DeviceView> createState() => _DeviceView();
}

class _DeviceView extends State<DeviceView> {
  String _deviceInfo = 'Obtendo informações do dispositivo...';

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      setState(() {
        _deviceInfo =
        'Modelo: ${androidInfo.model}\nFabricante: ${androidInfo.manufacturer}\nVersão Android: ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})';
      });
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      setState(() {
        _deviceInfo =
        'Modelo: ${iosInfo.model}\nNome: ${iosInfo.name}\nSistema: ${iosInfo.systemName} ${iosInfo.systemVersion}';
      });
    } else {
      setState(() {
        _deviceInfo = 'Plataforma não suportada.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Informações do Dispositivo'),
      bottomNavigationBar: MyBottomNavBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Detalhes do Dispositivo:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text(
              _deviceInfo,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getDeviceInfo,
              child: Text('Atualizar Informações'),
            ),
          ],
        ),
      ),
    );
  }
}
