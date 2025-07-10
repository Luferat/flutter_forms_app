library;

/// Experimento com biometria
///     Isso só funciona com dispositivos com biometria habilitada.
///     Não funciona na versão Web (Chrome)

import 'package:flutter/material.dart';
import 'package:flutter_forms_app/template/myappbar.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

import '../template/myfooter.dart'; // Para customizar prompts Android

final pageName = 'Autenticação Biométrica';

class BiometricAuth extends StatefulWidget {
  const BiometricAuth({super.key});

  @override
  State<BiometricAuth> createState() => _BiometricAuthState();
}

class _BiometricAuthState extends State<BiometricAuth> {
  final LocalAuthentication auth = LocalAuthentication();
  String _authorized = 'Não autorizado';

  @override
  void initState() {
    super.initState();
    // Você pode chamar _checkBiometrics ou _authenticate no initState se quiser
    // que a autenticação ocorra automaticamente ao abrir a tela.
  }

  // 1. Verificar a disponibilidade de biometria
  Future<bool> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      print("Erro ao verificar biometria: $e");
      canCheckBiometrics = false;
    }
    if (!mounted) return false;
    print("Pode checar biometria: $canCheckBiometrics");
    return canCheckBiometrics;
  }

  // 2. Obter os tipos de biometria disponíveis
  Future<List<BiometricType>> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics = [];
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      print("Erro ao obter biometrias disponíveis: $e");
    }
    if (!mounted) return [];
    print("Biometrias disponíveis: $availableBiometrics");
    return availableBiometrics;
  }

  // 3. Realizar a autenticação
  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _authorized = 'Iniciando autenticação...';
      });

      // Personalizando as mensagens dos prompts de autenticação nativos
      const androidStrings = AndroidAuthMessages(
        signInTitle: 'Autenticação Necessária',
        biometricHint: 'Toque o sensor de impressão digital',
        cancelButton: 'Cancelar',
        goToSettingsButton: 'Configurações',
        goToSettingsDescription: 'Por favor, configure sua biometria.',
        biometricRequiredTitle: 'Biometria Requerida',
      );

      authenticated = await auth.authenticate(
        localizedReason: 'Por favor, autentique para acessar o aplicativo', // Mensagem mostrada ao usuário
        options: const AuthenticationOptions(
          stickyAuth: true, // Mantém o prompt de autenticação visível até ser fechado manualmente
          useErrorDialogs: true, // Mostra diálogos de erro se algo der errado
          sensitiveTransaction: true, // Indica que é uma transação sensível
        ),
        authMessages: const [
          androidStrings,
          // Se você não usará iOS, certifique-se de que não haja referências a IOSAuthMessages
        ],
      );
    } catch (e) {
      print("Erro durante a autenticação: $e");
      setState(() {
        _authorized = 'Erro na autenticação: $e';
      });
      return;
    }

    if (!mounted) return;

    setState(() {
      _authorized = authenticated ? 'Autorizado com Sucesso!' : 'Falha na Autenticação';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: pageName),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _authorized,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final canAuth = await _checkBiometrics();
                if (canAuth) {
                  await _getAvailableBiometrics(); // Opcional: apenas para mostrar quais tipos estão disponíveis
                  _authenticate();
                } else {
                  setState(() {
                    _authorized = 'Nenhuma biometria configurada ou disponível no dispositivo.';
                  });
                }
              },
              child: const Text('Autenticar com Biometria'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _authorized = 'Não autorizado';
                });
              },
              child: const Text('Resetar Status'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}