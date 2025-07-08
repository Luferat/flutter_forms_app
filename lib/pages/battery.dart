import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

import '../template/myappbar.dart';
import '../template/myfooter.dart';

class BattteryView extends StatefulWidget {
  const BattteryView({super.key});

  @override
  State<BattteryView> createState() => _BattteryView();
}

class _BattteryView extends State<BattteryView> {
  String _batteryLevel = 'Bateria: Carregando...';
  late Battery _battery; // Use 'late' para inicializar no initState

  @override
  void initState() {
    super.initState();
    _battery = Battery();
    _getBatteryInfo();
    _listenToBatteryStateChanges();
  }

  Future<void> _getBatteryInfo() async {
    final batteryLevel = await _battery.batteryLevel;
    setState(() {
      _batteryLevel = 'Nível da Bateria: $batteryLevel%';
    });
  }

  void _listenToBatteryStateChanges() {
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        switch (state) {
          case BatteryState.full:
            _batteryLevel = 'Bateria: Cheia';
            break;
          case BatteryState.charging:
            _batteryLevel = 'Bateria: Carregando...';
            break;
          case BatteryState.discharging:
            _batteryLevel = 'Bateria: Descarregando';
            break;
          case BatteryState.unknown:
            _batteryLevel = 'Bateria: Estado desconhecido';
            break;
          default:
            _batteryLevel = 'Bateria: Estado desconhecido';
            break;
        }
      });
      _getBatteryInfo(); // Atualiza o nível junto com o estado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Bateria'),
      bottomNavigationBar: MyBottomNavBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Informações do Dispositivo:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text(
              _batteryLevel,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getBatteryInfo,
              child: Text('Atualizar Bateria'),
            ),
          ],
        ),
      ),
    );
  }
}
